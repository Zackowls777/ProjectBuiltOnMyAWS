INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('0dce2da8eb1b4219b2c47774dbef5d7a', 'a92f50fe93864c8eb27fb1a2de201b7e', 'QQQ', '2015-1-1', '2025-3-1', 'import numpy
import pandas
import os
import sys


fixed_investment_amount = 1000

latest_price = 0.0

logs = []


def calculate_commission(share, price):     
    return min(
            share * price * 0.01,
            max(1.99, share * 0.011)
        )
    

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    
    
    for i in range(len(df)):
        date = df.iloc[i][\'date\']       # 2015-01-05 00:00:00+00:00
        close = df.iloc[i][\'close\']
        
        date = "".join(date.split("-")[:2])
        latest_price = close
        
        if not log or log[-1][\'date\'] != date:
            
            share = fixed_investment_amount // close
            commission = calculate_commission(share, close)
            amount = share * close + commission
            
            logs.append({
                \'date\': date,
                \'share\': share,
                \'commission\': commission,
                \'amount\': amount
            })
            
    total_commission = sum([log[\'commission\'] for log in logs])
    total_amount = sum([log[\'amount\'] for log in logs])
    total_share = sum([log[\'share\'] for log in logs])
    
    print("total_amount (include commission)", "->", total_amount)
    print("total_commission", "->", total_commission)
    print("total_share", "->", total_share)
    
    print("profit", "->", total_share * latest_price - total_amount)
    print("profit rate", "->", (total_share * latest_price / total_amount - 1) * 100, "%" )', 4, 'Error: Traceback (most recent call last):
  File "/judger/run/7fa6408b-b292-412c-8026-471b71d948a1/solution.py", line 32, in <module>
    if not log or log[-1][\'date\'] != date:
NameError: name \'log\' is not defined', 1740838104956, 1740838104964);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('2ec5bcb43a5b4506abf21f707220df55', 'a92f50fe93864c8eb27fb1a2de201b7e', 'QQQ', '2015-1-1', '2025-3-8', 'import numpy
import pandas
import os
import sys


fixed_investment_amount = 1000

latest_price = 0.0

logs = []


def calculate_commission(share, price):     
    return min(
            share * price * 0.01,
            max(1.99, share * 0.011)
        )
    

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    
    
    for i in range(len(df)):
        date = df.iloc[i][\'date\']       # 2015-01-05 00:00:00+00:00
        close = df.iloc[i][\'close\']
        
        date = "".join(date.split("-")[:2])
        latest_price = close
        
        if not logs or logs[-1][\'date\'] != date:
            
            share = fixed_investment_amount // close
            commission = calculate_commission(share, close)
            amount = share * close + commission
            
            logs.append({
                \'date\': date,
                \'share\': share,
                \'commission\': commission,
                \'amount\': amount
            })
            
    total_commission = sum([log[\'commission\'] for log in logs])
    total_amount = sum([log[\'amount\'] for log in logs])
    total_share = sum([log[\'share\'] for log in logs])
    
    print("total_amount (include commission)", "->", round(total_amount, 2))
    print("total_commission", "->", round(total_commission, 2))
    print("total_share", "->", int(total_share))
    
    profit = total_share * latest_price - total_amount
    print("profit", "->", round(profit, 2))
    print("profit rate", "->", round(profit / total_amount * 100, 2), "%" )
    
    print("--------- logs ---------")
    for log in logs:
        print(log)', 0, 'total_amount (include commission) -> 108547.3
total_commission -> 244.77
total_share -> 602
profit -> 187510.28
profit rate -> 172.75 %
--------- logs ---------
{\'date\': \'201501\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 953.1071645989999}
{\'date\': \'201502\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 944.237216299}
{\'date\': \'201503\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 911.5477610013999}
{\'date\': \'201504\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 974.8210381660001}
{\'date\': \'201505\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 910.8762659758}
{\'date\': \'201506\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 922.2946445575}
{\'date\': \'201507\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 903.5385297652}
{\'date\': \'201508\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 934.2807331528}
{\'date\': \'201509\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 939.942793559}
{\'date\': \'201510\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 953.1446269790001}
{\'date\': \'201511\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 961.7889495043}
{\'date\': \'201512\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 966.3949125280001}
{\'date\': \'201601\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 921.8535870817}
{\'date\': \'201602\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 976.550701443}
{\'date\': \'201603\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 989.431591856}
{\'date\': \'201604\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 931.8221359786}
{\'date\': \'201605\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 1001.060572587}
{\'date\': \'201606\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 931.7378815264}
{\'date\': \'201607\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 915.063335335}
{\'date\': \'201608\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 980.6207842819}
{\'date\': \'201609\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 988.2240966595}
{\'date\': \'201610\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 894.465131776}
{\'date\': \'201611\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 985.3594516603}
{\'date\': \'201612\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 979.9391050147001}
{\'date\': \'201701\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 904.5888482367999}
{\'date\': \'201702\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 949.0618883584}
{\'date\': \'201703\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 994.4410006047999}
{\'date\': \'201704\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 877.8860902895001}
{\'date\': \'201705\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 910.3266862262}
{\'date\': \'201706\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 941.0459444196}
{\'date\': \'201707\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 906.1097608365999}
{\'date\': \'201708\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 955.0367065098}
{\'date\': \'201709\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 971.235048415}
{\'date\': \'201710\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 970.5675029874999}
{\'date\': \'201711\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 869.3813500936}
{\'date\': \'201712\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 883.0109709136}
{\'date\': \'201801\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 907.6988250832001}
{\'date\': \'201802\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 961.8161988826}
{\'date\': \'201803\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 941.9293497988}
{\'date\': \'201804\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 892.1400434541999}
{\'date\': \'201805\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 933.7540285096}
{\'date\': \'201806\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 990.7657604416002}
{\'date\': \'201807\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 993.2296183972}
{\'date\': \'201808\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 848.6738407145001}
{\'date\': \'201809\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 890.4057170100001}
{\'date\': \'201810\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 893.5312503924999}
{\'date\': \'201811\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 990.7545971482}
{\'date\': \'201812\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 992.306186368}
{\'date\': \'201901\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 894.6363211137999}
{\'date\': \'201902\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 967.0831461166001}
{\'date\': \'201903\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 839.5663598649999}
{\'date\': \'201904\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 877.8969565350001}
{\'date\': \'201905\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 911.0490051535}
{\'date\': \'201906\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 984.2529627274001}
{\'date\': \'201907\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 914.6481412770001}
{\'date\': \'201908\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 918.939939574}
{\'date\': \'201909\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 897.239835824}
{\'date\': \'201910\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 906.8729294395}
{\'date\': \'201911\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 962.9237757120001}
{\'date\': \'201912\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 982.879809773}
{\'date\': \'202001\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 839.3782355508}
{\'date\': \'202002\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 863.4740665328}
{\'date\': \'202003\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 840.3854567816}
{\'date\': \'202004\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 886.688111171}
{\'date\': \'202005\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 827.8829347616}
{\'date\': \'202006\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 910.6508080772}
{\'date\': \'202007\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 976.1069498332001}
{\'date\': \'202008\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 787.6729332888999}
{\'date\': \'202009\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 876.7469431732}
{\'date\': \'202010\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 826.4047636717}
{\'date\': \'202011\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 790.565723281}
{\'date\': \'202012\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 888.3563567185}
{\'date\': \'202101\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 907.0850700403}
{\'date\': \'202102\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 945.4472192377}
{\'date\': \'202103\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 948.8708435368001}
{\'date\': \'202104\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 952.9150011588999}
{\'date\': \'202105\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 986.9592705412001}
{\'date\': \'202106\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 977.0858464606}
{\'date\': \'202107\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 695.3339778922}
{\'date\': \'202108\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 714.9471434116}
{\'date\': \'202109\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 746.1952376291999}
{\'date\': \'202110\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 707.101216852}
{\'date\': \'202111\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 760.4475455188001}
{\'date\': \'202112\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 759.8406698532001}
{\'date\': \'202201\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 789.3593072686}
{\'date\': \'202202\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 718.4788199384}
{\'date\': \'202203\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 671.3754429874}
{\'date\': \'202204\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 712.1636175444}
{\'date\': \'202205\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 939.5722594261001}
{\'date\': \'202206\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 902.8320352435001}
{\'date\': \'202207\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 834.118896364}
{\'date\': \'202208\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 931.8637360672001}
{\'date\': \'202209\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 885.0559326244}
{\'date\': \'202210\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 810.1910092845999}
{\'date\': \'202211\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 814.8594463653999}
{\'date\': \'202212\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 869.8465438786}
{\'date\': \'202301\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 785.3496218287}
{\'date\': \'202302\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 893.2807493977}
{\'date\': \'202303\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 864.4912170163}
{\'date\': \'202304\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 951.7013310721001}
{\'date\': \'202305\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 957.7529041327}
{\'date\': \'202306\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 698.13844219}
{\'date\': \'202307\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 735.2955087374}
{\'date\': \'202308\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 760.0499413692}
{\'date\': \'202309\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 749.7520973942}
{\'date\': \'202310\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 718.4529584932001}
{\'date\': \'202311\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 709.9250541542}
{\'date\': \'202312\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 775.3320972012}
{\'date\': \'202401\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 802.4249138710001}
{\'date\': \'202402\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 840.777554246}
{\'date\': \'202403\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 887.957863012}
{\'date\': \'202404\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 887.8052511096}
{\'date\': \'202405\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 841.1603441908001}
{\'date\': \'202406\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 904.090156726}
{\'date\': \'202407\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 962.9473276598}
{\'date\': \'202408\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 918.5604789842}
{\'date\': \'202409\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 922.8476184564}
{\'date\': \'202410\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 962.9959414022001}
{\'date\': \'202411\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 975.2963062682}
{\'date\': \'202412\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 516.4587509559}
{\'date\': \'202501\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 512.22}
{\'date\': \'202502\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 520.1}
{\'date\': \'202503\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 996.09}', 1741486647829, 1741486647833);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('317ce81b23d7457fa405f79a0eef6ef3', 'a92f50fe93864c8eb27fb1a2de201b7e', 'QQQ', '2015-1-1', '2025-3-8', 'import numpy
import pandas
import os
import sys


fixed_investment_amount = 1000

latest_price = 0.0

logs = []


def calculate_commission(share, price):     
    return min(
            share * price * 0.01,
            max(1.99, share * 0.011)
        )
    

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    
    
    for i in range(len(df)):
        date = df.iloc[i][\'date\']       # 2015-01-05 00:00:00+00:00
        close = df.iloc[i][\'close\']
        
        date = "".join(date.split("-")[:2])
        latest_price = close
        
        if not logs or logs[-1][\'date\'] != date:
            
            share = fixed_investment_amount // close
            commission = calculate_commission(share, close)
            amount = share * close + commission
            
            logs.append({
                \'date\': date,
                \'share\': share,
                \'commission\': commission,
                \'amount\': amount
            })
            
    total_commission = sum([log[\'commission\'] for log in logs])
    total_amount = sum([log[\'amount\'] for log in logs])
    total_share = sum([log[\'share\'] for log in logs])
    
    print("total_amount (include commission)", "->", round(total_amount, 2))
    print("total_commission", "->", round(total_commission, 2))
    print("total_share", "->", int(total_share))
    
    profit = total_share * latest_price - total_amount
    print("profit", "->", round(profit, 2))
    print("profit rate", "->", round(profit / total_amount * 100, 2), "%" )
    
    print("--------- logs ---------")
    for log in logs:
        print(log)', 0, 'total_amount (include commission) -> 108547.3
total_commission -> 244.77
total_share -> 602
profit -> 187510.28
profit rate -> 172.75 %
--------- logs ---------
{\'date\': \'201501\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 953.1071645989999}
{\'date\': \'201502\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 944.237216299}
{\'date\': \'201503\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 911.5477610013999}
{\'date\': \'201504\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 974.8210381660001}
{\'date\': \'201505\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 910.8762659758}
{\'date\': \'201506\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 922.2946445575}
{\'date\': \'201507\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 903.5385297652}
{\'date\': \'201508\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 934.2807331528}
{\'date\': \'201509\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 939.942793559}
{\'date\': \'201510\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 953.1446269790001}
{\'date\': \'201511\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 961.7889495043}
{\'date\': \'201512\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 966.3949125280001}
{\'date\': \'201601\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 921.8535870817}
{\'date\': \'201602\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 976.550701443}
{\'date\': \'201603\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 989.431591856}
{\'date\': \'201604\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 931.8221359786}
{\'date\': \'201605\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 1001.060572587}
{\'date\': \'201606\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 931.7378815264}
{\'date\': \'201607\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 915.063335335}
{\'date\': \'201608\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 980.6207842819}
{\'date\': \'201609\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 988.2240966595}
{\'date\': \'201610\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 894.465131776}
{\'date\': \'201611\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 985.3594516603}
{\'date\': \'201612\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 979.9391050147001}
{\'date\': \'201701\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 904.5888482367999}
{\'date\': \'201702\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 949.0618883584}
{\'date\': \'201703\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 994.4410006047999}
{\'date\': \'201704\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 877.8860902895001}
{\'date\': \'201705\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 910.3266862262}
{\'date\': \'201706\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 941.0459444196}
{\'date\': \'201707\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 906.1097608365999}
{\'date\': \'201708\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 955.0367065098}
{\'date\': \'201709\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 971.235048415}
{\'date\': \'201710\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 970.5675029874999}
{\'date\': \'201711\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 869.3813500936}
{\'date\': \'201712\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 883.0109709136}
{\'date\': \'201801\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 907.6988250832001}
{\'date\': \'201802\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 961.8161988826}
{\'date\': \'201803\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 941.9293497988}
{\'date\': \'201804\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 892.1400434541999}
{\'date\': \'201805\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 933.7540285096}
{\'date\': \'201806\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 990.7657604416002}
{\'date\': \'201807\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 993.2296183972}
{\'date\': \'201808\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 848.6738407145001}
{\'date\': \'201809\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 890.4057170100001}
{\'date\': \'201810\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 893.5312503924999}
{\'date\': \'201811\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 990.7545971482}
{\'date\': \'201812\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 992.306186368}
{\'date\': \'201901\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 894.6363211137999}
{\'date\': \'201902\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 967.0831461166001}
{\'date\': \'201903\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 839.5663598649999}
{\'date\': \'201904\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 877.8969565350001}
{\'date\': \'201905\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 911.0490051535}
{\'date\': \'201906\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 984.2529627274001}
{\'date\': \'201907\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 914.6481412770001}
{\'date\': \'201908\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 918.939939574}
{\'date\': \'201909\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 897.239835824}
{\'date\': \'201910\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 906.8729294395}
{\'date\': \'201911\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 962.9237757120001}
{\'date\': \'201912\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 982.879809773}
{\'date\': \'202001\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 839.3782355508}
{\'date\': \'202002\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 863.4740665328}
{\'date\': \'202003\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 840.3854567816}
{\'date\': \'202004\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 886.688111171}
{\'date\': \'202005\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 827.8829347616}
{\'date\': \'202006\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 910.6508080772}
{\'date\': \'202007\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 976.1069498332001}
{\'date\': \'202008\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 787.6729332888999}
{\'date\': \'202009\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 876.7469431732}
{\'date\': \'202010\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 826.4047636717}
{\'date\': \'202011\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 790.565723281}
{\'date\': \'202012\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 888.3563567185}
{\'date\': \'202101\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 907.0850700403}
{\'date\': \'202102\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 945.4472192377}
{\'date\': \'202103\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 948.8708435368001}
{\'date\': \'202104\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 952.9150011588999}
{\'date\': \'202105\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 986.9592705412001}
{\'date\': \'202106\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 977.0858464606}
{\'date\': \'202107\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 695.3339778922}
{\'date\': \'202108\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 714.9471434116}
{\'date\': \'202109\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 746.1952376291999}
{\'date\': \'202110\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 707.101216852}
{\'date\': \'202111\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 760.4475455188001}
{\'date\': \'202112\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 759.8406698532001}
{\'date\': \'202201\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 789.3593072686}
{\'date\': \'202202\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 718.4788199384}
{\'date\': \'202203\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 671.3754429874}
{\'date\': \'202204\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 712.1636175444}
{\'date\': \'202205\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 939.5722594261001}
{\'date\': \'202206\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 902.8320352435001}
{\'date\': \'202207\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 834.118896364}
{\'date\': \'202208\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 931.8637360672001}
{\'date\': \'202209\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 885.0559326244}
{\'date\': \'202210\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 810.1910092845999}
{\'date\': \'202211\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 814.8594463653999}
{\'date\': \'202212\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 869.8465438786}
{\'date\': \'202301\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 785.3496218287}
{\'date\': \'202302\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 893.2807493977}
{\'date\': \'202303\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 864.4912170163}
{\'date\': \'202304\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 951.7013310721001}
{\'date\': \'202305\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 957.7529041327}
{\'date\': \'202306\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 698.13844219}
{\'date\': \'202307\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 735.2955087374}
{\'date\': \'202308\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 760.0499413692}
{\'date\': \'202309\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 749.7520973942}
{\'date\': \'202310\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 718.4529584932001}
{\'date\': \'202311\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 709.9250541542}
{\'date\': \'202312\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 775.3320972012}
{\'date\': \'202401\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 802.4249138710001}
{\'date\': \'202402\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 840.777554246}
{\'date\': \'202403\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 887.957863012}
{\'date\': \'202404\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 887.8052511096}
{\'date\': \'202405\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 841.1603441908001}
{\'date\': \'202406\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 904.090156726}
{\'date\': \'202407\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 962.9473276598}
{\'date\': \'202408\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 918.5604789842}
{\'date\': \'202409\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 922.8476184564}
{\'date\': \'202410\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 962.9959414022001}
{\'date\': \'202411\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 975.2963062682}
{\'date\': \'202412\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 516.4587509559}
{\'date\': \'202501\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 512.22}
{\'date\': \'202502\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 520.1}
{\'date\': \'202503\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 996.09}', 1741484751566, 1741484751569);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('3d66e8646d7240ce98ec39e64243c795', 'a92f50fe93864c8eb27fb1a2de201b7e', 'QQQ', '2015-1-1', '2025-3-1', 'import numpy
import pandas
import os
import sys


fixed_investment_amount = 1000

latest_price = 0.0

logs = []


def calculate_commission(share, price):     
    return min(
            share * price * 0.01,
            max(1.99, share * 0.011)
        )
    

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    
    
    for i in range(len(df)):
        date = df.iloc[i][\'date\']       # 2015-01-05 00:00:00+00:00
        close = df.iloc[i][\'close\']
        
        date = "".join(date.split("-")[:2])
        latest_price = close
        
        if not logs or logs[-1][\'date\'] != date:
            
            share = fixed_investment_amount // close
            commission = calculate_commission(share, close)
            amount = share * close + commission
            
            logs.append({
                \'date\': date,
                \'share\': share,
                \'commission\': commission,
                \'amount\': amount
            })
            
    total_commission = sum([log[\'commission\'] for log in logs])
    total_amount = sum([log[\'amount\'] for log in logs])
    total_share = sum([log[\'share\'] for log in logs])
    
    print("total_amount (include commission)", "->", round(total_amount, 2))
    print("total_commission", "->", round(total_commission, 2))
    print("total_share", "->", int(total_share))
    
    profit = total_share * latest_price - total_amount
    print("profit", "->", round(profit, 2))
    print("profit rate", "->", round(profit / total_amount * 100, 2), "%" )', -2, null, 1740838479407, 1740838479411);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('40b02addb4814abaa556a6b26527e38e', 'a92f50fe93864c8eb27fb1a2de201b7e', 'SPY', '2014-01-01', '2025-03-08', 'import numpy
import pandas
import os
import sys


fixed_investment_amount = 1000

latest_price = 0.0

logs = []


def calculate_commission(share, price):     
    return min(
            share * price * 0.01,
            max(1.99, share * 0.011)
        )
    

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    
    
    for i in range(len(df)):
        date = df.iloc[i][\'date\']       # 2015-01-05 00:00:00+00:00
        close = df.iloc[i][\'close\']
        
        date = "".join(date.split("-")[:2])
        latest_price = close
        
        if not logs or logs[-1][\'date\'] != date:
            
            share = fixed_investment_amount // close
            commission = calculate_commission(share, close)
            amount = share * close + commission
            
            logs.append({
                \'date\': date,
                \'share\': share,
                \'commission\': commission,
                \'amount\': amount
            })
            
    total_commission = sum([log[\'commission\'] for log in logs])
    total_amount = sum([log[\'amount\'] for log in logs])
    total_share = sum([log[\'share\'] for log in logs])
    
    print("total_amount (include commission)", "->", round(total_amount, 2))
    print("total_commission", "->", round(total_commission, 2))
    print("total_share", "->", int(total_share))
    
    profit = total_share * latest_price - total_amount
    print("profit", "->", round(profit, 2))
    print("profit rate", "->", round(profit / total_amount * 100, 2), "%" )
    
    print("--------- logs ---------")
    for log in logs:
        print(log)', 0, 'total_amount (include commission) -> 113473.93
total_commission -> 268.65
total_share -> 449
profit -> 145114.15
profit rate -> 127.88 %
--------- logs ---------
{\'date\': \'201401\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 905.612052259}
{\'date\': \'201402\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 862.3871836972}
{\'date\': \'201403\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 915.7884213148}
{\'date\': \'201404\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 936.0605817574001}
{\'date\': \'201405\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 936.4575307432}
{\'date\': \'201406\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 959.1332415460001}
{\'date\': \'201407\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 984.2993147116001}
{\'date\': \'201408\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 961.7146261078001}
{\'date\': \'201409\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 835.4547499715}
{\'date\': \'201410\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 975.4722149122}
{\'date\': \'201411\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 844.1969569625}
{\'date\': \'201412\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 860.8515922315}
{\'date\': \'201501\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 864.1864010315}
{\'date\': \'201502\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 849.4548167075}
{\'date\': \'201503\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 891.7189346959999}
{\'date\': \'201504\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 869.138790096}
{\'date\': \'201505\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 890.3010989254999}
{\'date\': \'201506\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 893.884358389}
{\'date\': \'201507\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 881.2975843295001}
{\'date\': \'201508\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 890.44777165}
{\'date\': \'201509\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 976.8407902696}
{\'date\': \'201510\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 983.8373473270001}
{\'date\': \'201511\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 897.958282778}
{\'date\': \'201512\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 899.1932787475}
{\'date\': \'201601\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 863.2404643365}
{\'date\': \'201602\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 997.5992563876}
{\'date\': \'201603\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 850.7728422835}
{\'date\': \'201604\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 893.0712212955}
{\'date\': \'201605\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 897.592958994}
{\'date\': \'201606\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 907.497702383}
{\'date\': \'201607\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 910.711101319}
{\'date\': \'201608\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 941.0999438629999}
{\'date\': \'201609\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 943.0479324935}
{\'date\': \'201610\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 940.8154789485001}
{\'date\': \'201611\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 920.0619275969999}
{\'date\': \'201612\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 957.3052189255}
{\'date\': \'201701\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 987.7616135825001}
{\'date\': \'201702\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 998.1777320805}
{\'date\': \'201703\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 841.5151687872}
{\'date\': \'201704\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 829.5259433432001}
{\'date\': \'201705\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 841.3061581003999}
{\'date\': \'201706\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 857.7633662856}
{\'date\': \'201707\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 857.8724385924}
{\'date\': \'201708\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 875.9293030639999}
{\'date\': \'201709\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 877.7667947252}
{\'date\': \'201710\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 898.0148259855999}
{\'date\': \'201711\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 916.374243988}
{\'date\': \'201712\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 941.1257224164}
{\'date\': \'201801\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 961.270628548}
{\'date\': \'201802\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 755.7410865793}
{\'date\': \'201803\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 957.4516373192}
{\'date\': \'201804\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 924.6149557276}
{\'date\': \'201805\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 951.526492674}
{\'date\': \'201806\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 982.415633616}
{\'date\': \'201807\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 980.5591075172}
{\'date\': \'201808\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 760.2136800301}
{\'date\': \'201809\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 784.3755469255}
{\'date\': \'201810\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 793.1262524245001}
{\'date\': \'201811\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 990.9577734008001}
{\'date\': \'201812\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 759.4176053275}
{\'date\': \'201901\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 911.9948686072}
{\'date\': \'201902\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 984.3063914624}
{\'date\': \'201903\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 766.9898958397}
{\'date\': \'201904\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 785.1666585424}
{\'date\': \'201905\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 801.5519099787999}
{\'date\': \'201906\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 754.3141616905}
{\'date\': \'201907\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 816.0456874009}
{\'date\': \'201908\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 813.7879397731001}
{\'date\': \'201909\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 802.4992016335}
{\'date\': \'201910\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 813.1277968398999}
{\'date\': \'201911\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 848.8107786268}
{\'date\': \'201912\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 864.0244530322002}
{\'date\': \'202001\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 905.0191250518001}
{\'date\': \'202002\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 902.9343777874001}
{\'date\': \'202003\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 861.1560426087999}
{\'date\': \'202004\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 919.8797340188}
{\'date\': \'202005\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 792.8798168287001}
{\'date\': \'202006\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 856.5335960677}
{\'date\': \'202007\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 874.2776858308}
{\'date\': \'202008\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 925.6002931351}
{\'date\': \'202009\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 992.4854206617999}
{\'date\': \'202010\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 952.6102697017}
{\'date\': \'202011\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 933.3180710167}
{\'date\': \'202012\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 690.2288462619999}
{\'date\': \'202101\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 698.4051487556}
{\'date\': \'202102\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 712.4546856375999}
{\'date\': \'202103\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 737.6645401236}
{\'date\': \'202104\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 760.9752575069999}
{\'date\': \'202105\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 794.3008127342}
{\'date\': \'202106\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 797.0858363944001}
{\'date\': \'202107\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 820.1755888022}
{\'date\': \'202108\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 833.7857201032001}
{\'date\': \'202109\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 860.7968885088001}
{\'date\': \'202110\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 830.0884620714}
{\'date\': \'202111\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 879.2892273658}
{\'date\': \'202112\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 861.0963862453999}
{\'date\': \'202201\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 916.221941485}
{\'date\': \'202202\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 868.836743622}
{\'date\': \'202203\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 824.877212325}
{\'date\': \'202204\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 871.4429719556}
{\'date\': \'202205\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 797.6511936239999}
{\'date\': \'202206\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 788.2640501266001}
{\'date\': \'202207\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 736.9959632092}
{\'date\': \'202208\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 793.9278856034}
{\'date\': \'202209\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 766.2620174572}
{\'date\': \'202210\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 711.7167556155999}
{\'date\': \'202211\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 746.3890400408001}
{\'date\': \'202212\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 790.6441166436}
{\'date\': \'202301\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 742.6527435378}
{\'date\': \'202302\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 800.9613120248}
{\'date\': \'202303\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 769.7259681322}
{\'date\': \'202304\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 804.3399315917999}
{\'date\': \'202305\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 813.2429993324}
{\'date\': \'202306\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 825.5628145614}
{\'date\': \'202307\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 871.6879486358}
{\'date\': \'202308\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 896.5566184306}
{\'date\': \'202309\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 886.1897734176}
{\'date\': \'202310\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 842.3821565966}
{\'date\': \'202311\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 833.2369844074001}
{\'date\': \'202312\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 904.9036671117999}
{\'date\': \'202401\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 935.3277008612}
{\'date\': \'202402\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 968.0088369010001}
{\'date\': \'202403\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 508.3501395183}
{\'date\': \'202404\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 519.1551646752}
{\'date\': \'202405\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 993.1175859706}
{\'date\': \'202406\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 524.7412140255001}
{\'date\': \'202407\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 543.8582846465}
{\'date\': \'202408\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 541.5431177723001}
{\'date\': \'202409\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 550.5553768065}
{\'date\': \'202410\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 568.725628721}
{\'date\': \'202411\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 571.1376089917}
{\'date\': \'202412\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 603.6196077607}
{\'date\': \'202501\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 586.63}
{\'date\': \'202502\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 599.76}
{\'date\': \'202503\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 585.76}', 1741486760814, 1741486760817);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('49a6f643dd884db8b1c5b003ddc8646f', 'a92f50fe93864c8eb27fb1a2de201b7e', 'QQQ', '2015-1-1', '2025-3-1', 'import numpy
import pandas
import os
import sys

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    print(df.head())
    print(df.ilco[1])
    print(df.ilco[1][\'close\'])', 4, 'symbol                       date      close  ...       dea      macd         cci
0    QQQ  2015-01-02 00:00:00+00:00  95.111716  ...  0.430448 -0.105756  -14.444698
1    QQQ  2015-01-05 00:00:00+00:00  93.716548  ...  0.370245 -0.240814  -87.045713
2    QQQ  2015-01-06 00:00:00+00:00  92.459971  ...  0.271143 -0.396409 -135.035562
3    QQQ  2015-01-07 00:00:00+00:00  93.651871  ...  0.171253 -0.399560 -110.563182
4    QQQ  2015-01-08 00:00:00+00:00  95.444340  ...  0.104313 -0.267760  -30.106202

[5 rows x 26 columns]


Error: Traceback (most recent call last):
  File "/judger/run/8729e9bc-40db-4b9a-b593-5de95fcdb657/solution.py", line 9, in <module>
    print(df.ilco[1])
  File "/usr/local/lib/python3.6/dist-packages/pandas/core/generic.py", line 5141, in __getattr__
    return object.__getattribute__(self, name)
AttributeError: \'DataFrame\' object has no attribute \'ilco\'', 1740836616943, 1740836616948);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('4f86fb643516446b96968a76df24a4d9', 'a92f50fe93864c8eb27fb1a2de201b7e', 'QQQ', '2024-1-1', '2025-1-22', 'import numpy
import pandas
import os
import sys

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    print(df.head())
', -3, null, 1740245082892, 1740245082978);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('51309437f46f4543bdd865f900803a81', 'a92f50fe93864c8eb27fb1a2de201b7e', 'QQQ', '2015-1-1', '2025-1-22', 'import numpy
import pandas
import os
import sys

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    print(df.head())', 0, 'symbol                       date      close  ...       dea      macd         cci
0    QQQ  2015-01-02 00:00:00+00:00  95.111716  ...  0.430448 -0.105756  -14.444698
1    QQQ  2015-01-05 00:00:00+00:00  93.716548  ...  0.370245 -0.240814  -87.045713
2    QQQ  2015-01-06 00:00:00+00:00  92.459971  ...  0.271143 -0.396409 -135.035562
3    QQQ  2015-01-07 00:00:00+00:00  93.651871  ...  0.171253 -0.399560 -110.563182
4    QQQ  2015-01-08 00:00:00+00:00  95.444340  ...  0.104313 -0.267760  -30.106202

[5 rows x 26 columns]


Error:', 1740246490729, 1740246490735);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('59c99d053dc04a03b4d7807d25fb8eb2', 'a92f50fe93864c8eb27fb1a2de201b7e', 'QQQ', '2015-1-1', '2025-1-23', 'import numpy
import pandas
import os
import sys

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    print(df.head())', 0, 'symbol                       date      close  ...       dea      macd         cci
0    QQQ  2015-01-02 00:00:00+00:00  95.111716  ...  0.430448 -0.105756  -14.444698
1    QQQ  2015-01-05 00:00:00+00:00  93.716548  ...  0.370245 -0.240814  -87.045713
2    QQQ  2015-01-06 00:00:00+00:00  92.459971  ...  0.271143 -0.396409 -135.035562
3    QQQ  2015-01-07 00:00:00+00:00  93.651871  ...  0.171253 -0.399560 -110.563182
4    QQQ  2015-01-08 00:00:00+00:00  95.444340  ...  0.104313 -0.267760  -30.106202

[5 rows x 26 columns]', 1740303453001, 1740303453006);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('6669395b54774e14a6d3b5894c1d5d8d', 'a92f50fe93864c8eb27fb1a2de201b7e', 'QQQ', '2024-1-1', '2025-1-22', 'import numpy
import pandas
import os
import sys

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    print(df.head())', 4, '', 1740245446590, 1740245446601);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('716bc4d760234d4d84c6de778cdab583', 'a92f50fe93864c8eb27fb1a2de201b7e', 'NVDA', '2015-1-1', '2025-1-22', 'import numpy
import pandas
import os
import sys

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    print(df.head())', 0, 'symbol                       date     close  ...       dea      macd         cci
0   NVDA  2015-01-02 00:00:00+00:00  0.483229  ...  0.002975 -0.001342  -34.122991
1   NVDA  2015-01-05 00:00:00+00:00  0.475067  ...  0.002475 -0.001997  -73.495424
2   NVDA  2015-01-06 00:00:00+00:00  0.460664  ...  0.001664 -0.003245 -155.579568
3   NVDA  2015-01-07 00:00:00+00:00  0.459343  ...  0.000675 -0.003956 -171.430989
4   NVDA  2015-01-08 00:00:00+00:00  0.476747  ... -0.000097 -0.003090  -81.820345

[5 rows x 26 columns]', 1740247765024, 1740247765032);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('7178c0a085284ee9bab46a39b56f70ec', 'a92f50fe93864c8eb27fb1a2de201b7e', 'QQQ', '2015-1-1', '2025-3-1', 'import numpy
import pandas
import os
import sys

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    print(df.head())
    print(df.iloc[1])
    print(df.iloc[1][\'close\'])', 0, 'symbol                       date      close  ...       dea      macd         cci
0    QQQ  2015-01-02 00:00:00+00:00  95.111716  ...  0.430448 -0.105756  -14.444698
1    QQQ  2015-01-05 00:00:00+00:00  93.716548  ...  0.370245 -0.240814  -87.045713
2    QQQ  2015-01-06 00:00:00+00:00  92.459971  ...  0.271143 -0.396409 -135.035562
3    QQQ  2015-01-07 00:00:00+00:00  93.651871  ...  0.171253 -0.399560 -110.563182
4    QQQ  2015-01-08 00:00:00+00:00  95.444340  ...  0.104313 -0.267760  -30.106202

[5 rows x 26 columns]
symbol                               QQQ
date           2015-01-05 00:00:00+00:00
close                            93.7165
high                             94.8068
low                              93.4486
open                             94.6959
volume                          36521270
adjClose                         93.7165
adjHigh                          94.8068
adjLow                           93.4486
adjOpen                          94.6959
adjVolume                       36521270
divCash                                0
splitFactor                            1
delta                         -0.0146687
bbh                              98.2525
bbm                              95.5361
bbl                              92.8197
ma5                              95.5293
ma10                             96.0366
ma20                             95.5361
ma60                             93.4957
dif                             0.129431
dea                             0.370245
macd                           -0.240814
cci                             -87.0457
Name: 1, dtype: object
93.7165475086', 1740836841757, 1740836841761);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('738c21bb11104c0e9150ad4cde762766', 'a92f50fe93864c8eb27fb1a2de201b7e', 'QQQ', '2015-1-1', '2025-3-1', 'import numpy
import pandas
import os
import sys


fixed_investment_amount = 1000

latest_price = 0.0

logs = []


def calculate_commission(share, price):     
    return min(
            share * price * 0.01,
            max(1.99, share * 0.011)
        )
    

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    
    
    for i in range(len(df)):
        date = df.iloc[i][\'date\']       # 2015-01-05 00:00:00+00:00
        close = df.iloc[i][\'close\']
        
        date = "".join(date.split("-")[:2])
        latest_price = close
        
        if not logs or logs[-1][\'date\'] != date:
            
            share = fixed_investment_amount // close
            commission = calculate_commission(share, close)
            amount = share * close + commission
            
            logs.append({
                \'date\': date,
                \'share\': share,
                \'commission\': commission,
                \'amount\': amount
            })
            
    total_commission = sum([log[\'commission\'] for log in logs])
    total_amount = sum([log[\'amount\'] for log in logs])
    total_share = sum([log[\'share\'] for log in logs])
    
    print("total_amount (include commission)", "->", round(total_amount, 2))
    print("total_commission", "->", round(total_commission, 2))
    print("total_share", "->", int(total_share))
    
    profit = total_share * latest_price - total_amount
    print("profit", "->", round(profit, 2))
    print("profit rate", "->", round(profit / total_amount * 100, 2), "%" )
    
    print("--------- logs ---------")
    for log in logs:
        print(log)', 0, 'total_amount (include commission) -> 107551.21
total_commission -> 242.78
total_share -> 600
profit -> 197350.79
profit rate -> 183.49 %
--------- logs ---------
{\'date\': \'201501\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 953.1071645989999}
{\'date\': \'201502\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 944.237216299}
{\'date\': \'201503\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 911.5477610013999}
{\'date\': \'201504\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 974.8210381660001}
{\'date\': \'201505\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 910.8762659758}
{\'date\': \'201506\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 922.2946445575}
{\'date\': \'201507\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 903.5385297652}
{\'date\': \'201508\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 934.2807331528}
{\'date\': \'201509\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 939.942793559}
{\'date\': \'201510\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 953.1446269790001}
{\'date\': \'201511\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 961.7889495043}
{\'date\': \'201512\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 966.3949125280001}
{\'date\': \'201601\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 921.8535870817}
{\'date\': \'201602\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 976.550701443}
{\'date\': \'201603\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 989.431591856}
{\'date\': \'201604\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 931.8221359786}
{\'date\': \'201605\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 1001.060572587}
{\'date\': \'201606\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 931.7378815264}
{\'date\': \'201607\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 915.063335335}
{\'date\': \'201608\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 980.6207842819}
{\'date\': \'201609\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 988.2240966595}
{\'date\': \'201610\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 894.465131776}
{\'date\': \'201611\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 985.3594516603}
{\'date\': \'201612\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 979.9391050147001}
{\'date\': \'201701\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 904.5888482367999}
{\'date\': \'201702\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 949.0618883584}
{\'date\': \'201703\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 994.4410006047999}
{\'date\': \'201704\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 877.8860902895001}
{\'date\': \'201705\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 910.3266862262}
{\'date\': \'201706\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 941.0459444196}
{\'date\': \'201707\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 906.1097608365999}
{\'date\': \'201708\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 955.0367065098}
{\'date\': \'201709\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 971.235048415}
{\'date\': \'201710\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 970.5675029874999}
{\'date\': \'201711\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 869.3813500936}
{\'date\': \'201712\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 883.0109709136}
{\'date\': \'201801\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 907.6988250832001}
{\'date\': \'201802\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 961.8161988826}
{\'date\': \'201803\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 941.9293497988}
{\'date\': \'201804\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 892.1400434541999}
{\'date\': \'201805\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 933.7540285096}
{\'date\': \'201806\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 990.7657604416002}
{\'date\': \'201807\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 993.2296183972}
{\'date\': \'201808\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 848.6738407145001}
{\'date\': \'201809\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 890.4057170100001}
{\'date\': \'201810\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 893.5312503924999}
{\'date\': \'201811\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 990.7545971482}
{\'date\': \'201812\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 992.306186368}
{\'date\': \'201901\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 894.6363211137999}
{\'date\': \'201902\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 967.0831461166001}
{\'date\': \'201903\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 839.5663598649999}
{\'date\': \'201904\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 877.8969565350001}
{\'date\': \'201905\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 911.0490051535}
{\'date\': \'201906\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 984.2529627274001}
{\'date\': \'201907\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 914.6481412770001}
{\'date\': \'201908\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 918.939939574}
{\'date\': \'201909\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 897.239835824}
{\'date\': \'201910\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 906.8729294395}
{\'date\': \'201911\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 962.9237757120001}
{\'date\': \'201912\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 982.879809773}
{\'date\': \'202001\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 839.3782355508}
{\'date\': \'202002\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 863.4740665328}
{\'date\': \'202003\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 840.3854567816}
{\'date\': \'202004\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 886.688111171}
{\'date\': \'202005\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 827.8829347616}
{\'date\': \'202006\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 910.6508080772}
{\'date\': \'202007\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 976.1069498332001}
{\'date\': \'202008\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 787.6729332888999}
{\'date\': \'202009\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 876.7469431732}
{\'date\': \'202010\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 826.4047636717}
{\'date\': \'202011\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 790.565723281}
{\'date\': \'202012\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 888.3563567185}
{\'date\': \'202101\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 907.0850700403}
{\'date\': \'202102\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 945.4472192377}
{\'date\': \'202103\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 948.8708435368001}
{\'date\': \'202104\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 952.9150011588999}
{\'date\': \'202105\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 986.9592705412001}
{\'date\': \'202106\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 977.0858464606}
{\'date\': \'202107\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 695.3339778922}
{\'date\': \'202108\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 714.9471434116}
{\'date\': \'202109\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 746.1952376291999}
{\'date\': \'202110\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 707.101216852}
{\'date\': \'202111\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 760.4475455188001}
{\'date\': \'202112\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 759.8406698532001}
{\'date\': \'202201\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 789.3593072686}
{\'date\': \'202202\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 718.4788199384}
{\'date\': \'202203\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 671.3754429874}
{\'date\': \'202204\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 712.1636175444}
{\'date\': \'202205\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 939.5722594261001}
{\'date\': \'202206\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 902.8320352435001}
{\'date\': \'202207\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 834.118896364}
{\'date\': \'202208\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 931.8637360672001}
{\'date\': \'202209\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 885.0559326244}
{\'date\': \'202210\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 810.1910092845999}
{\'date\': \'202211\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 814.8594463653999}
{\'date\': \'202212\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 869.8465438786}
{\'date\': \'202301\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 785.3496218287}
{\'date\': \'202302\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 893.2807493977}
{\'date\': \'202303\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 864.4912170163}
{\'date\': \'202304\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 951.7013310721001}
{\'date\': \'202305\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 957.7529041327}
{\'date\': \'202306\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 698.13844219}
{\'date\': \'202307\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 735.2955087374}
{\'date\': \'202308\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 760.0499413692}
{\'date\': \'202309\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 749.7520973942}
{\'date\': \'202310\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 718.4529584932001}
{\'date\': \'202311\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 709.9250541542}
{\'date\': \'202312\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 775.3320972012}
{\'date\': \'202401\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 802.4249138710001}
{\'date\': \'202402\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 840.777554246}
{\'date\': \'202403\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 887.957863012}
{\'date\': \'202404\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 887.8052511096}
{\'date\': \'202405\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 841.1603441908001}
{\'date\': \'202406\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 904.090156726}
{\'date\': \'202407\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 962.9473276598}
{\'date\': \'202408\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 918.5604789842}
{\'date\': \'202409\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 922.8476184564}
{\'date\': \'202410\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 962.9959414022001}
{\'date\': \'202411\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 975.2963062682}
{\'date\': \'202412\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 516.4587509559}
{\'date\': \'202501\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 512.22}
{\'date\': \'202502\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 520.1}', 1740846674613, 1740846674620);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('7b8456c700fb4b47bc9ab43805d246bb', 'a92f50fe93864c8eb27fb1a2de201b7e', 'QQQ', '2015-1-1', '2025-3-1', 'import numpy
import pandas
import os
import sys


fixed_investment_amount = 1000

latest_price = 0.0

logs = []


def calculate_commission(share, price):     
    return min(
            share * price * 0.01,
            max(1.99, share * 0.011)
        )
    

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    
    
    for i in range(len(df)):
        date = df.iloc[i][\'date\']       # 2015-01-05 00:00:00+00:00
        close = df.iloc[i][\'close\']
        
        date = "".join(date.split("-")[:2])
        latest_price = close
        
        if not logs or logs[-1][\'date\'] != date:
            
            share = fixed_investment_amount // close
            commission = calculate_commission(share, close)
            amount = share * close + commission
            
            logs.append({
                \'date\': date,
                \'share\': share,
                \'commission\': commission,
                \'amount\': amount
            })
            
    total_commission = sum([log[\'commission\'] for log in logs])
    total_amount = sum([log[\'amount\'] for log in logs])
    total_share = sum([log[\'share\'] for log in logs])
    
    print("total_amount (include commission)", "->", round(total_amount, 2))
    print("total_commission", "->", round(total_commission, 2))
    print("total_share", "->", int(total_share))
    
    profit = total_share * latest_price - total_amount
    print("profit", "->", round(profit, 2))
    print("profit rate", "->", round(profit / total_amount * 100, 2), "%" )', 0, 'total_amount (include commission) -> 107551.21
total_commission -> 242.78
total_share -> 600
profit -> 197350.79
profit rate -> 183.49 %', 1740838586773, 1740838586776);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('860abc660e7d469b8e926fb84810b5cd', 'a92f50fe93864c8eb27fb1a2de201b7e', 'QQQ', '2015-1-1', '2025-3-1', 'import numpy
import pandas
import os
import sys


fixed_investment_amount = 1000

latest_price = 0.0

logs = []


def calculate_commission(share, price):     
    return min(
            share * price * 0.01,
            max(1.99, share * 0.011)
        )
    

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    
    
    for i in range(len(df)):
        date = df.iloc[i][\'date\']       # 2015-01-05 00:00:00+00:00
        close = df.iloc[i][\'close\']
        
        date = "".join(date.split("-")[:2])
        latest_price = close
        
        if not logs or logs[-1][\'date\'] != date:
            
            share = fixed_investment_amount // close
            commission = calculate_commission(share, close)
            amount = share * close + commission
            
            logs.append({
                \'date\': date,
                \'share\': share,
                \'commission\': commission,
                \'amount\': amount
            })
            
    total_commission = sum([log[\'commission\'] for log in logs])
    total_amount = sum([log[\'amount\'] for log in logs])
    total_share = sum([log[\'share\'] for log in logs])
    
    print("total_amount (include commission)", "->", round(total_amount, 2))
    print("total_commission", "->", round(total_commission, 2))
    print("total_share", "->", int(total_share))
    
    profit = total_share * latest_price - total_amount
    print("profit", "->", round(profit, 2))
    print("profit rate", "->", round(profit / total_amount * 100, 2), "%" )
    
    print("--------- logs ---------")
    for log in logs:
        print(log)', 0, 'total_amount (include commission) -> 107551.21
total_commission -> 242.78
total_share -> 600
profit -> 197350.79
profit rate -> 183.49 %
--------- logs ---------
{\'date\': \'201501\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 953.1071645989999}
{\'date\': \'201502\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 944.237216299}
{\'date\': \'201503\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 911.5477610013999}
{\'date\': \'201504\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 974.8210381660001}
{\'date\': \'201505\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 910.8762659758}
{\'date\': \'201506\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 922.2946445575}
{\'date\': \'201507\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 903.5385297652}
{\'date\': \'201508\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 934.2807331528}
{\'date\': \'201509\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 939.942793559}
{\'date\': \'201510\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 953.1446269790001}
{\'date\': \'201511\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 961.7889495043}
{\'date\': \'201512\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 966.3949125280001}
{\'date\': \'201601\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 921.8535870817}
{\'date\': \'201602\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 976.550701443}
{\'date\': \'201603\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 989.431591856}
{\'date\': \'201604\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 931.8221359786}
{\'date\': \'201605\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 1001.060572587}
{\'date\': \'201606\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 931.7378815264}
{\'date\': \'201607\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 915.063335335}
{\'date\': \'201608\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 980.6207842819}
{\'date\': \'201609\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 988.2240966595}
{\'date\': \'201610\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 894.465131776}
{\'date\': \'201611\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 985.3594516603}
{\'date\': \'201612\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 979.9391050147001}
{\'date\': \'201701\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 904.5888482367999}
{\'date\': \'201702\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 949.0618883584}
{\'date\': \'201703\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 994.4410006047999}
{\'date\': \'201704\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 877.8860902895001}
{\'date\': \'201705\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 910.3266862262}
{\'date\': \'201706\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 941.0459444196}
{\'date\': \'201707\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 906.1097608365999}
{\'date\': \'201708\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 955.0367065098}
{\'date\': \'201709\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 971.235048415}
{\'date\': \'201710\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 970.5675029874999}
{\'date\': \'201711\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 869.3813500936}
{\'date\': \'201712\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 883.0109709136}
{\'date\': \'201801\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 907.6988250832001}
{\'date\': \'201802\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 961.8161988826}
{\'date\': \'201803\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 941.9293497988}
{\'date\': \'201804\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 892.1400434541999}
{\'date\': \'201805\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 933.7540285096}
{\'date\': \'201806\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 990.7657604416002}
{\'date\': \'201807\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 993.2296183972}
{\'date\': \'201808\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 848.6738407145001}
{\'date\': \'201809\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 890.4057170100001}
{\'date\': \'201810\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 893.5312503924999}
{\'date\': \'201811\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 990.7545971482}
{\'date\': \'201812\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 992.306186368}
{\'date\': \'201901\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 894.6363211137999}
{\'date\': \'201902\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 967.0831461166001}
{\'date\': \'201903\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 839.5663598649999}
{\'date\': \'201904\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 877.8969565350001}
{\'date\': \'201905\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 911.0490051535}
{\'date\': \'201906\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 984.2529627274001}
{\'date\': \'201907\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 914.6481412770001}
{\'date\': \'201908\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 918.939939574}
{\'date\': \'201909\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 897.239835824}
{\'date\': \'201910\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 906.8729294395}
{\'date\': \'201911\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 962.9237757120001}
{\'date\': \'201912\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 982.879809773}
{\'date\': \'202001\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 839.3782355508}
{\'date\': \'202002\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 863.4740665328}
{\'date\': \'202003\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 840.3854567816}
{\'date\': \'202004\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 886.688111171}
{\'date\': \'202005\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 827.8829347616}
{\'date\': \'202006\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 910.6508080772}
{\'date\': \'202007\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 976.1069498332001}
{\'date\': \'202008\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 787.6729332888999}
{\'date\': \'202009\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 876.7469431732}
{\'date\': \'202010\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 826.4047636717}
{\'date\': \'202011\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 790.565723281}
{\'date\': \'202012\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 888.3563567185}
{\'date\': \'202101\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 907.0850700403}
{\'date\': \'202102\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 945.4472192377}
{\'date\': \'202103\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 948.8708435368001}
{\'date\': \'202104\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 952.9150011588999}
{\'date\': \'202105\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 986.9592705412001}
{\'date\': \'202106\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 977.0858464606}
{\'date\': \'202107\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 695.3339778922}
{\'date\': \'202108\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 714.9471434116}
{\'date\': \'202109\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 746.1952376291999}
{\'date\': \'202110\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 707.101216852}
{\'date\': \'202111\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 760.4475455188001}
{\'date\': \'202112\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 759.8406698532001}
{\'date\': \'202201\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 789.3593072686}
{\'date\': \'202202\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 718.4788199384}
{\'date\': \'202203\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 671.3754429874}
{\'date\': \'202204\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 712.1636175444}
{\'date\': \'202205\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 939.5722594261001}
{\'date\': \'202206\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 902.8320352435001}
{\'date\': \'202207\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 834.118896364}
{\'date\': \'202208\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 931.8637360672001}
{\'date\': \'202209\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 885.0559326244}
{\'date\': \'202210\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 810.1910092845999}
{\'date\': \'202211\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 814.8594463653999}
{\'date\': \'202212\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 869.8465438786}
{\'date\': \'202301\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 785.3496218287}
{\'date\': \'202302\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 893.2807493977}
{\'date\': \'202303\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 864.4912170163}
{\'date\': \'202304\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 951.7013310721001}
{\'date\': \'202305\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 957.7529041327}
{\'date\': \'202306\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 698.13844219}
{\'date\': \'202307\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 735.2955087374}
{\'date\': \'202308\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 760.0499413692}
{\'date\': \'202309\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 749.7520973942}
{\'date\': \'202310\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 718.4529584932001}
{\'date\': \'202311\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 709.9250541542}
{\'date\': \'202312\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 775.3320972012}
{\'date\': \'202401\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 802.4249138710001}
{\'date\': \'202402\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 840.777554246}
{\'date\': \'202403\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 887.957863012}
{\'date\': \'202404\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 887.8052511096}
{\'date\': \'202405\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 841.1603441908001}
{\'date\': \'202406\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 904.090156726}
{\'date\': \'202407\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 962.9473276598}
{\'date\': \'202408\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 918.5604789842}
{\'date\': \'202409\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 922.8476184564}
{\'date\': \'202410\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 962.9959414022001}
{\'date\': \'202411\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 975.2963062682}
{\'date\': \'202412\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 516.4587509559}
{\'date\': \'202501\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 512.22}
{\'date\': \'202502\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 520.1}', 1740882801302, 1740882801312);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('8a5408313fbe4db1ba4dceebfb353969', 'a92f50fe93864c8eb27fb1a2de201b7e', 'QQQ', '2015-1-1', '2025-3-8', 'import numpy
import pandas
import os
import sys


fixed_investment_amount = 1000

latest_price = 0.0

logs = []


def calculate_commission(share, price):     
    return min(
            share * price * 0.01,
            max(1.99, share * 0.011)
        )
    

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    
    
    for i in range(len(df)):
        date = df.iloc[i][\'date\']       # 2015-01-05 00:00:00+00:00
        close = df.iloc[i][\'close\']
        
        date = "".join(date.split("-")[:2])
        latest_price = close
        
        if not logs or logs[-1][\'date\'] != date:
            
            share = fixed_investment_amount // close
            commission = calculate_commission(share, close)
            amount = share * close + commission
            
            logs.append({
                \'date\': date,
                \'share\': share,
                \'commission\': commission,
                \'amount\': amount
            })
            
    total_commission = sum([log[\'commission\'] for log in logs])
    total_amount = sum([log[\'amount\'] for log in logs])
    total_share = sum([log[\'share\'] for log in logs])
    
    print("total_amount (include commission)", "->", round(total_amount, 2))
    print("total_commission", "->", round(total_commission, 2))
    print("total_share", "->", int(total_share))
    
    profit = total_share * latest_price - total_amount
    print("profit", "->", round(profit, 2))
    print("profit rate", "->", round(profit / total_amount * 100, 2), "%" )
    
    print("--------- logs ---------")
    for log in logs:
        print(log)', 0, 'total_amount (include commission) -> 108547.3
total_commission -> 244.77
total_share -> 602
profit -> 187510.28
profit rate -> 172.75 %
--------- logs ---------
{\'date\': \'201501\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 953.1071645989999}
{\'date\': \'201502\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 944.237216299}
{\'date\': \'201503\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 911.5477610013999}
{\'date\': \'201504\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 974.8210381660001}
{\'date\': \'201505\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 910.8762659758}
{\'date\': \'201506\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 922.2946445575}
{\'date\': \'201507\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 903.5385297652}
{\'date\': \'201508\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 934.2807331528}
{\'date\': \'201509\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 939.942793559}
{\'date\': \'201510\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 953.1446269790001}
{\'date\': \'201511\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 961.7889495043}
{\'date\': \'201512\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 966.3949125280001}
{\'date\': \'201601\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 921.8535870817}
{\'date\': \'201602\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 976.550701443}
{\'date\': \'201603\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 989.431591856}
{\'date\': \'201604\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 931.8221359786}
{\'date\': \'201605\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 1001.060572587}
{\'date\': \'201606\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 931.7378815264}
{\'date\': \'201607\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 915.063335335}
{\'date\': \'201608\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 980.6207842819}
{\'date\': \'201609\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 988.2240966595}
{\'date\': \'201610\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 894.465131776}
{\'date\': \'201611\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 985.3594516603}
{\'date\': \'201612\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 979.9391050147001}
{\'date\': \'201701\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 904.5888482367999}
{\'date\': \'201702\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 949.0618883584}
{\'date\': \'201703\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 994.4410006047999}
{\'date\': \'201704\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 877.8860902895001}
{\'date\': \'201705\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 910.3266862262}
{\'date\': \'201706\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 941.0459444196}
{\'date\': \'201707\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 906.1097608365999}
{\'date\': \'201708\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 955.0367065098}
{\'date\': \'201709\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 971.235048415}
{\'date\': \'201710\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 970.5675029874999}
{\'date\': \'201711\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 869.3813500936}
{\'date\': \'201712\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 883.0109709136}
{\'date\': \'201801\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 907.6988250832001}
{\'date\': \'201802\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 961.8161988826}
{\'date\': \'201803\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 941.9293497988}
{\'date\': \'201804\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 892.1400434541999}
{\'date\': \'201805\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 933.7540285096}
{\'date\': \'201806\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 990.7657604416002}
{\'date\': \'201807\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 993.2296183972}
{\'date\': \'201808\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 848.6738407145001}
{\'date\': \'201809\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 890.4057170100001}
{\'date\': \'201810\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 893.5312503924999}
{\'date\': \'201811\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 990.7545971482}
{\'date\': \'201812\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 992.306186368}
{\'date\': \'201901\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 894.6363211137999}
{\'date\': \'201902\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 967.0831461166001}
{\'date\': \'201903\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 839.5663598649999}
{\'date\': \'201904\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 877.8969565350001}
{\'date\': \'201905\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 911.0490051535}
{\'date\': \'201906\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 984.2529627274001}
{\'date\': \'201907\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 914.6481412770001}
{\'date\': \'201908\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 918.939939574}
{\'date\': \'201909\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 897.239835824}
{\'date\': \'201910\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 906.8729294395}
{\'date\': \'201911\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 962.9237757120001}
{\'date\': \'201912\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 982.879809773}
{\'date\': \'202001\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 839.3782355508}
{\'date\': \'202002\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 863.4740665328}
{\'date\': \'202003\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 840.3854567816}
{\'date\': \'202004\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 886.688111171}
{\'date\': \'202005\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 827.8829347616}
{\'date\': \'202006\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 910.6508080772}
{\'date\': \'202007\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 976.1069498332001}
{\'date\': \'202008\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 787.6729332888999}
{\'date\': \'202009\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 876.7469431732}
{\'date\': \'202010\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 826.4047636717}
{\'date\': \'202011\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 790.565723281}
{\'date\': \'202012\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 888.3563567185}
{\'date\': \'202101\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 907.0850700403}
{\'date\': \'202102\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 945.4472192377}
{\'date\': \'202103\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 948.8708435368001}
{\'date\': \'202104\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 952.9150011588999}
{\'date\': \'202105\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 986.9592705412001}
{\'date\': \'202106\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 977.0858464606}
{\'date\': \'202107\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 695.3339778922}
{\'date\': \'202108\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 714.9471434116}
{\'date\': \'202109\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 746.1952376291999}
{\'date\': \'202110\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 707.101216852}
{\'date\': \'202111\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 760.4475455188001}
{\'date\': \'202112\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 759.8406698532001}
{\'date\': \'202201\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 789.3593072686}
{\'date\': \'202202\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 718.4788199384}
{\'date\': \'202203\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 671.3754429874}
{\'date\': \'202204\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 712.1636175444}
{\'date\': \'202205\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 939.5722594261001}
{\'date\': \'202206\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 902.8320352435001}
{\'date\': \'202207\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 834.118896364}
{\'date\': \'202208\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 931.8637360672001}
{\'date\': \'202209\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 885.0559326244}
{\'date\': \'202210\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 810.1910092845999}
{\'date\': \'202211\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 814.8594463653999}
{\'date\': \'202212\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 869.8465438786}
{\'date\': \'202301\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 785.3496218287}
{\'date\': \'202302\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 893.2807493977}
{\'date\': \'202303\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 864.4912170163}
{\'date\': \'202304\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 951.7013310721001}
{\'date\': \'202305\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 957.7529041327}
{\'date\': \'202306\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 698.13844219}
{\'date\': \'202307\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 735.2955087374}
{\'date\': \'202308\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 760.0499413692}
{\'date\': \'202309\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 749.7520973942}
{\'date\': \'202310\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 718.4529584932001}
{\'date\': \'202311\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 709.9250541542}
{\'date\': \'202312\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 775.3320972012}
{\'date\': \'202401\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 802.4249138710001}
{\'date\': \'202402\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 840.777554246}
{\'date\': \'202403\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 887.957863012}
{\'date\': \'202404\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 887.8052511096}
{\'date\': \'202405\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 841.1603441908001}
{\'date\': \'202406\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 904.090156726}
{\'date\': \'202407\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 962.9473276598}
{\'date\': \'202408\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 918.5604789842}
{\'date\': \'202409\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 922.8476184564}
{\'date\': \'202410\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 962.9959414022001}
{\'date\': \'202411\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 975.2963062682}
{\'date\': \'202412\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 516.4587509559}
{\'date\': \'202501\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 512.22}
{\'date\': \'202502\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 520.1}
{\'date\': \'202503\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 996.09}', 1741489872871, 1741489872874);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('8cee2d13e4c840e296fe70c2ec98eb35', 'a92f50fe93864c8eb27fb1a2de201b7e', 'QQQ', '2024-1-1', '2025-1-22', 'import numpy
import pandas
import os
import sys

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    print(df.head())
', -3, null, 1740244843895, 1740244843913);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('8f0297595deb40f59605d5b989d58011', 'a92f50fe93864c8eb27fb1a2de201b7e', 'QQQ', '2024-1-1', '2025-1-22', 'import numpy
import pandas
import os
import sys

if __name__ == "__main__":
    print(sys.argv)
    df = pandas.read_csv(sys.argv[1])
    print(df.head())', 4, '[\'/judger/run/8f2290d0-3791-407c-ba31-632194f744a5/__pycache__/solution.cpython-36.pyc\']


Error: Traceback (most recent call last):
  File "/judger/run/8f2290d0-3791-407c-ba31-632194f744a5/solution.py", line 8, in <module>
    df = pandas.read_csv(sys.argv[1])
IndexError: list index out of range', 1740245828047, 1740245828052);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('8f9e6b027ece4a36be3edacf14c0573d', 'a92f50fe93864c8eb27fb1a2de201b7e', 'QQQ', '2015-1-1', '2025-3-1', 'import numpy
import pandas
import os
import sys


fixed_investment_amount = 1000

latest_price = 0.0

logs = []


def calculate_commission(share, price):     
    return min(
            share * price * 0.01,
            max(1.99, share * 0.011)
        )
    

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    
    
    for i in range(len(df)):
        date = df.iloc[i][\'date\']       # 2015-01-05 00:00:00+00:00
        close = df.iloc[i][\'close\']
        
        date = "".join(date.split("-")[:2])
        latest_price = close
        
        if not logs or logs[-1][\'date\'] != date:
            
            share = fixed_investment_amount // close
            commission = calculate_commission(share, close)
            amount = share * close + commission
            
            logs.append({
                \'date\': date,
                \'share\': share,
                \'commission\': commission,
                \'amount\': amount
            })
            
    total_commission = sum([log[\'commission\'] for log in logs])
    total_amount = sum([log[\'amount\'] for log in logs])
    total_share = sum([log[\'share\'] for log in logs])
    
    print("total_amount (include commission)", "->", round(total_amount, 2))
    print("total_commission", "->", round(total_commission, 2))
    print("total_share", "->", int(total_share))
    
    profit = total_share * latest_price - total_amount
    print("profit", "->", round(profit, 2))
    print("profit rate", "->", round(profit / total_amount * 100, 2), "%" )
    
    print("--------- logs ---------")
    for log in logs:
        print(log)', 0, 'total_amount (include commission) -> 107551.21
total_commission -> 242.78
total_share -> 600
profit -> 197350.79
profit rate -> 183.49 %
--------- logs ---------
{\'date\': \'201501\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 953.1071645989999}
{\'date\': \'201502\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 944.237216299}
{\'date\': \'201503\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 911.5477610013999}
{\'date\': \'201504\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 974.8210381660001}
{\'date\': \'201505\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 910.8762659758}
{\'date\': \'201506\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 922.2946445575}
{\'date\': \'201507\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 903.5385297652}
{\'date\': \'201508\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 934.2807331528}
{\'date\': \'201509\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 939.942793559}
{\'date\': \'201510\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 953.1446269790001}
{\'date\': \'201511\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 961.7889495043}
{\'date\': \'201512\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 966.3949125280001}
{\'date\': \'201601\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 921.8535870817}
{\'date\': \'201602\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 976.550701443}
{\'date\': \'201603\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 989.431591856}
{\'date\': \'201604\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 931.8221359786}
{\'date\': \'201605\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 1001.060572587}
{\'date\': \'201606\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 931.7378815264}
{\'date\': \'201607\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 915.063335335}
{\'date\': \'201608\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 980.6207842819}
{\'date\': \'201609\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 988.2240966595}
{\'date\': \'201610\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 894.465131776}
{\'date\': \'201611\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 985.3594516603}
{\'date\': \'201612\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 979.9391050147001}
{\'date\': \'201701\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 904.5888482367999}
{\'date\': \'201702\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 949.0618883584}
{\'date\': \'201703\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 994.4410006047999}
{\'date\': \'201704\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 877.8860902895001}
{\'date\': \'201705\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 910.3266862262}
{\'date\': \'201706\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 941.0459444196}
{\'date\': \'201707\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 906.1097608365999}
{\'date\': \'201708\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 955.0367065098}
{\'date\': \'201709\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 971.235048415}
{\'date\': \'201710\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 970.5675029874999}
{\'date\': \'201711\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 869.3813500936}
{\'date\': \'201712\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 883.0109709136}
{\'date\': \'201801\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 907.6988250832001}
{\'date\': \'201802\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 961.8161988826}
{\'date\': \'201803\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 941.9293497988}
{\'date\': \'201804\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 892.1400434541999}
{\'date\': \'201805\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 933.7540285096}
{\'date\': \'201806\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 990.7657604416002}
{\'date\': \'201807\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 993.2296183972}
{\'date\': \'201808\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 848.6738407145001}
{\'date\': \'201809\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 890.4057170100001}
{\'date\': \'201810\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 893.5312503924999}
{\'date\': \'201811\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 990.7545971482}
{\'date\': \'201812\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 992.306186368}
{\'date\': \'201901\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 894.6363211137999}
{\'date\': \'201902\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 967.0831461166001}
{\'date\': \'201903\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 839.5663598649999}
{\'date\': \'201904\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 877.8969565350001}
{\'date\': \'201905\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 911.0490051535}
{\'date\': \'201906\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 984.2529627274001}
{\'date\': \'201907\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 914.6481412770001}
{\'date\': \'201908\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 918.939939574}
{\'date\': \'201909\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 897.239835824}
{\'date\': \'201910\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 906.8729294395}
{\'date\': \'201911\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 962.9237757120001}
{\'date\': \'201912\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 982.879809773}
{\'date\': \'202001\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 839.3782355508}
{\'date\': \'202002\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 863.4740665328}
{\'date\': \'202003\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 840.3854567816}
{\'date\': \'202004\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 886.688111171}
{\'date\': \'202005\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 827.8829347616}
{\'date\': \'202006\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 910.6508080772}
{\'date\': \'202007\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 976.1069498332001}
{\'date\': \'202008\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 787.6729332888999}
{\'date\': \'202009\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 876.7469431732}
{\'date\': \'202010\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 826.4047636717}
{\'date\': \'202011\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 790.565723281}
{\'date\': \'202012\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 888.3563567185}
{\'date\': \'202101\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 907.0850700403}
{\'date\': \'202102\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 945.4472192377}
{\'date\': \'202103\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 948.8708435368001}
{\'date\': \'202104\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 952.9150011588999}
{\'date\': \'202105\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 986.9592705412001}
{\'date\': \'202106\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 977.0858464606}
{\'date\': \'202107\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 695.3339778922}
{\'date\': \'202108\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 714.9471434116}
{\'date\': \'202109\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 746.1952376291999}
{\'date\': \'202110\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 707.101216852}
{\'date\': \'202111\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 760.4475455188001}
{\'date\': \'202112\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 759.8406698532001}
{\'date\': \'202201\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 789.3593072686}
{\'date\': \'202202\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 718.4788199384}
{\'date\': \'202203\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 671.3754429874}
{\'date\': \'202204\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 712.1636175444}
{\'date\': \'202205\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 939.5722594261001}
{\'date\': \'202206\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 902.8320352435001}
{\'date\': \'202207\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 834.118896364}
{\'date\': \'202208\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 931.8637360672001}
{\'date\': \'202209\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 885.0559326244}
{\'date\': \'202210\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 810.1910092845999}
{\'date\': \'202211\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 814.8594463653999}
{\'date\': \'202212\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 869.8465438786}
{\'date\': \'202301\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 785.3496218287}
{\'date\': \'202302\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 893.2807493977}
{\'date\': \'202303\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 864.4912170163}
{\'date\': \'202304\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 951.7013310721001}
{\'date\': \'202305\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 957.7529041327}
{\'date\': \'202306\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 698.13844219}
{\'date\': \'202307\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 735.2955087374}
{\'date\': \'202308\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 760.0499413692}
{\'date\': \'202309\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 749.7520973942}
{\'date\': \'202310\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 718.4529584932001}
{\'date\': \'202311\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 709.9250541542}
{\'date\': \'202312\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 775.3320972012}
{\'date\': \'202401\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 802.4249138710001}
{\'date\': \'202402\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 840.777554246}
{\'date\': \'202403\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 887.957863012}
{\'date\': \'202404\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 887.8052511096}
{\'date\': \'202405\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 841.1603441908001}
{\'date\': \'202406\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 904.090156726}
{\'date\': \'202407\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 962.9473276598}
{\'date\': \'202408\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 918.5604789842}
{\'date\': \'202409\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 922.8476184564}
{\'date\': \'202410\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 962.9959414022001}
{\'date\': \'202411\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 975.2963062682}
{\'date\': \'202412\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 516.4587509559}
{\'date\': \'202501\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 512.22}
{\'date\': \'202502\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 520.1}', 1740876421012, 1740876421019);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('8fc52747e620498da5ed4c11d657315b', 'a92f50fe93864c8eb27fb1a2de201b7e', 'SPY', '2015-1-1', '2025-3-1', 'import numpy
import pandas
import os
import sys


fixed_investment_amount = 1000

latest_price = 0.0

logs = []


def calculate_commission(share, price):     
    return min(
            share * price * 0.01,
            max(1.99, share * 0.011)
        )
    

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    
    
    for i in range(len(df)):
        date = df.iloc[i][\'date\']       # 2015-01-05 00:00:00+00:00
        close = df.iloc[i][\'close\']
        
        date = "".join(date.split("-")[:2])
        latest_price = close
        
        if not logs or logs[-1][\'date\'] != date:
            
            share = fixed_investment_amount // close
            commission = calculate_commission(share, close)
            amount = share * close + commission
            
            logs.append({
                \'date\': date,
                \'share\': share,
                \'commission\': commission,
                \'amount\': amount
            })
            
    total_commission = sum([log[\'commission\'] for log in logs])
    total_amount = sum([log[\'amount\'] for log in logs])
    total_share = sum([log[\'share\'] for log in logs])
    
    print("total_amount (include commission)", "->", round(total_amount, 2))
    print("total_commission", "->", round(total_commission, 2))
    print("total_share", "->", int(total_share))
    
    profit = total_share * latest_price - total_amount
    print("profit", "->", round(profit, 2))
    print("profit rate", "->", round(profit / total_amount * 100, 2), "%" )
    
    print("--------- logs ---------")
    for log in logs:
        print(log)', 0, 'total_amount (include commission) -> 101910.74
total_commission -> 242.78
total_share -> 379
profit -> 123283.48
profit rate -> 120.97 %
--------- logs ---------
{\'date\': \'201501\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 864.1864010315}
{\'date\': \'201502\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 849.4548167075}
{\'date\': \'201503\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 891.7189346959999}
{\'date\': \'201504\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 869.138790096}
{\'date\': \'201505\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 890.3010989254999}
{\'date\': \'201506\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 893.884358389}
{\'date\': \'201507\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 881.2975843295001}
{\'date\': \'201508\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 890.44777165}
{\'date\': \'201509\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 976.8407902696}
{\'date\': \'201510\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 983.8373473270001}
{\'date\': \'201511\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 897.958282778}
{\'date\': \'201512\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 899.1932787475}
{\'date\': \'201601\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 863.2404643365}
{\'date\': \'201602\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 997.5992563876}
{\'date\': \'201603\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 850.7728422835}
{\'date\': \'201604\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 893.0712212955}
{\'date\': \'201605\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 897.592958994}
{\'date\': \'201606\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 907.497702383}
{\'date\': \'201607\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 910.711101319}
{\'date\': \'201608\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 941.0999438629999}
{\'date\': \'201609\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 943.0479324935}
{\'date\': \'201610\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 940.8154789485001}
{\'date\': \'201611\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 920.0619275969999}
{\'date\': \'201612\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 957.3052189255}
{\'date\': \'201701\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 987.7616135825001}
{\'date\': \'201702\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 998.1777320805}
{\'date\': \'201703\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 841.5151687872}
{\'date\': \'201704\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 829.5259433432001}
{\'date\': \'201705\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 841.3061581003999}
{\'date\': \'201706\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 857.7633662856}
{\'date\': \'201707\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 857.8724385924}
{\'date\': \'201708\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 875.9293030639999}
{\'date\': \'201709\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 877.7667947252}
{\'date\': \'201710\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 898.0148259855999}
{\'date\': \'201711\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 916.374243988}
{\'date\': \'201712\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 941.1257224164}
{\'date\': \'201801\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 961.270628548}
{\'date\': \'201802\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 755.7410865793}
{\'date\': \'201803\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 957.4516373192}
{\'date\': \'201804\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 924.6149557276}
{\'date\': \'201805\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 951.526492674}
{\'date\': \'201806\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 982.415633616}
{\'date\': \'201807\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 980.5591075172}
{\'date\': \'201808\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 760.2136800301}
{\'date\': \'201809\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 784.3755469255}
{\'date\': \'201810\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 793.1262524245001}
{\'date\': \'201811\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 990.9577734008001}
{\'date\': \'201812\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 759.4176053275}
{\'date\': \'201901\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 911.9948686072}
{\'date\': \'201902\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 984.3063914624}
{\'date\': \'201903\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 766.9898958397}
{\'date\': \'201904\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 785.1666585424}
{\'date\': \'201905\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 801.5519099787999}
{\'date\': \'201906\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 754.3141616905}
{\'date\': \'201907\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 816.0456874009}
{\'date\': \'201908\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 813.7879397731001}
{\'date\': \'201909\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 802.4992016335}
{\'date\': \'201910\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 813.1277968398999}
{\'date\': \'201911\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 848.8107786268}
{\'date\': \'201912\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 864.0244530322002}
{\'date\': \'202001\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 905.0191250518001}
{\'date\': \'202002\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 902.9343777874001}
{\'date\': \'202003\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 861.1560426087999}
{\'date\': \'202004\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 919.8797340188}
{\'date\': \'202005\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 792.8798168287001}
{\'date\': \'202006\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 856.5335960677}
{\'date\': \'202007\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 874.2776858308}
{\'date\': \'202008\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 925.6002931351}
{\'date\': \'202009\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 992.4854206617999}
{\'date\': \'202010\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 952.6102697017}
{\'date\': \'202011\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 933.3180710167}
{\'date\': \'202012\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 690.2288462619999}
{\'date\': \'202101\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 698.4051487556}
{\'date\': \'202102\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 712.4546856375999}
{\'date\': \'202103\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 737.6645401236}
{\'date\': \'202104\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 760.9752575069999}
{\'date\': \'202105\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 794.3008127342}
{\'date\': \'202106\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 797.0858363944001}
{\'date\': \'202107\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 820.1755888022}
{\'date\': \'202108\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 833.7857201032001}
{\'date\': \'202109\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 860.7968885088001}
{\'date\': \'202110\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 830.0884620714}
{\'date\': \'202111\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 879.2892273658}
{\'date\': \'202112\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 861.0963862453999}
{\'date\': \'202201\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 916.221941485}
{\'date\': \'202202\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 868.836743622}
{\'date\': \'202203\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 824.877212325}
{\'date\': \'202204\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 871.4429719556}
{\'date\': \'202205\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 797.6511936239999}
{\'date\': \'202206\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 788.2640501266001}
{\'date\': \'202207\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 736.9959632092}
{\'date\': \'202208\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 793.9278856034}
{\'date\': \'202209\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 766.2620174572}
{\'date\': \'202210\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 711.7167556155999}
{\'date\': \'202211\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 746.3890400408001}
{\'date\': \'202212\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 790.6441166436}
{\'date\': \'202301\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 742.6527435378}
{\'date\': \'202302\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 800.9613120248}
{\'date\': \'202303\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 769.7259681322}
{\'date\': \'202304\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 804.3399315917999}
{\'date\': \'202305\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 813.2429993324}
{\'date\': \'202306\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 825.5628145614}
{\'date\': \'202307\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 871.6879486358}
{\'date\': \'202308\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 896.5566184306}
{\'date\': \'202309\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 886.1897734176}
{\'date\': \'202310\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 842.3821565966}
{\'date\': \'202311\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 833.2369844074001}
{\'date\': \'202312\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 904.9036671117999}
{\'date\': \'202401\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 935.3277008612}
{\'date\': \'202402\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 968.0088369010001}
{\'date\': \'202403\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 508.3501395183}
{\'date\': \'202404\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 519.1551646752}
{\'date\': \'202405\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 993.1175859706}
{\'date\': \'202406\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 524.7412140255001}
{\'date\': \'202407\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 543.8582846465}
{\'date\': \'202408\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 541.5431177723001}
{\'date\': \'202409\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 550.5553768065}
{\'date\': \'202410\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 568.725628721}
{\'date\': \'202411\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 571.1376089917}
{\'date\': \'202412\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 603.6196077607}
{\'date\': \'202501\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 586.63}
{\'date\': \'202502\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 599.76}', 1740882893578, 1740882893583);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('91ba372ee28c434584f8879d286caab3', 'a92f50fe93864c8eb27fb1a2de201b7e', 'QQQ', '2015-1-1', '2025-3-1', 'import numpy
import pandas
import os
import sys


fixed_investment_amount = 1000

latest_price = 0.0

logs = []


def calculate_commission(share, price):     
    return min(
            share * price * 0.01,
            max(1.99, share * 0.011)
        )
    

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    
    
    for i in range(len(df)):
        date = df.iloc[i][\'date\']       # 2015-01-05 00:00:00+00:00
        close = df.iloc[i][\'close\']
        
        date = "".join(date.split("-")[:2])
        latest_price = close
        
        if not logs or logs[-1][\'date\'] != date:
            
            share = fixed_investment_amount // close
            commission = calculate_commission(share, close)
            amount = share * close + commission
            
            logs.append({
                \'date\': date,
                \'share\': share,
                \'commission\': commission,
                \'amount\': amount
            })
            
    total_commission = sum([log[\'commission\'] for log in logs])
    total_amount = sum([log[\'amount\'] for log in logs])
    total_share = sum([log[\'share\'] for log in logs])
    
    print("total_amount (include commission)", "->", round(total_amount, 2))
    print("total_commission", "->", round(total_commission, 2))
    print("total_share", "->", int(total_share))
    
    profit = total_share * latest_price - total_amount
    print("profit", "->", round(profit, 2))
    print("profit rate", "->", round(profit / total_amount * 100, 2), "%" )
    
    print("--------- logs ---------")
    for log in logs:
        print(log)', 0, 'total_amount (include commission) -> 107551.21
total_commission -> 242.78
total_share -> 600
profit -> 197350.79
profit rate -> 183.49 %
--------- logs ---------
{\'date\': \'201501\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 953.1071645989999}
{\'date\': \'201502\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 944.237216299}
{\'date\': \'201503\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 911.5477610013999}
{\'date\': \'201504\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 974.8210381660001}
{\'date\': \'201505\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 910.8762659758}
{\'date\': \'201506\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 922.2946445575}
{\'date\': \'201507\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 903.5385297652}
{\'date\': \'201508\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 934.2807331528}
{\'date\': \'201509\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 939.942793559}
{\'date\': \'201510\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 953.1446269790001}
{\'date\': \'201511\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 961.7889495043}
{\'date\': \'201512\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 966.3949125280001}
{\'date\': \'201601\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 921.8535870817}
{\'date\': \'201602\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 976.550701443}
{\'date\': \'201603\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 989.431591856}
{\'date\': \'201604\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 931.8221359786}
{\'date\': \'201605\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 1001.060572587}
{\'date\': \'201606\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 931.7378815264}
{\'date\': \'201607\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 915.063335335}
{\'date\': \'201608\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 980.6207842819}
{\'date\': \'201609\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 988.2240966595}
{\'date\': \'201610\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 894.465131776}
{\'date\': \'201611\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 985.3594516603}
{\'date\': \'201612\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 979.9391050147001}
{\'date\': \'201701\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 904.5888482367999}
{\'date\': \'201702\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 949.0618883584}
{\'date\': \'201703\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 994.4410006047999}
{\'date\': \'201704\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 877.8860902895001}
{\'date\': \'201705\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 910.3266862262}
{\'date\': \'201706\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 941.0459444196}
{\'date\': \'201707\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 906.1097608365999}
{\'date\': \'201708\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 955.0367065098}
{\'date\': \'201709\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 971.235048415}
{\'date\': \'201710\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 970.5675029874999}
{\'date\': \'201711\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 869.3813500936}
{\'date\': \'201712\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 883.0109709136}
{\'date\': \'201801\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 907.6988250832001}
{\'date\': \'201802\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 961.8161988826}
{\'date\': \'201803\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 941.9293497988}
{\'date\': \'201804\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 892.1400434541999}
{\'date\': \'201805\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 933.7540285096}
{\'date\': \'201806\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 990.7657604416002}
{\'date\': \'201807\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 993.2296183972}
{\'date\': \'201808\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 848.6738407145001}
{\'date\': \'201809\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 890.4057170100001}
{\'date\': \'201810\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 893.5312503924999}
{\'date\': \'201811\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 990.7545971482}
{\'date\': \'201812\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 992.306186368}
{\'date\': \'201901\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 894.6363211137999}
{\'date\': \'201902\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 967.0831461166001}
{\'date\': \'201903\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 839.5663598649999}
{\'date\': \'201904\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 877.8969565350001}
{\'date\': \'201905\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 911.0490051535}
{\'date\': \'201906\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 984.2529627274001}
{\'date\': \'201907\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 914.6481412770001}
{\'date\': \'201908\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 918.939939574}
{\'date\': \'201909\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 897.239835824}
{\'date\': \'201910\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 906.8729294395}
{\'date\': \'201911\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 962.9237757120001}
{\'date\': \'201912\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 982.879809773}
{\'date\': \'202001\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 839.3782355508}
{\'date\': \'202002\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 863.4740665328}
{\'date\': \'202003\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 840.3854567816}
{\'date\': \'202004\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 886.688111171}
{\'date\': \'202005\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 827.8829347616}
{\'date\': \'202006\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 910.6508080772}
{\'date\': \'202007\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 976.1069498332001}
{\'date\': \'202008\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 787.6729332888999}
{\'date\': \'202009\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 876.7469431732}
{\'date\': \'202010\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 826.4047636717}
{\'date\': \'202011\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 790.565723281}
{\'date\': \'202012\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 888.3563567185}
{\'date\': \'202101\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 907.0850700403}
{\'date\': \'202102\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 945.4472192377}
{\'date\': \'202103\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 948.8708435368001}
{\'date\': \'202104\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 952.9150011588999}
{\'date\': \'202105\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 986.9592705412001}
{\'date\': \'202106\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 977.0858464606}
{\'date\': \'202107\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 695.3339778922}
{\'date\': \'202108\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 714.9471434116}
{\'date\': \'202109\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 746.1952376291999}
{\'date\': \'202110\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 707.101216852}
{\'date\': \'202111\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 760.4475455188001}
{\'date\': \'202112\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 759.8406698532001}
{\'date\': \'202201\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 789.3593072686}
{\'date\': \'202202\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 718.4788199384}
{\'date\': \'202203\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 671.3754429874}
{\'date\': \'202204\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 712.1636175444}
{\'date\': \'202205\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 939.5722594261001}
{\'date\': \'202206\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 902.8320352435001}
{\'date\': \'202207\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 834.118896364}
{\'date\': \'202208\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 931.8637360672001}
{\'date\': \'202209\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 885.0559326244}
{\'date\': \'202210\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 810.1910092845999}
{\'date\': \'202211\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 814.8594463653999}
{\'date\': \'202212\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 869.8465438786}
{\'date\': \'202301\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 785.3496218287}
{\'date\': \'202302\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 893.2807493977}
{\'date\': \'202303\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 864.4912170163}
{\'date\': \'202304\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 951.7013310721001}
{\'date\': \'202305\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 957.7529041327}
{\'date\': \'202306\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 698.13844219}
{\'date\': \'202307\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 735.2955087374}
{\'date\': \'202308\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 760.0499413692}
{\'date\': \'202309\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 749.7520973942}
{\'date\': \'202310\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 718.4529584932001}
{\'date\': \'202311\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 709.9250541542}
{\'date\': \'202312\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 775.3320972012}
{\'date\': \'202401\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 802.4249138710001}
{\'date\': \'202402\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 840.777554246}
{\'date\': \'202403\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 887.957863012}
{\'date\': \'202404\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 887.8052511096}
{\'date\': \'202405\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 841.1603441908001}
{\'date\': \'202406\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 904.090156726}
{\'date\': \'202407\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 962.9473276598}
{\'date\': \'202408\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 918.5604789842}
{\'date\': \'202409\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 922.8476184564}
{\'date\': \'202410\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 962.9959414022001}
{\'date\': \'202411\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 975.2963062682}
{\'date\': \'202412\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 516.4587509559}
{\'date\': \'202501\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 512.22}
{\'date\': \'202502\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 520.1}', 1740893333732, 1740893333736);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('9a78ceb9d7c74f30939b2c28f8310639', '6746072de36a4d709af132736e386a85', 'TLT', '2015-1-1', '2025-3-1', 'import numpy
import pandas
import os
import sys


fixed_investment_amount = 1000

latest_price = 0.0

logs = []


def calculate_commission(share, price):     
    return min(
            share * price * 0.01,
            max(1.99, share * 0.011)
        )
    

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    
    
    for i in range(len(df)):
        date = df.iloc[i][\'date\']       # 2015-01-05 00:00:00+00:00
        close = df.iloc[i][\'close\']
        
        date = "".join(date.split("-")[:2])
        latest_price = close
        
        if not logs or logs[-1][\'date\'] != date:
            
            share = fixed_investment_amount // close
            commission = calculate_commission(share, close)
            amount = share * close + commission
            
            logs.append({
                \'date\': date,
                \'share\': share,
                \'commission\': commission,
                \'amount\': amount
            })
            
    total_commission = sum([log[\'commission\'] for log in logs])
    total_amount = sum([log[\'amount\'] for log in logs])
    total_share = sum([log[\'share\'] for log in logs])
    
    print("total_amount (include commission)", "->", round(total_amount, 2))
    print("total_commission", "->", round(total_commission, 2))
    print("total_share", "->", int(total_share))
    
    profit = total_share * latest_price - total_amount
    print("profit", "->", round(profit, 2))
    print("profit rate", "->", round(profit / total_amount * 100, 2), "%" )
    
    print("--------- logs ---------")
    for log in logs:
        print(log)', 0, 'total_amount (include commission) -> 115625.4
total_commission -> 242.78
total_share -> 1093
profit -> -14599.41
profit rate -> -12.63 %
--------- logs ---------
{\'date\': \'201501\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 988.365918276}
{\'date\': \'201502\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 962.5143627712}
{\'date\': \'201503\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 988.831435452}
{\'date\': \'201504\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 928.8817656534999}
{\'date\': \'201505\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 970.512656801}
{\'date\': \'201506\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 950.160840273}
{\'date\': \'201507\', \'share\': 11.0, \'commission\': 1.99, \'amount\': 999.7571003960002}
{\'date\': \'201508\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 973.36137424}
{\'date\': \'201509\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 963.4760292780002}
{\'date\': \'201510\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 979.5199478879999}
{\'date\': \'201511\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 966.939387743}
{\'date\': \'201512\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 975.932265015}
{\'date\': \'201601\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 966.997969414}
{\'date\': \'201602\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 909.5498459848}
{\'date\': \'201603\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 923.9395379968001}
{\'date\': \'201604\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 942.0323113288}
{\'date\': \'201605\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 923.3306270497001}
{\'date\': \'201606\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 943.9982463871}
{\'date\': \'201607\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 906.1354440656}
{\'date\': \'201608\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 902.6502486375999}
{\'date\': \'201609\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 904.2881073872001}
{\'date\': \'201610\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 997.3725833719001}
{\'date\': \'201611\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 956.9916704908001}
{\'date\': \'201612\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 965.6069261270002}
{\'date\': \'201701\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 975.53575238}
{\'date\': \'201702\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 973.250466834}
{\'date\': \'201703\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 978.1750836010001}
{\'date\': \'201704\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 998.231188954}
{\'date\': \'201705\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 995.486633318}
{\'date\': \'201706\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 920.7502779888998}
{\'date\': \'201707\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 924.9510290697999}
{\'date\': \'201708\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 928.2781307926}
{\'date\': \'201709\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 945.9108993313}
{\'date\': \'201710\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 929.3961039597999}
{\'date\': \'201711\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 934.8664642336001}
{\'date\': \'201712\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 950.2314742738}
{\'date\': \'201801\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 944.262740242}
{\'date\': \'201802\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 910.2071983069}
{\'date\': \'201803\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 1001.5805704180001}
{\'date\': \'201804\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 922.8866098203999}
{\'date\': \'201805\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 998.277048418}
{\'date\': \'201806\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 915.0882157486001}
{\'date\': \'201807\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 925.1447440105001}
{\'date\': \'201808\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 905.1891737869}
{\'date\': \'201809\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 919.2360634263999}
{\'date\': \'201810\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 990.4226178920001}
{\'date\': \'201811\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 969.4429717600001}
{\'date\': \'201812\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 992.7897761770001}
{\'date\': \'201901\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 944.1741691468001}
{\'date\': \'201902\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 937.1152543888}
{\'date\': \'201903\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 921.2924263933}
{\'date\': \'201904\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 967.6851248313999}
{\'date\': \'201905\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 966.0460753513}
{\'date\': \'201906\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 919.8587582864}
{\'date\': \'201907\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 920.2757080016}
{\'date\': \'201908\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 943.0797405864}
{\'date\': \'201909\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 899.7782724440001}
{\'date\': \'201910\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 877.213665372}
{\'date\': \'201911\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 985.1090171344}
{\'date\': \'201912\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 971.0540382375999}
{\'date\': \'202001\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 963.4764079711999}
{\'date\': \'202002\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 897.1542688989001}
{\'date\': \'202003\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 950.2296372239}
{\'date\': \'202004\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 885.1892770228}
{\'date\': \'202005\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 891.1439298496}
{\'date\': \'202006\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 862.2388247176}
{\'date\': \'202007\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 869.2979540553999}
{\'date\': \'202008\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 904.9633002454001}
{\'date\': \'202009\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 873.5779779597999}
{\'date\': \'202010\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 871.8176744968}
{\'date\': \'202011\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 988.1480359708}
{\'date\': \'202012\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 982.4455264454999}
{\'date\': \'202101\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 983.7198175818}
{\'date\': \'202102\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 950.291985841}
{\'date\': \'202103\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 883.1105672996999}
{\'date\': \'202104\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 984.9634289848}
{\'date\': \'202105\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 993.6349187712}
{\'date\': \'202106\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 992.8422328152001}
{\'date\': \'202107\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 907.5491783000001}
{\'date\': \'202108\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 949.5183507319}
{\'date\': \'202109\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 939.5151127535999}
{\'date\': \'202110\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 918.3774130165998}
{\'date\': \'202111\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 926.4361686901}
{\'date\': \'202112\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 964.8442366856}
{\'date\': \'202201\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 915.0529465321}
{\'date\': \'202202\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 899.9816118942999}
{\'date\': \'202203\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 898.4908076857}
{\'date\': \'202204\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 963.3457807288}
{\'date\': \'202205\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 960.9930171378999}
{\'date\': \'202206\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 954.8340375466}
{\'date\': \'202207\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 953.4151755433}
{\'date\': \'202208\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 989.8312411144001}
{\'date\': \'202209\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 905.8609090108001}
{\'date\': \'202210\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 955.655490933}
{\'date\': \'202211\', \'share\': 11.0, \'commission\': 1.99, \'amount\': 982.0730326133001}
{\'date\': \'202212\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 977.996462834}
{\'date\': \'202301\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 940.570508545}
{\'date\': \'202302\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 904.9546474588}
{\'date\': \'202303\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 935.168155066}
{\'date\': \'202304\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 995.5895578870001}
{\'date\': \'202305\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 965.7442412610001}
{\'date\': \'202306\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 968.202426676}
{\'date\': \'202307\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 961.059988028}
{\'date\': \'202308\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 926.628943275}
{\'date\': \'202309\', \'share\': 11.0, \'commission\': 1.99, \'amount\': 987.9867257623999}
{\'date\': \'202310\', \'share\': 12.0, \'commission\': 1.99, \'amount\': 990.9826286404}
{\'date\': \'202311\', \'share\': 12.0, \'commission\': 1.99, \'amount\': 973.4200285972001}
{\'date\': \'202312\', \'share\': 11.0, \'commission\': 1.99, \'amount\': 978.0508922394001}
{\'date\': \'202401\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 943.0238582969998}
{\'date\': \'202402\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 945.3223318209999}
{\'date\': \'202403\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 911.956502084}
{\'date\': \'202404\', \'share\': 11.0, \'commission\': 1.99, \'amount\': 985.9199847310999}
{\'date\': \'202405\', \'share\': 11.0, \'commission\': 1.99, \'amount\': 946.7726797738999}
{\'date\': \'202406\', \'share\': 11.0, \'commission\': 1.99, \'amount\': 982.4932209071001}
{\'date\': \'202407\', \'share\': 11.0, \'commission\': 1.99, \'amount\': 967.5191812375}
{\'date\': \'202408\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 935.5355548440001}
{\'date\': \'202409\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 962.4985954440001}
{\'date\': \'202410\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 972.8726287139999}
{\'date\': \'202411\', \'share\': 11.0, \'commission\': 1.99, \'amount\': 990.3758720714}
{\'date\': \'202412\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 933.7083857319999}
{\'date\': \'202501\', \'share\': 11.0, \'commission\': 1.99, \'amount\': 961.8599307878999}
{\'date\': \'202502\', \'share\': 11.0, \'commission\': 1.99, \'amount\': 971.75}', 1740884187966, 1740884187972);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('9b6754b562fe4953b6a64d33e1c15e25', 'a92f50fe93864c8eb27fb1a2de201b7e', 'QQQ', '2024-1-1', '2025-1-22', 'import numpy
import pandas
import os
import sys

if __name__ == "__main__":
    print(sys.argv)
    df = pandas.read_csv(sys.argv[1])
    print(df.head())', 4, '[\'/judger/run/cb27de39-a4f1-4bf1-b95e-b139057ba475/__pycache__/solution.cpython-36.pyc\']


Error: Traceback (most recent call last):
  File "/judger/run/cb27de39-a4f1-4bf1-b95e-b139057ba475/solution.py", line 8, in <module>
    df = pandas.read_csv(sys.argv[1])
IndexError: list index out of range', 1740245730747, 1740245730753);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('a85b9e4abbe04862aaddee2049abe178', 'a92f50fe93864c8eb27fb1a2de201b7e', 'QQQ', '2015-1-1', '2025-3-1', 'import numpy
import pandas
import os
import sys


fixed_investment_amount = 1000

latest_price = 0.0

logs = []


def calculate_commission(share, price):     
    return min(
            share * price * 0.01,
            max(1.99, share * 0.011)
        )
    

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    
    
    for i in range(len(df)):
        date = df.iloc[i][\'date\']       # 2015-01-05 00:00:00+00:00
        close = df.iloc[i][\'close\']
        
        date = "".join(date.split("-")[:2])
        latest_price = close
        
        if not logs or logs[-1][\'date\'] != date:
            
            share = fixed_investment_amount // close
            commission = calculate_commission(share, close)
            amount = share * close + commission
            
            logs.append({
                \'date\': date,
                \'share\': share,
                \'commission\': commission,
                \'amount\': amount
            })
            
    total_commission = sum([log[\'commission\'] for log in logs])
    total_amount = sum([log[\'amount\'] for log in logs])
    total_share = sum([log[\'share\'] for log in logs])
    
    print("total_amount (include commission)", "->", total_amount)
    print("total_commission", "->", total_commission)
    print("total_share", "->", total_share)
    
    print("profit", "->", total_share * latest_price - total_amount)
    print("profit rate", "->", (total_share * latest_price / total_amount - 1) * 100, "%" )', 0, 'total_amount (include commission) -> 107551.21321032531
total_commission -> 242.78000000000037
total_share -> 600.0
profit -> 197350.7867896747
profit rate -> 183.49471000735144 %', 1740838162723, 1740838162727);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('a890fc04444548c78f45140ca5f7e1cb', 'a92f50fe93864c8eb27fb1a2de201b7e', 'QQQ', '2015-1-1', '2025-1-22', 'import numpy
import pandas
import os
import sys

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    print(df.head())', 0, 'symbol                       date      close  ...       dea      macd         cci
0    QQQ  2015-01-02 00:00:00+00:00  95.111716  ...  0.430448 -0.105756  -14.444698
1    QQQ  2015-01-05 00:00:00+00:00  93.716548  ...  0.370245 -0.240814  -87.045713
2    QQQ  2015-01-06 00:00:00+00:00  92.459971  ...  0.271143 -0.396409 -135.035562
3    QQQ  2015-01-07 00:00:00+00:00  93.651871  ...  0.171253 -0.399560 -110.563182
4    QQQ  2015-01-08 00:00:00+00:00  95.444340  ...  0.104313 -0.267760  -30.106202

[5 rows x 26 columns]', 1740280140644, 1740280140652);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('acf4cfd2f201448a8b75862bc61a9c8d', 'a92f50fe93864c8eb27fb1a2de201b7e', 'QQQ', '2015-1-1', '2025-3-1', 'import numpy
import pandas
import os
import sys


fixed_investment_amount = 1000

latest_price = 0.0

logs = []


def calculate_commission(share, price):     
    return min(
            share * price * 0.01,
            max(1.99, share * 0.011)
        )
    

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    
    
    for i in range(len(df)):
        date = df.iloc[i][\'date\']       # 2015-01-05 00:00:00+00:00
        close = df.iloc[i][\'close\']
        
        date = "".join(date.split("-")[:2])
        latest_price = close
        
        if not logs or logs[-1][\'date\'] != date:
            
            share = fixed_investment_amount // close
            commission = calculate_commission(share, close)
            amount = share * close + commission
            
            logs.append({
                \'date\': date,
                \'share\': share,
                \'commission\': commission,
                \'amount\': amount
            })
            
    total_commission = sum([log[\'commission\'] for log in logs])
    total_amount = sum([log[\'amount\'] for log in logs])
    total_share = sum([log[\'share\'] for log in logs])
    
    print("total_amount (include commission)", "->", round(total_amount, 2))
    print("total_commission", "->", round(total_commission, 2))
    print("total_share", "->", int(total_share))
    
    profit = total_share * latest_price - total_amount
    print("profit", "->", round(profit, 2))
    print("profit rate", "->", round(profit / total_amount * 100, 2), "%" )
    
    print("--------- logs ---------")
    for log in logs:
        print(log)', 0, 'total_amount (include commission) -> 107551.21
total_commission -> 242.78
total_share -> 600
profit -> 197350.79
profit rate -> 183.49 %
--------- logs ---------
{\'date\': \'201501\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 953.1071645989999}
{\'date\': \'201502\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 944.237216299}
{\'date\': \'201503\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 911.5477610013999}
{\'date\': \'201504\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 974.8210381660001}
{\'date\': \'201505\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 910.8762659758}
{\'date\': \'201506\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 922.2946445575}
{\'date\': \'201507\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 903.5385297652}
{\'date\': \'201508\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 934.2807331528}
{\'date\': \'201509\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 939.942793559}
{\'date\': \'201510\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 953.1446269790001}
{\'date\': \'201511\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 961.7889495043}
{\'date\': \'201512\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 966.3949125280001}
{\'date\': \'201601\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 921.8535870817}
{\'date\': \'201602\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 976.550701443}
{\'date\': \'201603\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 989.431591856}
{\'date\': \'201604\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 931.8221359786}
{\'date\': \'201605\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 1001.060572587}
{\'date\': \'201606\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 931.7378815264}
{\'date\': \'201607\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 915.063335335}
{\'date\': \'201608\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 980.6207842819}
{\'date\': \'201609\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 988.2240966595}
{\'date\': \'201610\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 894.465131776}
{\'date\': \'201611\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 985.3594516603}
{\'date\': \'201612\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 979.9391050147001}
{\'date\': \'201701\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 904.5888482367999}
{\'date\': \'201702\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 949.0618883584}
{\'date\': \'201703\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 994.4410006047999}
{\'date\': \'201704\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 877.8860902895001}
{\'date\': \'201705\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 910.3266862262}
{\'date\': \'201706\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 941.0459444196}
{\'date\': \'201707\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 906.1097608365999}
{\'date\': \'201708\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 955.0367065098}
{\'date\': \'201709\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 971.235048415}
{\'date\': \'201710\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 970.5675029874999}
{\'date\': \'201711\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 869.3813500936}
{\'date\': \'201712\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 883.0109709136}
{\'date\': \'201801\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 907.6988250832001}
{\'date\': \'201802\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 961.8161988826}
{\'date\': \'201803\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 941.9293497988}
{\'date\': \'201804\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 892.1400434541999}
{\'date\': \'201805\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 933.7540285096}
{\'date\': \'201806\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 990.7657604416002}
{\'date\': \'201807\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 993.2296183972}
{\'date\': \'201808\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 848.6738407145001}
{\'date\': \'201809\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 890.4057170100001}
{\'date\': \'201810\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 893.5312503924999}
{\'date\': \'201811\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 990.7545971482}
{\'date\': \'201812\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 992.306186368}
{\'date\': \'201901\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 894.6363211137999}
{\'date\': \'201902\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 967.0831461166001}
{\'date\': \'201903\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 839.5663598649999}
{\'date\': \'201904\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 877.8969565350001}
{\'date\': \'201905\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 911.0490051535}
{\'date\': \'201906\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 984.2529627274001}
{\'date\': \'201907\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 914.6481412770001}
{\'date\': \'201908\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 918.939939574}
{\'date\': \'201909\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 897.239835824}
{\'date\': \'201910\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 906.8729294395}
{\'date\': \'201911\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 962.9237757120001}
{\'date\': \'201912\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 982.879809773}
{\'date\': \'202001\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 839.3782355508}
{\'date\': \'202002\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 863.4740665328}
{\'date\': \'202003\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 840.3854567816}
{\'date\': \'202004\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 886.688111171}
{\'date\': \'202005\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 827.8829347616}
{\'date\': \'202006\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 910.6508080772}
{\'date\': \'202007\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 976.1069498332001}
{\'date\': \'202008\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 787.6729332888999}
{\'date\': \'202009\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 876.7469431732}
{\'date\': \'202010\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 826.4047636717}
{\'date\': \'202011\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 790.565723281}
{\'date\': \'202012\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 888.3563567185}
{\'date\': \'202101\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 907.0850700403}
{\'date\': \'202102\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 945.4472192377}
{\'date\': \'202103\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 948.8708435368001}
{\'date\': \'202104\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 952.9150011588999}
{\'date\': \'202105\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 986.9592705412001}
{\'date\': \'202106\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 977.0858464606}
{\'date\': \'202107\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 695.3339778922}
{\'date\': \'202108\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 714.9471434116}
{\'date\': \'202109\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 746.1952376291999}
{\'date\': \'202110\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 707.101216852}
{\'date\': \'202111\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 760.4475455188001}
{\'date\': \'202112\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 759.8406698532001}
{\'date\': \'202201\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 789.3593072686}
{\'date\': \'202202\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 718.4788199384}
{\'date\': \'202203\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 671.3754429874}
{\'date\': \'202204\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 712.1636175444}
{\'date\': \'202205\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 939.5722594261001}
{\'date\': \'202206\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 902.8320352435001}
{\'date\': \'202207\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 834.118896364}
{\'date\': \'202208\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 931.8637360672001}
{\'date\': \'202209\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 885.0559326244}
{\'date\': \'202210\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 810.1910092845999}
{\'date\': \'202211\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 814.8594463653999}
{\'date\': \'202212\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 869.8465438786}
{\'date\': \'202301\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 785.3496218287}
{\'date\': \'202302\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 893.2807493977}
{\'date\': \'202303\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 864.4912170163}
{\'date\': \'202304\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 951.7013310721001}
{\'date\': \'202305\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 957.7529041327}
{\'date\': \'202306\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 698.13844219}
{\'date\': \'202307\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 735.2955087374}
{\'date\': \'202308\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 760.0499413692}
{\'date\': \'202309\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 749.7520973942}
{\'date\': \'202310\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 718.4529584932001}
{\'date\': \'202311\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 709.9250541542}
{\'date\': \'202312\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 775.3320972012}
{\'date\': \'202401\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 802.4249138710001}
{\'date\': \'202402\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 840.777554246}
{\'date\': \'202403\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 887.957863012}
{\'date\': \'202404\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 887.8052511096}
{\'date\': \'202405\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 841.1603441908001}
{\'date\': \'202406\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 904.090156726}
{\'date\': \'202407\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 962.9473276598}
{\'date\': \'202408\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 918.5604789842}
{\'date\': \'202409\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 922.8476184564}
{\'date\': \'202410\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 962.9959414022001}
{\'date\': \'202411\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 975.2963062682}
{\'date\': \'202412\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 516.4587509559}
{\'date\': \'202501\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 512.22}
{\'date\': \'202502\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 520.1}', 1740838675906, 1740838675909);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('acfd6b61ecac4265b02fb41f1a857587', 'a92f50fe93864c8eb27fb1a2de201b7e', 'TLT', '2015-01-01', '2020-05-01', 'import numpy
import pandas
import os
import sys


fixed_investment_amount = 1000

latest_price = 0.0

logs = []


def calculate_commission(share, price):     
    return min(
            share * price * 0.01,
            max(1.99, share * 0.011)
        )
    

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    
    
    for i in range(len(df)):
        date = df.iloc[i][\'date\']       # 2015-01-05 00:00:00+00:00
        close = df.iloc[i][\'close\']
        
        date = "".join(date.split("-")[:2])
        latest_price = close
        
        if not logs or logs[-1][\'date\'] != date:
            
            share = fixed_investment_amount // close
            commission = calculate_commission(share, close)
            amount = share * close + commission
            
            logs.append({
                \'date\': date,
                \'share\': share,
                \'commission\': commission,
                \'amount\': amount
            })
            
    total_commission = sum([log[\'commission\'] for log in logs])
    total_amount = sum([log[\'amount\'] for log in logs])
    total_share = sum([log[\'share\'] for log in logs])
    
    print("total_amount (include commission)", "->", round(total_amount, 2))
    print("total_commission", "->", round(total_commission, 2))
    print("total_share", "->", int(total_share))
    
    profit = total_share * latest_price - total_amount
    print("profit", "->", round(profit, 2))
    print("profit rate", "->", round(profit / total_amount * 100, 2), "%" )
    
    print("--------- logs ---------")
    for log in logs:
        print(log)', 0, 'total_amount (include commission) -> 61580.61
total_commission -> 129.35
total_share -> 585
profit -> 25111.89
profit rate -> 40.78 %
--------- logs ---------
{\'date\': \'201501\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 988.365918276}
{\'date\': \'201502\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 962.5143627712}
{\'date\': \'201503\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 988.831435452}
{\'date\': \'201504\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 928.8817656534999}
{\'date\': \'201505\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 970.512656801}
{\'date\': \'201506\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 950.160840273}
{\'date\': \'201507\', \'share\': 11.0, \'commission\': 1.99, \'amount\': 999.7571003960002}
{\'date\': \'201508\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 973.36137424}
{\'date\': \'201509\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 963.4760292780002}
{\'date\': \'201510\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 979.5199478879999}
{\'date\': \'201511\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 966.939387743}
{\'date\': \'201512\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 975.932265015}
{\'date\': \'201601\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 966.997969414}
{\'date\': \'201602\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 909.5498459848}
{\'date\': \'201603\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 923.9395379968001}
{\'date\': \'201604\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 942.0323113288}
{\'date\': \'201605\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 923.3306270497001}
{\'date\': \'201606\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 943.9982463871}
{\'date\': \'201607\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 906.1354440656}
{\'date\': \'201608\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 902.6502486375999}
{\'date\': \'201609\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 904.2881073872001}
{\'date\': \'201610\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 997.3725833719001}
{\'date\': \'201611\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 956.9916704908001}
{\'date\': \'201612\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 965.6069261270002}
{\'date\': \'201701\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 975.53575238}
{\'date\': \'201702\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 973.250466834}
{\'date\': \'201703\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 978.1750836010001}
{\'date\': \'201704\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 998.231188954}
{\'date\': \'201705\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 995.486633318}
{\'date\': \'201706\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 920.7502779888998}
{\'date\': \'201707\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 924.9510290697999}
{\'date\': \'201708\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 928.2781307926}
{\'date\': \'201709\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 945.9108993313}
{\'date\': \'201710\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 929.3961039597999}
{\'date\': \'201711\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 934.8664642336001}
{\'date\': \'201712\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 950.2314742738}
{\'date\': \'201801\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 944.262740242}
{\'date\': \'201802\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 910.2071983069}
{\'date\': \'201803\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 1001.5805704180001}
{\'date\': \'201804\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 922.8866098203999}
{\'date\': \'201805\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 998.277048418}
{\'date\': \'201806\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 915.0882157486001}
{\'date\': \'201807\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 925.1447440105001}
{\'date\': \'201808\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 905.1891737869}
{\'date\': \'201809\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 919.2360634263999}
{\'date\': \'201810\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 990.4226178920001}
{\'date\': \'201811\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 969.4429717600001}
{\'date\': \'201812\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 992.7897761770001}
{\'date\': \'201901\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 944.1741691468001}
{\'date\': \'201902\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 937.1152543888}
{\'date\': \'201903\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 921.2924263933}
{\'date\': \'201904\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 967.6851248313999}
{\'date\': \'201905\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 966.0460753513}
{\'date\': \'201906\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 919.8587582864}
{\'date\': \'201907\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 920.2757080016}
{\'date\': \'201908\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 943.0797405864}
{\'date\': \'201909\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 899.7782724440001}
{\'date\': \'201910\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 877.213665372}
{\'date\': \'201911\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 985.1090171344}
{\'date\': \'201912\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 971.0540382375999}
{\'date\': \'202001\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 963.4764079711999}
{\'date\': \'202002\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 897.1542688989001}
{\'date\': \'202003\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 950.2296372239}
{\'date\': \'202004\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 885.1892770228}
{\'date\': \'202005\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 891.1439298496}', 1740839345881, 1740839345883);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('ade25c2f4ceb4bb6bb2e11e3bc6946ac', 'a92f50fe93864c8eb27fb1a2de201b7e', 'QQQ', '2015-1-1', '2025-3-1', 'import numpy
import pandas
import os
import sys


fixed_investment_amount = 1000

latest_price = 0.0

logs = []


def calculate_commission(share, price):     
    return min(
            share * price * 0.01,
            max(1.99, share * 0.011)
        )
    

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    
    
    for i in range(len(df)):
        date = df.iloc[i][\'date\']       # 2015-01-05 00:00:00+00:00
        close = df.iloc[i][\'close\']
        
        date = "".join(date.split("-")[:2])
        latest_price = close
        
        if not logs or logs[-1][\'date\'] != date:
            
            share = fixed_investment_amount // close
            commission = calculate_commission(share, close)
            amount = share * close + commission
            
            logs.append({
                \'date\': date,
                \'share\': share,
                \'commission\': commission,
                \'amount\': amount
            })
            
    total_commission = sum([log[\'commission\'] for log in logs])
    total_amount = sum([log[\'amount\'] for log in logs])
    total_share = sum([log[\'share\'] for log in logs])
    
    print("total_amount (include commission)", "->", round(total_amount, 2))
    print("total_commission", "->", round(total_commission, 2))
    print("total_share", "->", int(total_share))
    
    profit = total_share * latest_price - total_amount
    print("profit", "->", round(profit, 2))
    print("profit rate", "->", round(profit / total_amount * 100, 2), "%" )', -2, null, 1740838378223, 1740838378227);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('af1bb4ab830942dda68e038ac0c1ccf7', 'a92f50fe93864c8eb27fb1a2de201b7e', 'QQQ', '2024-1-1', '2025-1-22', 'import numpy
import pandas
import os
import sys

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    print(df.head())
', -3, null, 1740244713464, 1740244713472);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('b10fff73c2924272a62b60ae183277f0', 'a92f50fe93864c8eb27fb1a2de201b7e', 'QQQ', '2015-1-1', '2025-3-1', 'import numpy
import pandas
import os
import sys

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    print(df.head())
    print(df.iloc[1])
    print(df.iloc[1][\'close\'])', 0, 'symbol                       date      close  ...       dea      macd         cci
0    QQQ  2015-01-02 00:00:00+00:00  95.111716  ...  0.430448 -0.105756  -14.444698
1    QQQ  2015-01-05 00:00:00+00:00  93.716548  ...  0.370245 -0.240814  -87.045713
2    QQQ  2015-01-06 00:00:00+00:00  92.459971  ...  0.271143 -0.396409 -135.035562
3    QQQ  2015-01-07 00:00:00+00:00  93.651871  ...  0.171253 -0.399560 -110.563182
4    QQQ  2015-01-08 00:00:00+00:00  95.444340  ...  0.104313 -0.267760  -30.106202

[5 rows x 26 columns]
symbol                               QQQ
date           2015-01-05 00:00:00+00:00
close                            93.7165
high                             94.8068
low                              93.4486
open                             94.6959
volume                          36521270
adjClose                         93.7165
adjHigh                          94.8068
adjLow                           93.4486
adjOpen                          94.6959
adjVolume                       36521270
divCash                                0
splitFactor                            1
delta                         -0.0146687
bbh                              98.2525
bbm                              95.5361
bbl                              92.8197
ma5                              95.5293
ma10                             96.0366
ma20                             95.5361
ma60                             93.4957
dif                             0.129431
dea                             0.370245
macd                           -0.240814
cci                             -87.0457
Name: 1, dtype: object
93.7165475086', 1740836727210, 1740836727215);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('b630fa94235043728fd0e2b608b4c7bb', 'a92f50fe93864c8eb27fb1a2de201b7e', 'QQQ', '2024-1-1', '2025-1-22', 'import numpy
import pandas
import os
import sys

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    print(df.head())', 4, 'Error: Traceback (most recent call last):
  File "/judger/run/eb3a5d72-ec0b-47e3-8c8e-47872dfb325c/solution.py", line 7, in <module>
    df = pandas.read_csv(sys.argv[1])
IndexError: list index out of range', 1740245702953, 1740245702960);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('b78c7c3371344620b315002ea2f01bd7', 'a92f50fe93864c8eb27fb1a2de201b7e', 'QQQ', '2015-1-1', '2025-3-1', 'import numpy
import pandas
import os
import sys

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    print(df.head())', 0, 'symbol                       date      close  ...       dea      macd         cci
0    QQQ  2015-01-02 00:00:00+00:00  95.111716  ...  0.430448 -0.105756  -14.444698
1    QQQ  2015-01-05 00:00:00+00:00  93.716548  ...  0.370245 -0.240814  -87.045713
2    QQQ  2015-01-06 00:00:00+00:00  92.459971  ...  0.271143 -0.396409 -135.035562
3    QQQ  2015-01-07 00:00:00+00:00  93.651871  ...  0.171253 -0.399560 -110.563182
4    QQQ  2015-01-08 00:00:00+00:00  95.444340  ...  0.104313 -0.267760  -30.106202

[5 rows x 26 columns]', 1740836511942, 1740836511947);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('b997ff82054b47ff89dced02a7bbc405', 'a92f50fe93864c8eb27fb1a2de201b7e', 'AMD', '2015-1-1', '2025-1-22', 'import numpy
import pandas
import os
import sys

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    print(df.head())', 0, 'symbol                       date  close  ...       dea      macd        cci
0    AMD  2015-01-02 00:00:00+00:00   2.69  ... -0.035003  0.022413  83.284837
1    AMD  2015-01-05 00:00:00+00:00   2.66  ... -0.029975  0.020111  57.821637
2    AMD  2015-01-06 00:00:00+00:00   2.63  ... -0.025982  0.015973  -8.753773
3    AMD  2015-01-07 00:00:00+00:00   2.58  ... -0.023585  0.009587 -57.519380
4    AMD  2015-01-08 00:00:00+00:00   2.61  ... -0.021782  0.007212 -50.604961

[5 rows x 26 columns]', 1740247937674, 1740247937678);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('bdccd306520c4f6fb9d42fcc0225ee2a', 'a92f50fe93864c8eb27fb1a2de201b7e', 'QQQ', '2024-1-1', '2025-1-22', 'import numpy
import pandas
import os
import sys

if __name__ == "__main__":
    print(sys.argv)
    df = pandas.read_csv(sys.argv[1])
    print(df.head())', 0, '[\'/judger/run/de9dd718-16f8-4fc3-be98-b3966764d555/__pycache__/solution.cpython-36.pyc\', \'/judger/run/de9dd718-16f8-4fc3-be98-b3966764d555/test_case/138f07da-39a1-40ff-8dfb-7f669e3fef7c.csv\']
  symbol                       date       close  ...       dea      macd         cci
0    QQQ  2024-01-02 00:00:00+00:00  400.217457  ...  7.453356 -0.618123  -59.764632
1    QQQ  2024-01-03 00:00:00+00:00  395.982562  ...  7.113944 -1.357648 -149.875580
2    QQQ  2024-01-04 00:00:00+00:00  393.944643  ...  6.627717 -1.944909 -164.024126
3    QQQ  2024-01-05 00:00:00+00:00  394.411873  ...  6.067306 -2.241644 -141.956099
4    QQQ  2024-01-08 00:00:00+00:00  402.563549  ...  5.606002 -1.845214  -46.085107

[5 rows x 26 columns]


Error:', 1740246013581, 1740246013589);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('c580328867a24946b3f335d1152f821f', 'a92f50fe93864c8eb27fb1a2de201b7e', 'QQQ', '2015-1-1', '2025-3-1', 'import numpy
import pandas
import os
import sys

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    print(df.head())
    print(df.iloc[1])
    print(df.iloc[1][\'close\'])', 0, 'symbol                       date      close  ...       dea      macd         cci
0    QQQ  2015-01-02 00:00:00+00:00  95.111716  ...  0.430448 -0.105756  -14.444698
1    QQQ  2015-01-05 00:00:00+00:00  93.716548  ...  0.370245 -0.240814  -87.045713
2    QQQ  2015-01-06 00:00:00+00:00  92.459971  ...  0.271143 -0.396409 -135.035562
3    QQQ  2015-01-07 00:00:00+00:00  93.651871  ...  0.171253 -0.399560 -110.563182
4    QQQ  2015-01-08 00:00:00+00:00  95.444340  ...  0.104313 -0.267760  -30.106202

[5 rows x 26 columns]
symbol                               QQQ
date           2015-01-05 00:00:00+00:00
close                            93.7165
high                             94.8068
low                              93.4486
open                             94.6959
volume                          36521270
adjClose                         93.7165
adjHigh                          94.8068
adjLow                           93.4486
adjOpen                          94.6959
adjVolume                       36521270
divCash                                0
splitFactor                            1
delta                         -0.0146687
bbh                              98.2525
bbm                              95.5361
bbl                              92.8197
ma5                              95.5293
ma10                             96.0366
ma20                             95.5361
ma60                             93.4957
dif                             0.129431
dea                             0.370245
macd                           -0.240814
cci                             -87.0457
Name: 1, dtype: object
93.7165475086', 1740836768073, 1740836768077);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('c7654df1074a4f448fa1c339a63d3cf6', 'a92f50fe93864c8eb27fb1a2de201b7e', 'QQQ', '2015-1-1', '2025-3-1', 'import numpy
import pandas
import os
import sys

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    print(df.head())', 0, 'symbol                       date      close  ...       dea      macd         cci
0    QQQ  2015-01-02 00:00:00+00:00  95.111716  ...  0.430448 -0.105756  -14.444698
1    QQQ  2015-01-05 00:00:00+00:00  93.716548  ...  0.370245 -0.240814  -87.045713
2    QQQ  2015-01-06 00:00:00+00:00  92.459971  ...  0.271143 -0.396409 -135.035562
3    QQQ  2015-01-07 00:00:00+00:00  93.651871  ...  0.171253 -0.399560 -110.563182
4    QQQ  2015-01-08 00:00:00+00:00  95.444340  ...  0.104313 -0.267760  -30.106202

[5 rows x 26 columns]', 1740836480886, 1740836480894);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('db674b1a5f6b47ff86f583d4ba0344de', 'a92f50fe93864c8eb27fb1a2de201b7e', 'QQQ', '2015-1-1', '2025-7-26', 'import numpy
import pandas
import os
import sys


fixed_investment_amount = 1000

latest_price = 0.0

logs = []


def calculate_commission(share, price):     
    return min(
            share * price * 0.01,
            max(1.99, share * 0.011)
        )
    

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    
    
    for i in range(len(df)):
        date = df.iloc[i][\'date\']       # 2015-01-05 00:00:00+00:00
        close = df.iloc[i][\'close\']
        
        date = "".join(date.split("-")[:2])
        latest_price = close
        
        if not logs or logs[-1][\'date\'] != date:
            
            share = fixed_investment_amount // close
            commission = calculate_commission(share, close)
            amount = share * close + commission
            
            logs.append({
                \'date\': date,
                \'share\': share,
                \'commission\': commission,
                \'amount\': amount
            })
            
    total_commission = sum([log[\'commission\'] for log in logs])
    total_amount = sum([log[\'amount\'] for log in logs])
    total_share = sum([log[\'share\'] for log in logs])
    
    print("total_amount (include commission)", "->", round(total_amount, 2))
    print("total_commission", "->", round(total_commission, 2))
    print("total_share", "->", int(total_share))
    
    profit = total_share * latest_price - total_amount
    print("profit", "->", round(profit, 2))
    print("profit rate", "->", round(profit / total_amount * 100, 2), "%" )
    
    print("--------- logs ---------")
    for log in logs:
        print(log)', 0, 'total_amount (include commission) -> 111478.39
total_commission -> 252.73
total_share -> 610
profit -> 234007.31
profit rate -> 209.91 %
--------- logs ---------
{\'date\': \'201501\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 950.667043707}
{\'date\': \'201502\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 941.8198515370002}
{\'date\': \'201503\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 909.2142620614}
{\'date\': \'201504\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 972.3252096499999}
{\'date\': \'201505\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 908.5444897771001}
{\'date\': \'201506\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 919.9335741508}
{\'date\': \'201507\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 1001.140643065}
{\'date\': \'201508\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 931.88891206}
{\'date\': \'201509\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 937.5364462729999}
{\'date\': \'201510\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 950.7044099760001}
{\'date\': \'201511\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 959.3265552202}
{\'date\': \'201512\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 963.9207015021999}
{\'date\': \'201601\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 919.4936482216}
{\'date\': \'201602\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 974.050435422}
{\'date\': \'201603\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 986.898279507}
{\'date\': \'201604\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 929.4366224935}
{\'date\': \'201605\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 998.4974257229999}
{\'date\': \'201606\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 929.3525841988}
{\'date\': \'201607\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 912.7208170783001}
{\'date\': \'201608\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 978.1100763355001}
{\'date\': \'201609\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 985.6938821778999}
{\'date\': \'201610\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 892.1754588568}
{\'date\': \'201611\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 982.8365865147999}
{\'date\': \'201612\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 977.4301459384001}
{\'date\': \'201701\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 902.2732026056}
{\'date\': \'201702\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 946.6321457488001}
{\'date\': \'201703\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 991.8948364608}
{\'date\': \'201704\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 1000.4459444808}
{\'date\': \'201705\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 907.9963199915001}
{\'date\': \'201706\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 938.636766965}
{\'date\': \'201707\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 903.7902132559001}
{\'date\': \'201708\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 952.5916353169001}
{\'date\': \'201709\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 968.7484198684999}
{\'date\': \'201710\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 968.0825870498}
{\'date\': \'201711\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 867.1560304018001}
{\'date\': \'201712\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 880.7506840024}
{\'date\': \'201801\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 905.3752007086}
{\'date\': \'201802\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 959.3537346897999}
{\'date\': \'201803\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 939.5179059406}
{\'date\': \'201804\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 889.8563356216}
{\'date\': \'201805\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 931.3635586942}
{\'date\': \'201806\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 988.2290252416001}
{\'date\': \'201807\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 990.6865620922001}
{\'date\': \'201808\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 846.501646787}
{\'date\': \'201809\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 888.126458646}
{\'date\': \'201810\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 891.243973375}
{\'date\': \'201811\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 988.2178905874}
{\'date\': \'201812\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 989.7654991570001}
{\'date\': \'201901\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 892.3462090024002}
{\'date\': \'201902\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 964.6071694054001}
{\'date\': \'201903\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 837.4175314649999}
{\'date\': \'201904\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 875.6497897885001}
{\'date\': \'201905\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 908.7167857870002}
{\'date\': \'201906\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 981.7329363135999}
{\'date\': \'201907\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 912.3066882139999}
{\'date\': \'201908\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 916.587475768}
{\'date\': \'201909\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 894.943044314}
{\'date\': \'201910\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 904.551423926}
{\'date\': \'201911\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 960.4584699965}
{\'date\': \'201912\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 980.3633062265001}
{\'date\': \'202001\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 837.2298897896001}
{\'date\': \'202002\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 861.2639021624001}
{\'date\': \'202003\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 838.2345269628}
{\'date\': \'202004\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 884.4183904415}
{\'date\': \'202005\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 825.7640805552}
{\'date\': \'202006\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 908.319610298}
{\'date\': \'202007\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 973.6078222708}
{\'date\': \'202008\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 785.6572391014001}
{\'date\': \'202009\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 874.5027268219}
{\'date\': \'202010\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 824.2897017595001}
{\'date\': \'202011\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 788.5426075501}
{\'date\': \'202012\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 886.0823560527999}
{\'date\': \'202101\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 904.7630202739}
{\'date\': \'202102\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 943.0267501750001}
{\'date\': \'202103\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 946.4415910588}
{\'date\': \'202104\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 950.4753732675999}
{\'date\': \'202105\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 984.4323010102}
{\'date\': \'202106\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 974.5842075082}
{\'date\': \'202107\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 693.5551821884}
{\'date\': \'202108\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 713.1180295172001}
{\'date\': \'202109\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 744.2859557696}
{\'date\': \'202110\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 705.2922319280001}
{\'date\': \'202111\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 758.5016989167999}
{\'date\': \'202112\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 757.8963802098}
{\'date\': \'202201\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 787.3392866358}
{\'date\': \'202202\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 716.640645417}
{\'date\': \'202203\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 669.6581136558}
{\'date\': \'202204\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 710.3416448728}
{\'date\': \'202205\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 937.166862757}
{\'date\': \'202206\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 900.5208967710998}
{\'date\': \'202207\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 831.9840436024001}
{\'date\': \'202208\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 929.4781158565}
{\'date\': \'202209\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 882.7903993002999}
{\'date\': \'202210\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 808.1175442675001}
{\'date\': \'202211\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 812.7740043265001}
{\'date\': \'202212\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 867.6200307178001}
{\'date\': \'202301\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 783.3398881692999}
{\'date\': \'202302\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 890.9941150483}
{\'date\': \'202303\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 862.2784431145001}
{\'date\': \'202304\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 949.2648168895}
{\'date\': \'202305\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 955.3008644500001}
{\'date\': \'202306\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 696.3524515452001}
{\'date\': \'202307\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 733.4141904738001}
{\'date\': \'202308\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 758.105114833}
{\'date\': \'202309\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 747.8336902996001}
{\'date\': \'202310\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 716.6148503202}
{\'date\': \'202311\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 708.108824587}
{\'date\': \'202312\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 773.3480638152}
{\'date\': \'202401\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 800.3713730147999}
{\'date\': \'202402\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 838.625618489}
{\'date\': \'202403\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 885.6848846946001}
{\'date\': \'202404\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 885.5326643226}
{\'date\': \'202405\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 839.0074263744}
{\'date\': \'202406\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 901.7757905034}
{\'date\': \'202407\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 960.4819615206}
{\'date\': \'202408\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 916.2089886964}
{\'date\': \'202409\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 920.485129378}
{\'date\': \'202410\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 960.5304505427999}
{\'date\': \'202411\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 972.7992584374001}
{\'date\': \'202412\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 515.1388652526}
{\'date\': \'202501\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 510.91098894510003}
{\'date\': \'202502\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 518.7707725581}
{\'date\': \'202503\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 993.5396052962}
{\'date\': \'202504\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 946.34003339}
{\'date\': \'202505\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 964.280086912}
{\'date\': \'202506\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 524.6189200021}
{\'date\': \'202507\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 548.98}', 1753541797203, 1753541797217);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('dd21f9e917284a21bbf718635c8aea70', 'a92f50fe93864c8eb27fb1a2de201b7e', 'QQQ', '2015-1-1', '2025-3-1', 'import numpy
import pandas
import os
import sys


fixed_investment_amount = 1000

latest_price = 0.0

logs = []


def calculate_commission(share, price):     
    return min(
            share * price * 0.01,
            max(1.99, share * 0.011)
        )
    

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    
    
    for i in range(len(df)):
        date = df.iloc[i][\'date\']       # 2015-01-05 00:00:00+00:00
        close = df.iloc[i][\'close\']
        
        date = "".join(date.split("-")[:2])
        latest_price = close
        
        if not logs or logs[-1][\'date\'] != date:
            
            share = fixed_investment_amount // close
            commission = calculate_commission(share, close)
            amount = share * close + commission
            
            logs.append({
                \'date\': date,
                \'share\': share,
                \'commission\': commission,
                \'amount\': amount
            })
            
    total_commission = sum([log[\'commission\'] for log in logs])
    total_amount = sum([log[\'amount\'] for log in logs])
    total_share = sum([log[\'share\'] for log in logs])
    
    print("total_amount (include commission)", "->", round(total_amount, 2))
    print("total_commission", "->", round(total_commission, 2))
    print("total_share", "->", int(total_share))
    
    profit = total_share * latest_price - total_amount
    print("profit", "->", round(, 2))
    print("profit rate", "->", round(profit / total_amount * 100, 2), "%" )', 6, 'File "/judger/run/b9aa2f14-3caf-4638-8892-54251d3cc954/solution.py", line 54
    print("profit", "->", round(, 2))
                                ^
SyntaxError: invalid syntax', 1740838365630, 1740838365633);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('deade36a40ef4279a3d09da3c3c5b74d', 'a92f50fe93864c8eb27fb1a2de201b7e', 'TLT', '2015-1-1', '2025-3-1', 'import numpy
import pandas
import os
import sys


fixed_investment_amount = 1000

latest_price = 0.0

logs = []


def calculate_commission(share, price):     
    return min(
            share * price * 0.01,
            max(1.99, share * 0.011)
        )
    

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    
    
    for i in range(len(df)):
        date = df.iloc[i][\'date\']       # 2015-01-05 00:00:00+00:00
        close = df.iloc[i][\'close\']
        
        date = "".join(date.split("-")[:2])
        latest_price = close
        
        if not logs or logs[-1][\'date\'] != date:
            
            share = fixed_investment_amount // close
            commission = calculate_commission(share, close)
            amount = share * close + commission
            
            logs.append({
                \'date\': date,
                \'share\': share,
                \'commission\': commission,
                \'amount\': amount
            })
            
    total_commission = sum([log[\'commission\'] for log in logs])
    total_amount = sum([log[\'amount\'] for log in logs])
    total_share = sum([log[\'share\'] for log in logs])
    
    print("total_amount (include commission)", "->", round(total_amount, 2))
    print("total_commission", "->", round(total_commission, 2))
    print("total_share", "->", int(total_share))
    
    profit = total_share * latest_price - total_amount
    print("profit", "->", round(profit, 2))
    print("profit rate", "->", round(profit / total_amount * 100, 2), "%" )
    
    print("--------- logs ---------")
    for log in logs:
        print(log)', 0, 'total_amount (include commission) -> 115625.4
total_commission -> 242.78
total_share -> 1093
profit -> -14599.41
profit rate -> -12.63 %
--------- logs ---------
{\'date\': \'201501\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 988.365918276}
{\'date\': \'201502\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 962.5143627712}
{\'date\': \'201503\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 988.831435452}
{\'date\': \'201504\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 928.8817656534999}
{\'date\': \'201505\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 970.512656801}
{\'date\': \'201506\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 950.160840273}
{\'date\': \'201507\', \'share\': 11.0, \'commission\': 1.99, \'amount\': 999.7571003960002}
{\'date\': \'201508\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 973.36137424}
{\'date\': \'201509\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 963.4760292780002}
{\'date\': \'201510\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 979.5199478879999}
{\'date\': \'201511\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 966.939387743}
{\'date\': \'201512\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 975.932265015}
{\'date\': \'201601\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 966.997969414}
{\'date\': \'201602\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 909.5498459848}
{\'date\': \'201603\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 923.9395379968001}
{\'date\': \'201604\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 942.0323113288}
{\'date\': \'201605\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 923.3306270497001}
{\'date\': \'201606\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 943.9982463871}
{\'date\': \'201607\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 906.1354440656}
{\'date\': \'201608\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 902.6502486375999}
{\'date\': \'201609\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 904.2881073872001}
{\'date\': \'201610\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 997.3725833719001}
{\'date\': \'201611\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 956.9916704908001}
{\'date\': \'201612\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 965.6069261270002}
{\'date\': \'201701\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 975.53575238}
{\'date\': \'201702\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 973.250466834}
{\'date\': \'201703\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 978.1750836010001}
{\'date\': \'201704\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 998.231188954}
{\'date\': \'201705\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 995.486633318}
{\'date\': \'201706\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 920.7502779888998}
{\'date\': \'201707\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 924.9510290697999}
{\'date\': \'201708\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 928.2781307926}
{\'date\': \'201709\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 945.9108993313}
{\'date\': \'201710\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 929.3961039597999}
{\'date\': \'201711\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 934.8664642336001}
{\'date\': \'201712\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 950.2314742738}
{\'date\': \'201801\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 944.262740242}
{\'date\': \'201802\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 910.2071983069}
{\'date\': \'201803\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 1001.5805704180001}
{\'date\': \'201804\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 922.8866098203999}
{\'date\': \'201805\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 998.277048418}
{\'date\': \'201806\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 915.0882157486001}
{\'date\': \'201807\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 925.1447440105001}
{\'date\': \'201808\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 905.1891737869}
{\'date\': \'201809\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 919.2360634263999}
{\'date\': \'201810\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 990.4226178920001}
{\'date\': \'201811\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 969.4429717600001}
{\'date\': \'201812\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 992.7897761770001}
{\'date\': \'201901\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 944.1741691468001}
{\'date\': \'201902\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 937.1152543888}
{\'date\': \'201903\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 921.2924263933}
{\'date\': \'201904\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 967.6851248313999}
{\'date\': \'201905\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 966.0460753513}
{\'date\': \'201906\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 919.8587582864}
{\'date\': \'201907\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 920.2757080016}
{\'date\': \'201908\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 943.0797405864}
{\'date\': \'201909\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 899.7782724440001}
{\'date\': \'201910\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 877.213665372}
{\'date\': \'201911\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 985.1090171344}
{\'date\': \'201912\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 971.0540382375999}
{\'date\': \'202001\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 963.4764079711999}
{\'date\': \'202002\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 897.1542688989001}
{\'date\': \'202003\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 950.2296372239}
{\'date\': \'202004\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 885.1892770228}
{\'date\': \'202005\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 891.1439298496}
{\'date\': \'202006\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 862.2388247176}
{\'date\': \'202007\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 869.2979540553999}
{\'date\': \'202008\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 904.9633002454001}
{\'date\': \'202009\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 873.5779779597999}
{\'date\': \'202010\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 871.8176744968}
{\'date\': \'202011\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 988.1480359708}
{\'date\': \'202012\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 982.4455264454999}
{\'date\': \'202101\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 983.7198175818}
{\'date\': \'202102\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 950.291985841}
{\'date\': \'202103\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 883.1105672996999}
{\'date\': \'202104\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 984.9634289848}
{\'date\': \'202105\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 993.6349187712}
{\'date\': \'202106\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 992.8422328152001}
{\'date\': \'202107\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 907.5491783000001}
{\'date\': \'202108\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 949.5183507319}
{\'date\': \'202109\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 939.5151127535999}
{\'date\': \'202110\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 918.3774130165998}
{\'date\': \'202111\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 926.4361686901}
{\'date\': \'202112\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 964.8442366856}
{\'date\': \'202201\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 915.0529465321}
{\'date\': \'202202\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 899.9816118942999}
{\'date\': \'202203\', \'share\': 7.0, \'commission\': 1.99, \'amount\': 898.4908076857}
{\'date\': \'202204\', \'share\': 8.0, \'commission\': 1.99, \'amount\': 963.3457807288}
{\'date\': \'202205\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 960.9930171378999}
{\'date\': \'202206\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 954.8340375466}
{\'date\': \'202207\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 953.4151755433}
{\'date\': \'202208\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 989.8312411144001}
{\'date\': \'202209\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 905.8609090108001}
{\'date\': \'202210\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 955.655490933}
{\'date\': \'202211\', \'share\': 11.0, \'commission\': 1.99, \'amount\': 982.0730326133001}
{\'date\': \'202212\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 977.996462834}
{\'date\': \'202301\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 940.570508545}
{\'date\': \'202302\', \'share\': 9.0, \'commission\': 1.99, \'amount\': 904.9546474588}
{\'date\': \'202303\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 935.168155066}
{\'date\': \'202304\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 995.5895578870001}
{\'date\': \'202305\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 965.7442412610001}
{\'date\': \'202306\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 968.202426676}
{\'date\': \'202307\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 961.059988028}
{\'date\': \'202308\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 926.628943275}
{\'date\': \'202309\', \'share\': 11.0, \'commission\': 1.99, \'amount\': 987.9867257623999}
{\'date\': \'202310\', \'share\': 12.0, \'commission\': 1.99, \'amount\': 990.9826286404}
{\'date\': \'202311\', \'share\': 12.0, \'commission\': 1.99, \'amount\': 973.4200285972001}
{\'date\': \'202312\', \'share\': 11.0, \'commission\': 1.99, \'amount\': 978.0508922394001}
{\'date\': \'202401\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 943.0238582969998}
{\'date\': \'202402\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 945.3223318209999}
{\'date\': \'202403\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 911.956502084}
{\'date\': \'202404\', \'share\': 11.0, \'commission\': 1.99, \'amount\': 985.9199847310999}
{\'date\': \'202405\', \'share\': 11.0, \'commission\': 1.99, \'amount\': 946.7726797738999}
{\'date\': \'202406\', \'share\': 11.0, \'commission\': 1.99, \'amount\': 982.4932209071001}
{\'date\': \'202407\', \'share\': 11.0, \'commission\': 1.99, \'amount\': 967.5191812375}
{\'date\': \'202408\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 935.5355548440001}
{\'date\': \'202409\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 962.4985954440001}
{\'date\': \'202410\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 972.8726287139999}
{\'date\': \'202411\', \'share\': 11.0, \'commission\': 1.99, \'amount\': 990.3758720714}
{\'date\': \'202412\', \'share\': 10.0, \'commission\': 1.99, \'amount\': 933.7083857319999}
{\'date\': \'202501\', \'share\': 11.0, \'commission\': 1.99, \'amount\': 961.8599307878999}
{\'date\': \'202502\', \'share\': 11.0, \'commission\': 1.99, \'amount\': 971.75}', 1740839161630, 1740839161633);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('e52ba914f02e421db8fabe1d7da9b8d7', 'a92f50fe93864c8eb27fb1a2de201b7e', 'QQQ', '2024-1-1', '2025-1-22', 'import numpy
import pandas
import os
import sys

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    print(df.head())
', -3, null, 1740244770481, 1740244770490);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('eb072b1e625a448798fd64a999c9123c', 'a92f50fe93864c8eb27fb1a2de201b7e', 'QQQ', '2024-1-1', '2025-1-22', 'import numpy
import pandas
import os
import sys

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    print(df.head())', 0, 'symbol                       date       close  ...       dea      macd         cci
0    QQQ  2024-01-02 00:00:00+00:00  400.217457  ...  7.453356 -0.618123  -59.764632
1    QQQ  2024-01-03 00:00:00+00:00  395.982562  ...  7.113944 -1.357648 -149.875580
2    QQQ  2024-01-04 00:00:00+00:00  393.944643  ...  6.627717 -1.944909 -164.024126
3    QQQ  2024-01-05 00:00:00+00:00  394.411873  ...  6.067306 -2.241644 -141.956099
4    QQQ  2024-01-08 00:00:00+00:00  402.563549  ...  5.606002 -1.845214  -46.085107

[5 rows x 26 columns]


Error:', 1740246063263, 1740246063269);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('ef1b5461cbb945938126bfeb117a1f95', 'a92f50fe93864c8eb27fb1a2de201b7e', 'QQQ', '2024-1-1', '2025-1-22', 'import numpy
import pandas
import os
import sys

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    print(df.head())', 5, 'judge() got an unexpected keyword argument \'testcase\'', 1740245155865, 1740245155949);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('f3010dea79b0439ea099f78cedf7010b', 'a92f50fe93864c8eb27fb1a2de201b7e', 'QQQ', '2015-1-1', '2025-3-1', 'import numpy
import pandas
import os
import sys

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    print(df.head())
    print(df.iloc[1])
    print(df.iloc[1][\'close\'])', 0, 'symbol                       date      close  ...       dea      macd         cci
0    QQQ  2015-01-02 00:00:00+00:00  95.111716  ...  0.430448 -0.105756  -14.444698
1    QQQ  2015-01-05 00:00:00+00:00  93.716548  ...  0.370245 -0.240814  -87.045713
2    QQQ  2015-01-06 00:00:00+00:00  92.459971  ...  0.271143 -0.396409 -135.035562
3    QQQ  2015-01-07 00:00:00+00:00  93.651871  ...  0.171253 -0.399560 -110.563182
4    QQQ  2015-01-08 00:00:00+00:00  95.444340  ...  0.104313 -0.267760  -30.106202

[5 rows x 26 columns]
symbol                               QQQ
date           2015-01-05 00:00:00+00:00
close                            93.7165
high                             94.8068
low                              93.4486
open                             94.6959
volume                          36521270
adjClose                         93.7165
adjHigh                          94.8068
adjLow                           93.4486
adjOpen                          94.6959
adjVolume                       36521270
divCash                                0
splitFactor                            1
delta                         -0.0146687
bbh                              98.2525
bbm                              95.5361
bbl                              92.8197
ma5                              95.5293
ma10                             96.0366
ma20                             95.5361
ma60                             93.4957
dif                             0.129431
dea                             0.370245
macd                           -0.240814
cci                             -87.0457
Name: 1, dtype: object
93.7165475086', 1740836908438, 1740836908443);
INSERT INTO dzm.quant_submission (id, user, symbol, start_day, end_day, code, result, output, created_time, modified_time) VALUES ('fa2ed83026c844df879135624b197ca5', 'a92f50fe93864c8eb27fb1a2de201b7e', 'SPY', '2015-1-1', '2025-3-1', 'import numpy
import pandas
import os
import sys


fixed_investment_amount = 1000

latest_price = 0.0

logs = []


def calculate_commission(share, price):     
    return min(
            share * price * 0.01,
            max(1.99, share * 0.011)
        )
    

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    
    
    for i in range(len(df)):
        date = df.iloc[i][\'date\']       # 2015-01-05 00:00:00+00:00
        close = df.iloc[i][\'close\']
        
        date = "".join(date.split("-")[:2])
        latest_price = close
        
        if not logs or logs[-1][\'date\'] != date:
            
            share = fixed_investment_amount // close
            commission = calculate_commission(share, close)
            amount = share * close + commission
            
            logs.append({
                \'date\': date,
                \'share\': share,
                \'commission\': commission,
                \'amount\': amount
            })
            
    total_commission = sum([log[\'commission\'] for log in logs])
    total_amount = sum([log[\'amount\'] for log in logs])
    total_share = sum([log[\'share\'] for log in logs])
    
    print("total_amount (include commission)", "->", round(total_amount, 2))
    print("total_commission", "->", round(total_commission, 2))
    print("total_share", "->", int(total_share))
    
    profit = total_share * latest_price - total_amount
    print("profit", "->", round(profit, 2))
    print("profit rate", "->", round(profit / total_amount * 100, 2), "%" )
    
    print("--------- logs ---------")
    for log in logs:
        print(log)', 0, 'total_amount (include commission) -> 101910.74
total_commission -> 242.78
total_share -> 379
profit -> 123283.48
profit rate -> 120.97 %
--------- logs ---------
{\'date\': \'201501\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 864.1864010315}
{\'date\': \'201502\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 849.4548167075}
{\'date\': \'201503\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 891.7189346959999}
{\'date\': \'201504\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 869.138790096}
{\'date\': \'201505\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 890.3010989254999}
{\'date\': \'201506\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 893.884358389}
{\'date\': \'201507\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 881.2975843295001}
{\'date\': \'201508\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 890.44777165}
{\'date\': \'201509\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 976.8407902696}
{\'date\': \'201510\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 983.8373473270001}
{\'date\': \'201511\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 897.958282778}
{\'date\': \'201512\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 899.1932787475}
{\'date\': \'201601\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 863.2404643365}
{\'date\': \'201602\', \'share\': 6.0, \'commission\': 1.99, \'amount\': 997.5992563876}
{\'date\': \'201603\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 850.7728422835}
{\'date\': \'201604\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 893.0712212955}
{\'date\': \'201605\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 897.592958994}
{\'date\': \'201606\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 907.497702383}
{\'date\': \'201607\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 910.711101319}
{\'date\': \'201608\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 941.0999438629999}
{\'date\': \'201609\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 943.0479324935}
{\'date\': \'201610\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 940.8154789485001}
{\'date\': \'201611\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 920.0619275969999}
{\'date\': \'201612\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 957.3052189255}
{\'date\': \'201701\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 987.7616135825001}
{\'date\': \'201702\', \'share\': 5.0, \'commission\': 1.99, \'amount\': 998.1777320805}
{\'date\': \'201703\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 841.5151687872}
{\'date\': \'201704\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 829.5259433432001}
{\'date\': \'201705\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 841.3061581003999}
{\'date\': \'201706\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 857.7633662856}
{\'date\': \'201707\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 857.8724385924}
{\'date\': \'201708\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 875.9293030639999}
{\'date\': \'201709\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 877.7667947252}
{\'date\': \'201710\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 898.0148259855999}
{\'date\': \'201711\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 916.374243988}
{\'date\': \'201712\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 941.1257224164}
{\'date\': \'201801\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 961.270628548}
{\'date\': \'201802\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 755.7410865793}
{\'date\': \'201803\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 957.4516373192}
{\'date\': \'201804\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 924.6149557276}
{\'date\': \'201805\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 951.526492674}
{\'date\': \'201806\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 982.415633616}
{\'date\': \'201807\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 980.5591075172}
{\'date\': \'201808\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 760.2136800301}
{\'date\': \'201809\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 784.3755469255}
{\'date\': \'201810\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 793.1262524245001}
{\'date\': \'201811\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 990.9577734008001}
{\'date\': \'201812\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 759.4176053275}
{\'date\': \'201901\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 911.9948686072}
{\'date\': \'201902\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 984.3063914624}
{\'date\': \'201903\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 766.9898958397}
{\'date\': \'201904\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 785.1666585424}
{\'date\': \'201905\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 801.5519099787999}
{\'date\': \'201906\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 754.3141616905}
{\'date\': \'201907\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 816.0456874009}
{\'date\': \'201908\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 813.7879397731001}
{\'date\': \'201909\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 802.4992016335}
{\'date\': \'201910\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 813.1277968398999}
{\'date\': \'201911\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 848.8107786268}
{\'date\': \'201912\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 864.0244530322002}
{\'date\': \'202001\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 905.0191250518001}
{\'date\': \'202002\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 902.9343777874001}
{\'date\': \'202003\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 861.1560426087999}
{\'date\': \'202004\', \'share\': 4.0, \'commission\': 1.99, \'amount\': 919.8797340188}
{\'date\': \'202005\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 792.8798168287001}
{\'date\': \'202006\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 856.5335960677}
{\'date\': \'202007\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 874.2776858308}
{\'date\': \'202008\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 925.6002931351}
{\'date\': \'202009\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 992.4854206617999}
{\'date\': \'202010\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 952.6102697017}
{\'date\': \'202011\', \'share\': 3.0, \'commission\': 1.99, \'amount\': 933.3180710167}
{\'date\': \'202012\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 690.2288462619999}
{\'date\': \'202101\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 698.4051487556}
{\'date\': \'202102\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 712.4546856375999}
{\'date\': \'202103\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 737.6645401236}
{\'date\': \'202104\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 760.9752575069999}
{\'date\': \'202105\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 794.3008127342}
{\'date\': \'202106\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 797.0858363944001}
{\'date\': \'202107\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 820.1755888022}
{\'date\': \'202108\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 833.7857201032001}
{\'date\': \'202109\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 860.7968885088001}
{\'date\': \'202110\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 830.0884620714}
{\'date\': \'202111\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 879.2892273658}
{\'date\': \'202112\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 861.0963862453999}
{\'date\': \'202201\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 916.221941485}
{\'date\': \'202202\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 868.836743622}
{\'date\': \'202203\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 824.877212325}
{\'date\': \'202204\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 871.4429719556}
{\'date\': \'202205\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 797.6511936239999}
{\'date\': \'202206\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 788.2640501266001}
{\'date\': \'202207\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 736.9959632092}
{\'date\': \'202208\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 793.9278856034}
{\'date\': \'202209\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 766.2620174572}
{\'date\': \'202210\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 711.7167556155999}
{\'date\': \'202211\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 746.3890400408001}
{\'date\': \'202212\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 790.6441166436}
{\'date\': \'202301\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 742.6527435378}
{\'date\': \'202302\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 800.9613120248}
{\'date\': \'202303\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 769.7259681322}
{\'date\': \'202304\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 804.3399315917999}
{\'date\': \'202305\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 813.2429993324}
{\'date\': \'202306\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 825.5628145614}
{\'date\': \'202307\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 871.6879486358}
{\'date\': \'202308\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 896.5566184306}
{\'date\': \'202309\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 886.1897734176}
{\'date\': \'202310\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 842.3821565966}
{\'date\': \'202311\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 833.2369844074001}
{\'date\': \'202312\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 904.9036671117999}
{\'date\': \'202401\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 935.3277008612}
{\'date\': \'202402\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 968.0088369010001}
{\'date\': \'202403\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 508.3501395183}
{\'date\': \'202404\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 519.1551646752}
{\'date\': \'202405\', \'share\': 2.0, \'commission\': 1.99, \'amount\': 993.1175859706}
{\'date\': \'202406\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 524.7412140255001}
{\'date\': \'202407\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 543.8582846465}
{\'date\': \'202408\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 541.5431177723001}
{\'date\': \'202409\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 550.5553768065}
{\'date\': \'202410\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 568.725628721}
{\'date\': \'202411\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 571.1376089917}
{\'date\': \'202412\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 603.6196077607}
{\'date\': \'202501\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 586.63}
{\'date\': \'202502\', \'share\': 1.0, \'commission\': 1.99, \'amount\': 599.76}', 1740838889441, 1740838889444);
