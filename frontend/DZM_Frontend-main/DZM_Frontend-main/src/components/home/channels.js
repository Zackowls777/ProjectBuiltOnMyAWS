import React from 'react';

import {Input, Button, message, Empty, Skeleton, Avatar, Row, Col, Pagination, Upload, Image, Select} from 'antd'
import fallbackImg from "../img/fallbackImg.png"
import placeholderImg from "../img/placeholderImg.png"
import {
    backendPath,
    frontendPath,
    getBackendUrl,
    getFrontendUrl,
    getQueryVariable,
    getQueryVariableOrDefault
} from "../../config/url";
import axios from "axios";
import {ReloadOutlined} from "@ant-design/icons";

const PageSize = 6, Cols = 3;

class HomeChannelsComponent extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
        pageInfoOfChannels: null
    }
    this.handleLoadChannels(1, PageSize)
  }

  handleLoadNextBatchChannels() {
      const pageInfoOfChannels = this.state.pageInfoOfChannels;
      if(pageInfoOfChannels === null) return ;
      this.setState({pageInfoOfChannels: null})
      let nextPageNum = pageInfoOfChannels.isLastPage ? 1: pageInfoOfChannels.pageNum + 1;
      this.handleLoadChannels(nextPageNum, pageInfoOfChannels.pageSize);
  }
  handleLoadChannels(pageNumber, pageSize) {
      const component = this;
      this.setState({pageInfoOfChannels: null})
      const search = getQueryVariableOrDefault("search", "");
      if(search === "") {
          axios.get(getBackendUrl(String.format(backendPath.channel.listChannelByRecommendation.path, pageNumber, pageSize)))
            .then(function (response) {
                if(response.data.status === 1) {
                    component.setState({pageInfoOfChannels: response.data.result});
                } else {
                    message.warn(response.data.message);
                }
            })
      } else {
          axios.get(getBackendUrl(String.format(backendPath.channel.listChannelBySearch.path, pageNumber, pageSize, search)))
            .then(function (response) {
                if(response.data.status === 1) {
                    component.setState({pageInfoOfChannels: response.data.result});
                } else {
                    message.warn(response.data.message);
                }
            })
      }

  }


  render() {
    const component = this;
    const pageInfoOfChannels = this.state.pageInfoOfChannels;
    const channels = pageInfoOfChannels === null ? null: pageInfoOfChannels.list;
    let channelsDisplay = null;
    if(channels === null) {
        channelsDisplay = <Skeleton active paragraph={{ rows: 5 }} />;
    } else if(channels.length === 0) {
        channelsDisplay = <Empty description={<span>No Channels</span>}></Empty>;
    } else {
        channelsDisplay = []
        const span = Math.ceil(24 / Cols);
        const rows = Math.ceil(PageSize / Cols);
        for(let r = 0; r < rows; r ++) {
            let lineDisplay = []
            for(let c = 0, i = r * Cols; c < Cols && i < channels.length; c ++, i ++) {
                const channel = channels[i];
                lineDisplay.push(<Col span={span}>
                    <div onClick={() => {window.open(getFrontendUrl(String.format(frontendPath.channel, channel.id)), "_self")}}
                        style={{padding: 10, width: '100%', cursor: 'pointer', textAlign: 'left', fontSize: 14}}>
                        <Image width={'100%'} height={600 / Cols} preview={false} src={channel.cover}
                               placeholder={<Image width={'100%'} src={placeholderImg} preview={false}/>}
                               fallback={fallbackImg}/><br/>
                        <Row>
                            <Col span={4} style={{textAlign:'center'}}>
                                <Avatar size={120 / Cols} style={{width: 120 / Cols, marginTop:6}}
                                        src={<Image preview={false} src={channel.creatorAvatar}/>}/>
                            </Col>
                            <Col span={20}>
                                <p style={{
                                    width: '100%',
                                    fontSize: 14,
                                    fontWeight: 600,
                                    wordWrap: "break-word",
                                    marginBottom: 2
                                }}>{channel.title}</p>
                                <p style={{fontSize: 12, marginBottom:0}}>{channel.creatorNickname}</p>
                            </Col>
                        </Row>

                    </div>
                </Col>)
            }
            while (lineDisplay.length < Cols) lineDisplay.push(<Col span={span}></Col>)
            channelsDisplay.push(<Row>{lineDisplay}</Row>)
        }
        if(this.props.pagination) {
            channelsDisplay.push(<Pagination size="small" total={pageInfoOfChannels.total} pageSize={pageInfoOfChannels.pageSize}
                                       current={pageInfoOfChannels.pageNum} hideOnSinglePage={true} defaultCurrent={1}
                                       onChange={(page, pageSize) => {
                                           this.handleLoadChannels(page, pageSize)}}
                                       style={{textAlign:'right'}}/>)
        }
        if(this.props.reload) {
            channelsDisplay.push(<Button onClick={() => {this.handleLoadNextBatchChannels()}}
                                         style={{position:'absolute', top: 5, right: -5}}
                                         shape="circle" type="link" icon={<ReloadOutlined />} size="large" />)
        }
    }
    return(
        <div style={{
            width: '100%', minHeight: 360, overflowY: 'scroll', overflowX:'hidden', borderRadius: 8, padding: "30px 26px 30px 26px", background: 'white',
            textAlign: 'left', margin: "0 auto", fontSize: 16, position: 'relative'
        }}>
            {channelsDisplay}
        </div>
    )
  }
}

export default HomeChannelsComponent;

