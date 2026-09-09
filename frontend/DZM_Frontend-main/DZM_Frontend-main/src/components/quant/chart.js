import React from "react";
import {mockData} from "./data";
import {
    ColorConfig,
    SeriesTypeConfig
} from "../../config/quant/chart";
import {ColorType, createChart, CrosshairMode} from 'lightweight-charts';
import axios from "axios";
import {Collapse} from "antd";

function getIndexByTime(data, time) {
    let left = 0, right = data.length - 1;
    while(left + 1 < right) {
        let mid = Math.floor(left + (right - left) / 2);
        if(data[mid].time < time) {
            left = mid;
        } else {
            right = mid;
        }
    }
    if(data[left].time === time) return left;
    if(data[right].time === time) return right;
    return -1;
}

const chart1 = {
    chart: null,
    candlestickSeries: null,
    seriesCollections: []
}
const chart2 = {
    chart: null,
    seriesCollections: []
}

const chart2_ = {
    chart: null,
    seriesCollections: []
}

function getCrosshairDataPoint(series, param) {
    if (!param.time) {
        return null;
    }
    const dataPoint = param.seriesData.get(series);
    return dataPoint || null;
}

function syncCrosshair(chart, series, dataPoint) {
    if (dataPoint) {
        chart.setCrosshairPosition(dataPoint.value - 10000000000, dataPoint.time, series);
        return;
    }
    chart.clearCrosshairPosition();
}

function fixed(val) {
    try {
        return val.toFixed(2);
    } catch (e) {
        return val;
    }
}

function addSeriesToChart(seriesCollections, chart, visibleID) {
    for(let seriesCollection of seriesCollections) {
        const collection = [];
        for(let s of seriesCollection.series) {
            let ser = null;
            if(s.type === SeriesTypeConfig.line) {
                ser = chart.chart.addLineSeries({
                            color: s.color, lineWidth: 1.5 ,
                            crosshairMarkerVisible: false, lastValueVisible: false, priceLineVisible: false, visible: visibleID === seriesCollection.id
                        });
            } else if(s.type === SeriesTypeConfig.baseline) {
                ser = chart.chart.addBaselineSeries({
                            baseValue: { type: 'price', price: s.base },
                            lineWidth: 1.5,
                            crosshairMarkerVisible: false, lastValueVisible: false, priceLineVisible: false,
                            visible: visibleID === seriesCollection.id,
                            topLineColor: ColorConfig.up,
                            topFillColor1: ColorConfig.upAlpha85, topFillColor2: ColorConfig.upAlpha25,
                            bottomLineColor: ColorConfig.down,
                            bottomFillColor1: ColorConfig.downAlpha25, bottomFillColor2: ColorConfig.downAlpha85
                        });
            } else if(s.type === SeriesTypeConfig.candlestick) {
                 ser = chart.chart.addCandlestickSeries({
                    upColor: ColorConfig.up, downColor: ColorConfig.down,
                    borderUpColor: ColorConfig.up, borderDownColor: ColorConfig.down,
                    wickUpColor: ColorConfig.up, wickDownColor: ColorConfig.down,
                     visible: visibleID === seriesCollection.id,
                    borderVisible: true, crosshairMarkerVisible: false,
                    priceLineVisible: false, lastValueVisible: false, priceLineStyle: 1, priceLineColor: 'white'
                });
            }
            if(ser !== null) {
                if(s.hasOwnProperty("references")) {
                    for(let value of s.references) {
                        ser.createPriceLine({price: value, color: ColorConfig.text, lineWidth: 1, lineStyle: 2, axisLabelVisible: false})
                    }
                }
                console.log(s);
                ser.setData(s.data);
                collection.push({name: s.name, data: s.data, color: s.color, series: ser})
            }
        }
        chart.seriesCollections.push({
            id: seriesCollection.id,
            name: seriesCollection.name,
            collection: collection
        })
    }
}

function renderChart(data, VisibleConfig) {
    const chartOptions = {
        layout: { textColor: ColorConfig.text, background: { type: 'solid', color: ColorConfig.layout } } ,
        crosshair: {mode: CrosshairMode.Normal},
        grid: {
            vertLines: { color: "#444", visible: false},
            horzLines: { color: "#444", visible: false },
        }
    };
    let char1Options = JSON.parse(JSON.stringify(chartOptions));
    let char2Options = JSON.parse(JSON.stringify(chartOptions));
    let char2_Options = JSON.parse(JSON.stringify(chartOptions));
    char1Options.timeScale = {visible: false};
    char2_Options.timeScale = {visible: false};

    chart1.chart = createChart(document.getElementById('chart-1'), char1Options);
    chart2.chart = createChart(document.getElementById('chart-2'), char2Options);
    chart2_.chart = createChart(document.getElementById('chart-2_'), char2_Options);

    chart1.chart.priceScale("right").applyOptions({minimumWidth:100})
    chart2.chart.priceScale("right").applyOptions({minimumWidth:100})
    chart2_.chart.priceScale("right").applyOptions({minimumWidth:100})

    chart1.candlestickSeries = chart1.chart.addCandlestickSeries({
        upColor: ColorConfig.layout, downColor: ColorConfig.down,
        borderUpColor: ColorConfig.up, borderDownColor: ColorConfig.down,
        wickUpColor: ColorConfig.up, wickDownColor: ColorConfig.down,
        borderVisible: true, crosshairMarkerVisible: false,
        priceLineVisible: false, lastValueVisible: false, priceLineStyle: 1, priceLineColor: 'white'
    });

    chart1.candlestickSeries.setData(data.price);

    addSeriesToChart(data.charts1, chart1, VisibleConfig.chart1)
    addSeriesToChart(data.charts2, chart2, VisibleConfig.chart2)
    addSeriesToChart(data.charts2, chart2_, VisibleConfig.chart2_)
}

export class QuantChartComponent extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            data: null,
            VisibleConfig: {
                candlestick: true,
                chart1: "ma",
                chart2: "macd",
                chart2_: "cci"
            },
            chart2_Visible: true,
            cursorTime: null
        }

        const component = this;
        window.onresize = function () {
            component.setState({chart2_Visible: true})
        }

    }

    componentDidMount() {
        const component = this;
        const data = this.props.data;
            renderChart(data, component.state.VisibleConfig);

            chart1.chart.timeScale().subscribeVisibleLogicalRangeChange(timeRange => {
                chart2.chart.timeScale().setVisibleLogicalRange(timeRange);
                chart2_.chart.timeScale().setVisibleLogicalRange(timeRange);
            });

            chart2.chart.timeScale().subscribeVisibleLogicalRangeChange(timeRange => {
                chart1.chart.timeScale().setVisibleLogicalRange(timeRange);
                chart2_.chart.timeScale().setVisibleLogicalRange(timeRange);
            });

            chart2_.chart.timeScale().subscribeVisibleLogicalRangeChange(timeRange => {
                chart1.chart.timeScale().setVisibleLogicalRange(timeRange);
                chart2.chart.timeScale().setVisibleLogicalRange(timeRange);
            });

            chart1.chart.subscribeCrosshairMove(param => {
                const dataPoint = getCrosshairDataPoint(chart1.candlestickSeries, param)
                syncCrosshair(chart2.chart, chart2.seriesCollections[0].collection[0].series, dataPoint);
                syncCrosshair(chart2_.chart, chart2_.seriesCollections[0].collection[0].series, dataPoint);
                if(param.time !== undefined) {
                    component.setState({cursorTime: param.time})
                } else {
                    component.setState({cursorTime: null})
                }
            });
            chart2.chart.subscribeCrosshairMove(param => {
                const dataPoint = getCrosshairDataPoint(chart2.seriesCollections[0].collection[0].series, param);
                syncCrosshair(chart1.chart, chart1.candlestickSeries, dataPoint);
                syncCrosshair(chart2_.chart, chart2_.seriesCollections[0].collection[0].series, dataPoint);
                if(param.time !== undefined) {
                    component.setState({cursorTime: param.time})
                } else {
                    component.setState({cursorTime: null})
                }
            });
            chart2_.chart.subscribeCrosshairMove(param => {
                const dataPoint = getCrosshairDataPoint(chart2_.seriesCollections[0].collection[0].series, param);
                syncCrosshair(chart1.chart, chart1.candlestickSeries, dataPoint);
                syncCrosshair(chart2.chart, chart2.seriesCollections[0].collection[0].series, dataPoint);
                if(param.time !== undefined) {
                    component.setState({cursorTime: param.time})
                } else {
                    component.setState({cursorTime: null})
                }
            });
            component.setState({data: data})
        while(document.getElementById("tv-attr-logo") !== null) {
                document.getElementById("tv-attr-logo").remove();
        }
    }

    componentDidUpdate(prevProps, prevState, snapshot) {
        const VisibleConfig = this.state.VisibleConfig, preVisibleConfig = prevState.VisibleConfig;
        if(VisibleConfig.candlestick !== preVisibleConfig.candlestick) {
            chart1.candlestickSeries.applyOptions({visible: VisibleConfig.candlestick})
        }
        if(VisibleConfig.chart1 !== preVisibleConfig.chart1) {
            for(let seriesCollection of chart1.seriesCollections) {
                for(let s of seriesCollection.collection) {
                    s.series.applyOptions({visible: (seriesCollection.id === VisibleConfig.chart1)});
                }
            }
        }
        if(VisibleConfig.chart2 !== preVisibleConfig.chart2) {
            for(let seriesCollection of chart2.seriesCollections) {
                for(let s of seriesCollection.collection) {
                    s.series.applyOptions({visible: (seriesCollection.id === VisibleConfig.chart2)});
                }
            }
        }
        if(VisibleConfig.chart2_ !== preVisibleConfig.chart2_) {
            for(let seriesCollection of chart2_.seriesCollections) {
                for(let s of seriesCollection.collection) {
                    s.series.applyOptions({visible: (seriesCollection.id === VisibleConfig.chart2_)});
                }
            }
        }
    }

    render() {
        const component = this, VisibleConfig = JSON.parse(JSON.stringify(this.state.VisibleConfig));
        const cursorTime = this.state.cursorTime, data = this.state.data;

        const select1Options = [<option value={"null"}>NULL</option>], select2Options = [];
        for(let collection of chart1.seriesCollections) {
            select1Options.push(<option value={collection.id}>{collection.name}</option>)
        }
        for(let collection of chart2.seriesCollections) {
            select2Options.push(<option value={collection.id}>{collection.name}</option>)
        }

        const chart1Text = [], chart2Text = [], chart2_Text = [];
        const f = true;
        if(f && data !== null) {
            chart1Text.push(<span style={{fontWeight: 800}}>{data.symbol}</span>);
            if (cursorTime !== null) {
                let logical = getIndexByTime(data.price, cursorTime);
                if(logical >= 0) {
                    const time = data.price[logical].time, close = data.price[logical].close, delta = data.price[logical].delta;
                    const open = data.price[logical].open, high = data.price[logical].high, low = data.price[logical].low;

                    chart1Text.push(<span>&nbsp;&nbsp;{time}&nbsp;&nbsp;
                        <span style={{color: delta >= 0 ? ColorConfig.up: ColorConfig.down}}>
                            {fixed(close)}</span></span>)
                    chart1Text.push(<br/>);chart1Text.push(<br/>)
                    chart1Text.push(<span>open:<span style={{color: delta >= 0 ? ColorConfig.up: ColorConfig.down}}>{fixed(open)}</span></span>)
                    chart1Text.push(<span>&nbsp;&nbsp;high:<span style={{color: delta >= 0 ? ColorConfig.up: ColorConfig.down}}>{fixed(high)}</span></span>)
                    chart1Text.push(<span>&nbsp;&nbsp;low:<span style={{color: delta >= 0 ? ColorConfig.up: ColorConfig.down}}>{fixed(low)}</span></span>)
                    chart1Text.push(<span>&nbsp;&nbsp;delta:<span style={{color: delta > 0 ? ColorConfig.up: ColorConfig.down}}>
                            {fixed(delta * 100)}%</span></span>)
                    if(logical > 0) {
                        const lastClose = data.price[logical - 1].close;
                        chart1Text.push(<span>&nbsp;&nbsp;last close:{fixed(lastClose)}</span>)
                    }
                }
                chart1Text.push(<br/>);chart1Text.push(<br/>);


                for(let seriesCollection of chart1.seriesCollections) {
                    if(seriesCollection.id !== VisibleConfig.chart1) continue;
                    for(let s of seriesCollection.collection) {
                        const name = s.name, color = s.color, data = s.data;
                        logical = getIndexByTime(data, cursorTime);
                        if(logical < 0) continue;
                        chart1Text.push(<span><span style={{color: color}}>{name}:{fixed(data[logical].value)}&nbsp;&nbsp;</span></span>)
                    }
                }

                for(let seriesCollection of chart2.seriesCollections) {
                    if(seriesCollection.id !== VisibleConfig.chart2) continue;
                    for(let s of seriesCollection.collection) {
                        const name = s.name, color = s.color, data = s.data;
                        logical = getIndexByTime(data, cursorTime);
                        if(logical < 0) continue;
                        chart2Text.push(<span><span style={{color: color}}>{name}:{fixed(data[logical].value)}&nbsp;&nbsp;</span></span>)
                    }
                }

                for(let seriesCollection of chart2_.seriesCollections) {
                    if(seriesCollection.id !== VisibleConfig.chart2_) continue;
                    for(let s of seriesCollection.collection) {
                        const name = s.name, color = s.color, data = s.data;
                        logical = getIndexByTime(data, cursorTime);
                        if(logical < 0) continue;
                        chart2_Text.push(<span><span style={{color: color}}>{name}:{fixed(data[logical].value)}&nbsp;&nbsp;</span></span>)
                    }
                }

            }
        }

        let height1 = 0.75, height2 = 0.25, height2_ = 0.0;
        if(this.state.chart2_Visible) {
            height1 = 0.6; height2 = 0.2; height2_ = 0.2;
        }
        const height = this.props.height, width = this.props.width;
        height1 = height * height1; height2 = height * height2; height2_ = height * height2_;

        return (
            <div id="chart" style={{position: 'absolute', width: width, height: height}}>
                <div id="chart-1" style={{position: 'absolute', width: width, height: height1, top: 0}}>
                    <select value={VisibleConfig.chart1}
                            onChange={(e) => {
                                VisibleConfig.chart1 = e.target.value;
                                component.setState({VisibleConfig: VisibleConfig})
                            }} style={{position: "absolute", top: 10, left: 10, color: 'black', zIndex: 5}}>
                        {select1Options}
                    </select>
                    <div style={{position: "absolute", top: 10, left: 75, color: 'white', zIndex: 5}}>
                        {chart1Text}
                    </div>
                </div>
                <div id="chart-2_"
                     style={{position: 'absolute', width: width, height: height2_, top: height1}}>
                    <select value={VisibleConfig.chart2_}
                            onChange={(e) => {
                                VisibleConfig.chart2_ = e.target.value;
                                component.setState({VisibleConfig: VisibleConfig})
                            }} style={{position: "absolute", top: 10, left: 10, color: 'black', zIndex: 5}}>
                        {select2Options}
                    </select>
                    <div style={{position: "absolute", top: 10, left: 100, color: 'white', zIndex: 5}}>
                        {chart2_Text}
                    </div>
                </div>
                <div id="chart-2" style={{position: 'absolute', width: width, height: height2, top: height1 + height2_}}>
                    <select value={VisibleConfig.chart2}
                            onChange={(e) => {
                                VisibleConfig.chart2 = e.target.value;
                                component.setState({VisibleConfig: VisibleConfig})
                            }} style={{position: "absolute", top: 10, left: 10, color: 'black', zIndex: 5}}>
                        {select2Options}
                    </select>
                    <div style={{position: "absolute", top: 10, left: 100, color: 'white', zIndex: 5}}>
                        {chart2Text}
                    </div>
                </div>

            </div>
        );
    }
}


