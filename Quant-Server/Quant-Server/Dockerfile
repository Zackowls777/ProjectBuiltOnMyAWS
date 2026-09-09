FROM ubuntu:18.04

ADD Judger /tmp/Judger

RUN buildDeps='software-properties-common libtool cmake python-dev python3-pip python-pip libseccomp-dev' && \
    apt-get update && apt-get install -y python python3 python-pkg-resources python3-pkg-resources gcc g++ $buildDeps && \
    pip3 install -I --no-cache-dir psutil gunicorn flask requests idna
RUN cd /tmp && cd Judger && \
    mkdir build && cd build && cmake .. && make && make install && cd ../bindings/Python && python3 setup.py install && \
    apt-get purge -y --auto-remove $buildDeps && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    mkdir -p /code && \
    useradd -u 12001 compiler && useradd -u 12002 code && useradd -u 12003 spj && usermod -a -G code spj
RUN apt-get install -y build-essential
RUN cd /tmp/Judger/ta-lib && chmod +x ./configure && ./configure --prefix=/usr && make && make install
RUN pip3 install numpy==1.19.0
RUN pip3 install TA-Lib==0.4.9
RUN pip3 install pandas-datareader
RUN pip3 install boto3==1.23.10
RUN pip3 install scikit-learn

