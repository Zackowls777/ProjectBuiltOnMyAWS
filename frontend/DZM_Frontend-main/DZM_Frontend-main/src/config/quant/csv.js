import {ColorConfig, SeriesTypeConfig} from "./chart";

export async function fetchCSV(url) {
    try {
        // 获取CSV文件内容
        const response = await fetch(url);
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        const data = await response.text(); // 获取文本内容
        return parseCSV(data); // 解析CSV数据
    } catch (error) {
        console.error('Fetching error:', error);
    }
}

function parseCSV(csvData) {
    const lines = csvData.trim().split('\n'); // 按行分割
    const result = [];
    const headers = lines[0].split(','); // 假设第一行是表头

    for (let i = 1; i < lines.length; i++) {
        const row = lines[i].split(','); // 分割每行的数据
        const obj = {};
        headers.forEach((header, index) => {
            obj[header] = row[index]; // 将数据分配到对象中
        });
        result.push(obj); // 将对象推入结果数组
    }
    return result; // 返回解析后的数组
}

function parseNumber(num) {
    try {
        const res = Number(num);
        if(res === NaN) {
            return num;
        }
        return res + 0.00001;
    } catch (e) {
        return num;
    }
}

function getFieldValues(data, field) {
    const result = [];
    for(const item of data) {
        result.push({"time": item.date.split(" ")[0], "value": parseNumber(item[field])})
    }
    return result;
}


function getFieldsValues(data, fields) {
    const result = [];
    for(const item of data) {
        let d = {"time": item.date.split(" ")[0]}
        for(const field of fields) {
            d[field] = parseNumber(item[field])
        }
        result.push(d);
    }
    return result;
}

function processVolumeData(data) {
    const result = [];
    let previousVolume = 0.0;
    for(let item of data) {
        let open = 0.0, close = item.value;
        if(item.value < previousVolume) {
            open = item.value; close = 0.0;
        }
        previousVolume = item.value;
        result.push({
            time: item.time,
            open: open, close: close, high: item.value, low: 0.0
        })
    }
    return result;
}

export function parseCSVDataInChartFormat(data) {
    let symbol = (data === null || data.length === 0) ? "": data[0].symbol;
    return {
        symbol: symbol,
        price: getFieldsValues(data, ['low', 'close', 'high', 'delta', 'open']),
        charts1: [
            {id: 'ma', name: 'MA', series: [
                    {name: 'MA5', type: SeriesTypeConfig.line, color: ColorConfig.ma5, data: getFieldValues(data, 'ma5')},
                    {name: 'MA10', type: SeriesTypeConfig.line, color: ColorConfig.ma10, data: getFieldValues(data, 'ma10')},
                    {name: 'MA20', type: SeriesTypeConfig.line, color: ColorConfig.ma20, data: getFieldValues(data, 'ma20')},
                    {name: 'MA60', type: SeriesTypeConfig.line, color: ColorConfig.ma60, data: getFieldValues(data, 'ma60')},
                ]},
            {id: 'boll', name: 'BOLL', series: [
                    {name: 'BBH', type: SeriesTypeConfig.line, color: ColorConfig.bbh, data: getFieldValues(data, 'bbh')},
                    {name: 'BBM', type: SeriesTypeConfig.line, color: ColorConfig.bbm, data: getFieldValues(data, 'bbm')},
                    {name: 'BBL', type: SeriesTypeConfig.line, color: ColorConfig.bbl, data: getFieldValues(data, 'bbl')},
                ]}
        ],
        charts2: [
            {id: 'macd', name: 'MACD', series:[
                    {name: 'MACD', type: SeriesTypeConfig.baseline, color: ColorConfig.macd, data: getFieldValues(data, 'macd'), base: 0.0, references: [0.0]},
                ]},
            {id: 'dif_dea', name: 'DIF/DEA', series:[
                    {name: 'MACD', type: SeriesTypeConfig.baseline, color: ColorConfig.macd, data: getFieldValues(data, 'macd'), base: 0.0, references: [0.0]},
                    {name: 'DIF', type: SeriesTypeConfig.line, color: ColorConfig.dif, data: getFieldValues(data, 'dif')},
                    {name: 'DEA', type: SeriesTypeConfig.line, color: ColorConfig.dea, data: getFieldValues(data, 'dea')},
                ]},
            {id: 'cci', name: 'CCI', series:[
                    {name: 'CCI', type: SeriesTypeConfig.line, color: ColorConfig.cci, data: getFieldValues(data, 'cci'), base: 0.0, references: [0.0]},
                ]},
            {id: 'volume', name: 'VOLUME', series:[
                    {name: 'VOLUME', type: SeriesTypeConfig.candlestick, color: ColorConfig.volume, data: processVolumeData(getFieldValues(data, 'volume'))},
                ]},
        ]
    }
}