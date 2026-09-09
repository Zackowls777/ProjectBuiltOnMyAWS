import os
import boto3


def main():
    bucket = "aws-s3-stockstore-new"
    prefix = "seed/cover/"
    img_dir = r"D:\StockProject\ProjectBuiltOnMyAWS\images"

    s3 = boto3.client("s3", region_name="us-east-1")

    for i in range(1, 21):
        name = f"quant-{i:02d}.jpg"
        local_path = os.path.join(img_dir, name)
        key = prefix + name
        if not os.path.exists(local_path):
            print("skip missing:", local_path)
            continue
        s3.upload_file(
            local_path,
            bucket,
            key,
            ExtraArgs={"ContentType": "image/jpeg"},
        )
        print("uploaded:", key)


if __name__ == "__main__":
    main()
