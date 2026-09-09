import yfinance as yf

# 获取所有美股代码
tickers = yf.Tickers('^GSPC')  # 以标普500为例
print(tickers.tickers)