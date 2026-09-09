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
    Image,
    Select
} from 'antd'
import { LoadingOutlined } from '@ant-design/icons';
import ImgCrop from 'antd-img-crop';
import axios from "axios";
import {backendPath, frontendPath, getBackendUrl, getFrontendUrl} from "../../config/url";

import "video-react/dist/video-react.css"
import {Player, BigPlayButton, PlaybackRateMenuButton, ControlBar, VolumeMenuButton} from "video-react/lib"
import 'video.js/dist/video-js.css'

const ExampleComment = ({ children }) => (
  <Comment
    actions={[<span key="comment-nested-reply-to">Reply to</span>]}
    author={<a>Han Solo</a>}
    avatar={<Avatar src="https://joeschmoe.io/api/v1/random" alt="Han Solo" />}
    content={
      <p>
        We supply a series of design principles, practical patterns and high quality design
        resources (Sketch and Axure).
      </p>
    }
  >
    {children}
  </Comment>
);



class SectionComponent extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
        section: null
    }
    const component = this, sectionId = this.props.sectionId;
    axios.get(
        getBackendUrl(String.format(backendPath.channelSection.retrieve.path, sectionId))
      ).then(
        function (response) {
          if(response.data.status === 1) {
            const result = response.data.result;
            component.setState({section: result});
          }
        }
      ).catch(
        (error) => console.log(error)
      );
  }

  componentDidMount() {
    try {
      if(this.player !== null) this.player.subscribeToStateChange(this.handleStateChange.bind(this));
    } catch (e) {

    }
  }

  render() {
      const component = this;
      const section = this.state.section;
      if (section !== null) {
          document.title = section.title + "DZM Quant"
      }
      const width = this.props.width, minHeight = this.props.minHeight;
      return (
          <div style={{
              width: width, minHeight: minHeight
          }}>
              <div style={{width: width, minHeight: width * 9 / 16, position: 'relative'}}>
                  {
                      section === null ? <Skeleton active paragraph={{rows: 10}}/> :
                          <Player ref={player => {
                                  this.player = player;
                              }} playsInline src={section.video}
                                      poster={section.cover} controls={false} controlsList={'nodownload'}>
                                  <BigPlayButton position="center"/>
                                  <ControlBar>
                                      <PlaybackRateMenuButton rates={[1.0, 1.25, 1.5, 2.0]}/>
                                      <VolumeMenuButton vertical/>
                                  </ControlBar>
                              </Player>
                  }
                  {
                      (section === null || section.access) ? <></>:
                          <div style={{
                              position: 'absolute', zIndex: 2, top: 0, left: 0, width: width, height: minHeight,
                              padding: 50, background: 'black', opacity: 0.75
                          }}>
                              <div onClick={() => {
                                  window.open(getFrontendUrl(String.format(frontendPath.channel, section.channelId)), "_self")
                              }} style={{
                                  width: width - 100, color: 'white', opacity: 1, fontSize: 20, fontWeight: 500, textAlign: 'center',
                                  marginTop: minHeight * 0.1, cursor: "pointer"
                              }}>
                                  Go to Channel - {section.channelTitle}<br/><br/><a><b>Subscribe</b></a>
                              </div>
                          </div>
                  }
              </div>
              <div style={{width: width, padding: 10, borderRadius: 5, marginTop: 20, background: '#FFFFFF'}}>
                  {
                      section === null ? <Skeleton active paragraph={{rows: 3}}/> :
                          <>
                              <Row>
                                  <Col style={{width: 50}}>
                                      <Avatar size={40} style={{width: 40, marginTop: 5}}
                                              src={<Image preview={false} src={section.channelCreatorAvatar}/>}/>
                                  </Col>
                                  <Col>
                                      <h3 style={{marginBottom: 2}}>{section.title}</h3>
                                      <p>
                                          <span
                                              style={{fontWeight: 400}}>{section.channelCreatorNickname}</span>&nbsp;&nbsp;&nbsp;
                                          <span
                                              style={{color: '#858585'}}>{new Date(section.createdTime).toDateString()}</span>
                                      </p>
                                  </Col>
                              </Row>
                              <p style={{wordWrap: "break-word", whiteSpace: "pre-line"}}>{section.description}</p>
                          </>
                  }
              </div>
              <div style={{width: width, padding: 10, borderRadius: 5, marginTop: 20, background: '#FFFFFF'}}>
                  <h3>Comments [Beta]</h3>
                  <ExampleComment>
                    <ExampleComment>
                      <ExampleComment />
                      <ExampleComment />
                    </ExampleComment>
                  </ExampleComment>
              </div>
          </div>
      )
  }
}

export default SectionComponent;
