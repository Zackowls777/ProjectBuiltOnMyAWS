import talib
import copy
import pandas_datareader as pdr
import numpy as np
import datetime

class IndicatorUtil:

    def indicators(self):
        self.__boll__()
        self.__ma__()
        self.__macd__()
        self.__cci__()
        return self.info

    def __init__(self, info):
        self.info = copy.deepcopy(info)

    def __boll__(self, timeperiod=20, nbdevup=2, nbdevdn=2):
        self.info['bbh'], self.info['bbm'], self.info['bbl'] = talib.BBANDS(self.info['close'].values, timeperiod=timeperiod,
                                                                            nbdevup=nbdevup, nbdevdn=nbdevdn, matype=0)

    def __ma__(self):
        self.info['ma5'] = talib.MA(self.info['close'].values, timeperiod=5)
        self.info['ma10'] = talib.MA(self.info['close'].values, timeperiod=10)
        self.info['ma20'] = talib.MA(self.info['close'].values, timeperiod=20)
        self.info['ma60'] = talib.MA(self.info['close'].values, timeperiod=60)

    def __macd__(self, fastperiod=12, slowperiod=26, signalperiod=9):
        self.info['dif'], self.info['dea'], self.info['macd'] = talib.MACD(self.info['close'].values, fastperiod, slowperiod,
                                                                           signalperiod)

    def __cci__(self, timeperiod=14):
        self.info['cci'] = talib.CCI(self.info['high'].values, self.info['low'].values, self.info['close'].values, timeperiod)


class TiingoClient:

    def __init__(self, tiingo_key, symbol, start_day, end_day):

        start_day = datetime.datetime.strptime(start_day, '%Y-%m-%d')
        end_day = datetime.datetime.strptime(end_day, '%Y-%m-%d')

        info = pdr.get_data_tiingo(
            symbols=symbol,
            start=start_day - datetime.timedelta(days=120),
            end=end_day,
            api_key=tiingo_key
        )
        info['close'], info['open'] = info['adjClose'], info['adjOpen']
        info['high'], info['low'] = info['adjHigh'], info['adjLow']
        info['volume'] = info['adjVolume']

        close = info['close'].values
        delta = np.array([0.0 if i == 0 else (close[i] / close[i - 1] - 1.0) for i in range(len(close))])
        info['delta'] = delta

        _redundant_info = copy.deepcopy(info)

        info = IndicatorUtil(_redundant_info).indicators()

        index = 0
        while index < info.shape[0]:
            timestamp = info.iloc[index].name[1]
            if timestamp.strftime("%Y-%m-%d") >= start_day.strftime("%Y-%m-%d"):
                break
            index += 1
        self._info = copy.deepcopy(info.iloc[index:])


    def info(self):
        return self._info



if __name__ == '__main__':

    # tiingo https://www.tiingo.com/
    TIINGO_KEY = "REPLACE_WITH_TIINGO_KEY"

    symbol = "SPY"
    tinggo_client = TiingoClient(tiingo_key=TIINGO_KEY, symbol=symbol, start_day='2024-1-1', end_day='2024-1-31')
    info = tinggo_client.info()

    AWS_REGION_NAME = 'us-east-2'
    AWS_S3_ACCESS_KEY_ID = 'REPLACE_WITH_AWS_S3_ACCESS_KEY_ID'
    AWS_S3_SECRET_ACCESS_KEY = 'REPLACE_WITH_AWS_S3_SECRET_ACCESS_KEY'
    AWS_S3_WQS_BUCKET = 'dzm-s3'

    from s3_client import S3Client
    s3_client = S3Client(AWS_REGION_NAME, AWS_S3_ACCESS_KEY_ID, AWS_S3_SECRET_ACCESS_KEY, AWS_S3_WQS_BUCKET)


    print(s3_client.upload_dataframe_as_csv(info))