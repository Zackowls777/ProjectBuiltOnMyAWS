import React from 'react';

import {Input, Button, message, Empty, Skeleton, Avatar, Row, Col, Pagination, Upload, Image, Select} from 'antd'
import fallbackImg from "../img/fallbackImg.png"
import placeholderImg from "../img/placeholderImg.png"
import {frontendPath, getFrontendUrl} from "../../config/url";


class ChannelSectionsComponent extends React.Component {
  constructor(props) {
    super(props);
  }


  render() {
    const component = this, parent = this.props.parent;
    const pageSize = this.props.pageSize ? this.props.pageSize: 12, cols = this.props.cols ? this.props.cols: 4;
    const showCreator = this.props.showCreator ? this.props.showCreator : false;
    const pageInfoOfSections = this.props.pageInfoOfSections;
    let videos = pageInfoOfSections === null ? null: pageInfoOfSections.list;
    let videosDisplay = null;
    if(videos === null) {
        videosDisplay = <Skeleton active paragraph={{ rows: 6 }} />;
    } else if(videos.length === 0) {
        videosDisplay = <Empty description={<span>No Videos</span>}></Empty>;
    } else {
        videosDisplay = []
        const span = Math.ceil(24 / cols);
        const rows = Math.ceil(pageSize / cols);
        for(let r = 0; r < rows; r ++) {
            let lineDisplay = []
            for(let c = 0, i = r * cols; c < cols && i < videos.length; c ++, i ++) {
                const v = videos[i];
                lineDisplay.push(<Col span={span}>
                    <div onClick={() => {window.open(getFrontendUrl(String.format(frontendPath.section, v.id)), "_self")}}
                        style={{padding: 10, width: '100%', cursor: 'pointer', textAlign: 'left', fontSize: 14}}>
                        <Image width={'100%'} height={600 / cols} preview={false} src={v.cover}
                               placeholder={<Image width={'100%'} src={placeholderImg} preview={false}/>}
                               fallback={fallbackImg}/><br/>
                        <Row>
                            <Col span={showCreator ? 4 : 0} style={{textAlign:'center'}}>
                                <Avatar size={120 / cols} style={{width: 120 / cols, marginTop:6}}
                                        src={<Image preview={false} src={v.channelCreatorAvatar}/>}/>
                            </Col>
                            <Col span={showCreator ? 20 : 24}>
                                <p style={{
                                    width: '100%',
                                    fontSize: showCreator ? 14 : 16,
                                    fontWeight: 600,
                                    wordWrap: "break-word",
                                    marginBottom: 2
                                }}>{v.title}</p>
                                <p style={{fontSize: 12, marginBottom:0}}>{showCreator ? v.channelCreatorNickname : ""}</p>
                                <p style={{fontSize:12}}>{new Date(v.createdTime).toDateString()}</p>
                            </Col>
                        </Row>

                    </div>
                </Col>)
            }
            while (lineDisplay.length < cols) lineDisplay.push(<Col span={span}></Col>)
            videosDisplay.push(<Row>{lineDisplay}</Row>)
        }
        videosDisplay.push(<Pagination size="small" total={pageInfoOfSections.total} pageSize={pageInfoOfSections.pageSize}
                                       current={pageInfoOfSections.pageNum} hideOnSinglePage={true}
                                       onChange={(page, pageSize) => {
                                           parent.handlePaginationChange(page, pageSize)}}
                                       style={{textAlign:'right'}}/>)
    }
    return(
        <div style={{
            width: '100%', overflowY: 'scroll', borderRadius: 8, padding: "30px 26px 3px 26px", background: 'white',
            textAlign: 'left', margin: "0 auto", fontSize: 16
        }}>
            {videosDisplay}
        </div>
    )
  }
}

export default ChannelSectionsComponent;

