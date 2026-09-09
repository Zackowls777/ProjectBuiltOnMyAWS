const SparkMD5 = require('spark-md5');

export function calculateFileBase64MD5(file) {
    return new Promise((resolve, reject) => {
        const chunkSize = 1024 * 1024; // 1MB
        const spark = new SparkMD5.ArrayBuffer();
        const fileSize = file.size;
        const chunkCount = Math.ceil(fileSize / chunkSize);

        let currentChunk = 0;

        function loadNextChunk() {
            const start = currentChunk * chunkSize;
            const end = Math.min(start + chunkSize, fileSize);
            const reader = new FileReader();
            const blob = file.slice(start, end);

            reader.onload = (e) => {
                spark.append(e.target.result); // 将当前分片加入 MD5 计算
                currentChunk++;

                if (currentChunk < chunkCount) {
                    loadNextChunk(); // 继续加载下一个分片
                } else {
                    const hex = spark.end();
                    const md5 = Buffer.from(hex, 'hex').toString("base64"); // 计算最终的 MD5 Base64
                    resolve(md5);
                }
            };

            reader.onerror = reject;
            reader.readAsArrayBuffer(blob);
        }

        loadNextChunk(); // 开始加载第一个分片
    });
}
