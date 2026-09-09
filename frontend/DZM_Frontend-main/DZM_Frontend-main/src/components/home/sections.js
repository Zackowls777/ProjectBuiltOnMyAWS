import React from 'react';

import {Input, Button, message, Empty, Skeleton, Avatar, Row, Col, Pagination, Upload, Image, Select} from 'antd'
import fallbackImg from "../img/fallbackImg.png"
import { ReloadOutlined } from '@ant-design/icons';
import placeholderImg from "../img/placeholderImg.png"
import {backendPath, frontendPath, getBackendUrl, getFrontendUrl, getQueryVariableOrDefault} from "../../config/url";
import axios from "axios";

const PageSize = 6, Cols = 3;

class HomeSectionsComponent extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
        pageInfoOfSections: null
    }
    this.handleLoadSections(1, PageSize)
  }

  handleLoadNextBatchSections() {
      const pageInfoOfSections = this.state.pageInfoOfSections;
      if(pageInfoOfSections === null) return ;
      this.setState({pageInfoOfSections: null})
      let nextPageNum = pageInfoOfSections.isLastPage ? 1: pageInfoOfSections.pageNum + 1;
      this.handleLoadSections(nextPageNum, pageInfoOfSections.pageSize);
  }
  handleLoadSections(pageNumber, pageSize) {
      const component = this;
      this.setState({pageInfoOfSections: null})
      const search = getQueryVariableOrDefault("search", "");
      if(search === "") {
          axios.get(getBackendUrl(String.format(backendPath.channelSection.listSectionByRecommendation.path, pageNumber, pageSize)))
            .then(function (response) {
                if(response.data.status === 1) {
                    component.setState({pageInfoOfSections: response.data.result});
                } else {
                    message.warn(response.data.message);
                }
            })
      } else {
          axios.get(getBackendUrl(String.format(backendPath.channelSection.listSectionBySearch.path, pageNumber, pageSize, search)))
            .then(function (response) {
                if(response.data.status === 1) {
                    component.setState({pageInfoOfSections: response.data.result});
                } else {
                    message.warn(response.data.message);
                }
            })
      }

  }


  render() {
    const component = this;
    const pageInfoOfSections = this.state.pageInfoOfSections;
    let videos = pageInfoOfSections === null ? null: pageInfoOfSections.list;
    let videosDisplay = null;
    if(videos === null) {
        videosDisplay = <Skeleton active paragraph={{ rows: 5 }} />;
    } else if(videos.length === 0) {
        videosDisplay = <Empty description={<span>No Videos</span>}></Empty>;
    } else {
        videosDisplay = []
        const span = Math.ceil(24 / Cols);
        const rows = Math.ceil(PageSize / Cols);
        for(let r = 0; r < rows; r ++) {
            let lineDisplay = []
            for(let c = 0, i = r * Cols; c < Cols && i < videos.length; c ++, i ++) {
                const v = videos[i];
                lineDisplay.push(<Col span={span}>
                    <div onClick={() => {window.open(getFrontendUrl(String.format(frontendPath.section, v.id)), "_self")}}
                        style={{padding: 10, width: '100%', cursor: 'pointer', textAlign: 'left', fontSize: 14}}>
                        <Image width={'100%'} height={600 / Cols} preview={false} src={v.cover}
                               placeholder={<Image width={'100%'} src={placeholderImg} preview={false}/>}
                               fallback={fallbackImg}/><br/>
                        <Row>
                            <Col span={4} style={{textAlign:'center'}}>
                                <Avatar size={120 / Cols} style={{width: 120 / Cols, marginTop:6}}
                                        src={<Image preview={false} src={v.channelCreatorAvatar}/>}/>
                            </Col>
                            <Col span={20}>
                                <p style={{
                                    width: '100%',
                                    fontSize: 14,
                                    fontWeight: 600,
                                    wordWrap: "break-word",
                                    marginBottom: 2
                                }}>{v.title}</p>
                                <p style={{fontSize: 12, marginBottom:0}}>{v.channelCreatorNickname}</p>
                                <p style={{fontSize:12}}>{new Date(v.createdTime).toDateString()}</p>
                            </Col>
                        </Row>

                    </div>
                </Col>)
            }
            while (lineDisplay.length < Cols) lineDisplay.push(<Col span={span}></Col>)
            videosDisplay.push(<Row>{lineDisplay}</Row>)
        }
        if(this.props.pagination) {
            videosDisplay.push(<Pagination size="small" total={pageInfoOfSections.total} pageSize={pageInfoOfSections.pageSize}
                                       current={pageInfoOfSections.pageNum} hideOnSinglePage={true} defaultCurrent={1}
                                       onChange={(page, pageSize) => {
                                           this.handleLoadSections(page, pageSize)}}
                                       style={{textAlign:'right'}}/>)
        }
        if(this.props.reload) {
            videosDisplay.push(<Button onClick={() => {this.handleLoadNextBatchSections()}}
                style={{position:'absolute', top: 5, right: -5}}
                shape="circle" type="link" icon={<ReloadOutlined />} size="large" />)
        }
    }
    return(
        <div style={{
            width: '100%', minHeight: 380, overflowY: 'scroll', overflowX:'hidden', borderRadius: 8, padding: "30px 26px 30px 26px", background: 'white',
            textAlign: 'left', margin: "0 auto", fontSize: 16, position: 'relative'
        }}>
            {videosDisplay}
        </div>
    )
  }
}

export default HomeSectionsComponent;

