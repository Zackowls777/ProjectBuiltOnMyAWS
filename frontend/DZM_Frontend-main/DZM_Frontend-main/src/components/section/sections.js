import React from 'react';

import {Divider, Avatar, Comment, Empty, Skeleton, Row, Col, Pagination, Upload, Image, Select} from 'antd'
import fallbackImg from "../img/fallbackImg.png"
import placeholderImg from "../img/placeholderImg.png"
import {backendPath, frontendPath, getBackendUrl, getFrontendUrl} from "../../config/url";
import axios from "axios";




class ChannelSectionsInSectionComponent extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
        section: null,
        channelSections: null
    }
    const component = this, sectionId = this.props.sectionId;
    axios.get(
        getBackendUrl(String.format(backendPath.channelSection.retrieve.path, sectionId))
      ).then(
        function (response) {
          if(response.data.status === 1) {
            const result = response.data.result;
            component.setState({section: result});
            axios.get(
                getBackendUrl(String.format(backendPath.channelSection.listSectionForChannel.path, result.channelId, 1, 8))
              ).then(
                function (res) {
                  if(res.data.status === 1) {
                    component.setState({channelSections: res.data.result.list});
                  }
                }
              ).catch(
                (error) => console.log(error)
              );
          }
        }
      ).catch(
        (error) => console.log(error)
      );
  }
  render() {

    const component = this;
    const section = this.state.section, channelSections = this.state.channelSections;
    const width = this.props.width, minHeight = this.props.minHeight;
    const videsDisplay = [];
    if(channelSections !== null) {
        for(let i = 0; i < channelSections.length; i ++) {
            const s = channelSections[i];
            videsDisplay.push(<Row style={{cursor:'pointer', marginBottom:5}} onClick={() => {
                window.open(getFrontendUrl(String.format(frontendPath.section, s.id)), "_self")
            }}>
                <Col span={10}>
                    <Image preview={false} src={s.cover} style={{width: '100%'}}
                               placeholder={<Image width={'100%'} src={placeholderImg} preview={false}/>}
                               fallback={fallbackImg}/>
                </Col>
                <Col span={14}>
                    <p style={{marginLeft:5, marginBottom:5, fontWeight:600, fontSize:15}}>{s.title}</p>
                    <p style={{marginLeft:5}}>{new Date(s.createdTime).toDateString()}</p>
                </Col>
            </Row>)
        }
    }
    return(
        <div style={{
            width: width - 10, minHeight:minHeight, marginLeft:10, paddingLeft:10, background:'white'
        }}>
            {
                section === null ? <Skeleton active paragraph={{rows:5}}/>:
                    <div style={{cursor: 'pointer'}}
                         onClick={() => {
                             window.open(getFrontendUrl(String.format(frontendPath.channel, section.channelId), "_self"))}}>
                        <h3>{section.channelTitle}</h3>
                        <Divider plain> ———— recent videos ———— </Divider>
                    </div>
            }
            {
                channelSections === null ? <Skeleton active paragraph={{rows:8}}/>:
                    <div>
                        {videsDisplay}
                    </div>
            }
        </div>
    )
  }
}

export default ChannelSectionsInSectionComponent;

