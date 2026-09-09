import os

import boto3
import uuid
import io




class S3Client(object):

    def __init__(self, region, access_key_id, secret_key, bucket_name):
        try:
            session = boto3.session.Session(aws_access_key_id=access_key_id,
                                            aws_secret_access_key=secret_key,
                                            region_name=region)
            self.bucket = session.resource('s3', region).Bucket(bucket_name)
        except Exception as ex:
            exit(ex)

    def upload_dataframe_as_csv(self, dataframe):

        csv_buffer = io.StringIO()
        dataframe.to_csv(csv_buffer, index=True)

        csv_key = "csv/" + str(uuid.uuid4()) + ".csv"
        self.bucket.put_object(Key=csv_key, Body=csv_buffer.getvalue())

        return csv_key

    def download_csv(self, csv_key, local_file_path):
        self.bucket.download_file(csv_key, local_file_path)

if __name__ == '__main__':


    AWS_REGION_NAME = 'us-east-2'
    AWS_S3_ACCESS_KEY_ID = 'REPLACE_WITH_AWS_S3_ACCESS_KEY_ID'
    AWS_S3_SECRET_ACCESS_KEY = 'REPLACE_WITH_AWS_S3_SECRET_ACCESS_KEY'
    AWS_S3_WQS_BUCKET = 'dzm-s3'

    s3_client = S3Client(AWS_REGION_NAME, AWS_S3_ACCESS_KEY_ID, AWS_S3_SECRET_ACCESS_KEY, AWS_S3_WQS_BUCKET)

    csv_key = 'csv/33afa619-f099-4974-8a74-6d6f4dc0a306.csv'

    dest_file_path = os.path.join(os.getcwd(), 'tmp.csv')
    s3_client.download_csv(csv_key, dest_file_path)



