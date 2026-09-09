import React from 'react';

import {
    Comment,
    Avatar,
    message,
    Empty,
    Skeleton,
    Divider,
    Row,
    Col,
    Pagination,
    Spin,
    Input,
    Select, DatePicker, Button
} from 'antd'
import moment from 'moment';
import { LoadingOutlined } from '@ant-design/icons';
import ImgCrop from 'antd-img-crop';
import axios from "axios";
import {backendPath, frontendPath, getBackendUrl, getFrontendUrl, getQueryVariable} from "../../config/url";

import "video-react/dist/video-react.css"
import {Player, BigPlayButton, PlaybackRateMenuButton, ControlBar, VolumeMenuButton} from "video-react/lib"
import 'video.js/dist/video-js.css'
import {QuantChartComponent} from "./chart";
import {fetchCSV, parseCSVDataInChartFormat} from "../../config/quant/csv";
import IDEComponent from "./IDE";
const {RangePicker} = DatePicker;



class QuantComponent extends React.Component {
  constructor(props) {
    super(props);

    const endDay = getQueryVariable('end_day');
    const startDay = getQueryVariable('start_day');
    const symbol = getQueryVariable('symbol');

    if(symbol === null || startDay === null || endDay === null) {
        const today = new Date().getFullYear().toString() + "-" + (new Date().getMonth() + 1).toString() + "-" + new Date().getDate();
        window.open(getFrontendUrl(String.format(frontendPath.quantWithParam, "QQQ", "2024-1-1", today)), "_self")
    }

    this.state = {
        chartData: null,
        symbol: symbol,
        startDay: startDay,
        endDay: endDay,
    }

  }

  componentDidMount() {
    const component = this;
    const endDay = getQueryVariable('end_day');
    const startDay = getQueryVariable('start_day');
    const symbol = getQueryVariable('symbol');
    const timer = window.setInterval(function () {
        axios.get(getBackendUrl(String.format(backendPath.quant.fetchStockData.path, symbol, startDay, endDay)))
            .then(function (response) {
                if(response.data.status === 1) {
                    const result = response.data.result;
                    if(!result.loading) {
                        fetchCSV(result.dataCsv).then(data => {
                            const chartData = parseCSVDataInChartFormat(data);
                            console.log(chartData);
                            component.setState({chartData: chartData})

                        })
                        clearInterval(timer);
                    }
                } else {
                    message.warn(response.data.message)
                }
            })
    }, 3000)
  }


  render() {
      const width = this.props.width, height = this.props.height, chartData = this.state.chartData;
      const component = this;
      const dateFormat = "YYYY-MM-DD";
      const startDay = this.state.startDay, endDay = this.state.endDay, symbol = this.state.symbol;
      return (
          <div style={{width: width, height: height, background:'#222222', overflow:'hidden'}}>
            <Row>
                <Col span={12}>
                    {
                        chartData === null ? <div style={{margin:"40% 50%"}}><Spin size={"large"}/></div>:
                            <>
                                <div style={{width: '100%', height: 50, paddingTop:10}}>
                                    <p style={{
                                        fontSize: 30,
                                        lineHeight: '30px',
                                        fontFamily: 'ArialRoundedMTBold',
                                        color: '#0080ff',
                                        fontWeight: 800, cursor:'pointer', float:'left'
                                    }} onClick={() => window.open(getFrontendUrl(frontendPath.home), "_self")}>
                                        &nbsp;&nbsp;DZM Quant&nbsp;&nbsp;
                                    </p>
                                    <Input value={component.state.symbol} placeholder={'Symbol'}
                                           onChange={(e) => {component.setState({symbol: e.target.value})}}
                                           style={{float:'left', width: 80, marginRight: 20}}/>
                                    <RangePicker onChange={(e) => {
                                        component.setState({
                                            startDay: e[0].format(dateFormat),
                                            endDay: e[1].format(dateFormat)
                                        })
                                    }}
                                                 defaultValue={[moment(startDay, dateFormat), moment(endDay, dateFormat)]}
                                                 format={dateFormat}
                                    />
                                    <Button style={{marginLeft: 20}} type={'primary'} onClick={() => {
                                        window.open(getFrontendUrl(String.format(frontendPath.quantWithParam, symbol, startDay, endDay)), "_self")
                                    }}>GO</Button>
                                </div>
                                <QuantChartComponent data={chartData} width={width * 0.5} height={height - 50}/>
                            </>
                    }
                </Col>
                <Col span={12}>
                    <IDEComponent height={height} width={width * 0.5}/>
                </Col>
            </Row>
          </div>
      )
  }
}

export default QuantComponent;

