import React from 'react';

import {Input, Button, message, Empty, Skeleton, Divider, Row, Col, Pagination, Upload, Image, Select} from 'antd'
import { LoadingOutlined } from '@ant-design/icons';
import ImgCrop from 'antd-img-crop';
import axios from "axios";
import {backendPath, getBackendUrl} from "../../config/url";
import {calculateFileBase64MD5} from "../../config/file";
import fallbackImg from "../img/fallbackImg.png"
import placeholderImg from "../img/placeholderImg.png"
import {getJwtPayload} from "../../config/cookie";

const { TextArea } = Input;

const onPreview = async (file) => {
    console.log(file)
    let src = file.url;
    if (!src) {
      src = await new Promise((resolve) => {
        const reader = new FileReader();
        reader.readAsDataURL(file.originFileObj);
        reader.onload = () => resolve(reader.result);
      });
    }
    const image = new Image();
    image.src = src;
    const imgWindow = window.open(src);
    imgWindow?.document.write(image.outerHTML);
};

const coverKeyPrefix = getJwtPayload("user_id") + "/cover/" + new Date().getTime().toString() + "-";
const videoKeyPrefix = getJwtPayload("user_id") + "/video/" + new Date().getTime().toString() + "-";

const customCoverRequest = async (options) => {
    const { onSuccess, onError, file, onProgress } = options;

    calculateFileBase64MD5(file).then((md5) => {
        const key = coverKeyPrefix + file.name;
        axios.post(getBackendUrl(backendPath.s3.preSignS3Key.path), {
          key: key, md5: md5
        }).then(function (response) {
            if(response.data.status === 1) {
              const s3Url = response.data.result.preSignedPutUrl;
              axios.put(s3Url, file, {
                    headers: {
                      'Content-MD5': md5
                    }, withCredentials: false,
                  onUploadProgress: (progressEvent) => {
                      const percentCompleted = Math.round((progressEvent.loaded * 100) / progressEvent.total);
                      file.percent = percentCompleted;
                      onProgress(percentCompleted);
                    },
              }).then(function (response) {
                  onSuccess(response.data)
              }).catch(function (e) {
                  onError(e)
              })
            } else {
              onError(response.data.message)
            }
          }).catch(function (e) {
            onError(e)
          });

    })
  };

const customVideoRequest = async (options) => {
    const { onSuccess, onError, file, onProgress } = options;

    calculateFileBase64MD5(file).then((md5) => {
        const key = videoKeyPrefix + file.name;
        axios.post(getBackendUrl(backendPath.s3.preSignS3Key.path), {
          key: key, md5: md5
        }).then(function (response) {
            if(response.data.status === 1) {
              const s3Url = response.data.result.preSignedPutUrl;
              file.url = response.data.result.preSignedGetUrl;
              axios.put(s3Url, file, {
                    headers: {
                      'Content-MD5': md5
                    }, withCredentials: false,
                  onUploadProgress: (progressEvent) => {
                      const percentCompleted = Math.round((progressEvent.loaded * 100) / progressEvent.total);
                      file.percent = percentCompleted;
                      onProgress(percentCompleted);
                    },
              }).then(function (response) {
                  onSuccess(response.data)
              }).catch(function (e) {
                  onError(e)
              })
            } else {
              onError(response.data.message)
            }
          }).catch(function (e) {
            onError(e)
          });

    })
  };
const PageSize = 6;

const initVideo = {id: "", title: "", description: "", cover: "", unSignedCoverKey: "", video: "", unSignedVideoKey: "", duration: 0, coverList: [], videoList: []}

class SelfChannelSectionsComponent extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
        channels: null,
        selectedChannelIndex: -1,
        pageInfoOfSection: null,
        video: null,
        processing: false
    }
    const component = this;
    axios.get(
        getBackendUrl(backendPath.channel.listChannelForCreator.path)
      ).then(
        function (response) {
          if(response.data.status === 1) {
            const result = response.data.result;
            component.setState({channels: result});
            if(result.length > 0) {
                component.handleChangeSelectedChannelIndex(0);
            }
          }
        }
      ).catch(
        (error) => console.log(error)
      );

  }

  handleChangeSelectedChannelIndex(channelIndex) {
      this.setState({selectedChannelIndex: channelIndex})
      const channel = this.state.channels[channelIndex];
      this.handleListVideoForChannel(channel.id, 1, PageSize)
  }

  handleListVideoForChannel(channelId, pageNum, pageSize) {
        const component = this;
        component.setState({pageInfoOfSection:null, video: null})
        axios.get(
                getBackendUrl(String.format(backendPath.channelSection.listSectionForChannel.path, channelId, pageNum, pageSize))
              ).then(
                function (response) {
                  if(response.data.status === 1) {
                    component.setState({pageInfoOfSection: response.data.result});
                  } else {
                      message.warning(response.data.message)
                  }
                }
              ).catch(
                (error) => console.log(error)
              );
  }

      handleRetrieveVideo(videoId) {
        const component = this;
        axios.get(
                getBackendUrl(String.format(backendPath.channelSection.retrieve.path, videoId))
              ).then(
                function (response) {
                  if(response.data.status === 1) {
                    let video = response.data.result;
                    video.coverList = [{
                          uid: '-1',
                          name: video.unSignedCoverKey,
                          status: 'done',
                          url: video.cover,
                        }]
                      video.videoList = [{
                          uid: '-1',
                          name: video.unSignedVideoKey,
                          status: 'done',
                          url: video.video,
                      }]
                    component.setState({video: video});
                  }
                }
              ).catch(
                (error) => console.log(error)
              );
    }

    handleSubmit() {
        const video = this.state.video;
        const component = this;
        if(!video.title) {message.warn("Please input the title");return ;}
        if(!video.description) {message.warn("Please input the description");return ;}
        if(!video.unSignedVideoKey) {message.warn("Please upload the video");return ;}
        if(!video.unSignedCoverKey) {message.warn("Please upload the cover");return ;}
        component.setState({processing: true})
        const channel = this.state.channels[this.state.selectedChannelIndex];
        let url = getBackendUrl(backendPath.channelSection.create.path);
        let data = {
            title: video.title,
            description: video.description,
            cover: video.unSignedCoverKey,
            video: video.unSignedVideoKey,
            duration: video.duration
        };
        if(video.id) {
            url = getBackendUrl(backendPath.channelSection.update.path);
            data.id = video.id;
        } else {
            data.channel = channel.id;
        }

        axios.post(url, data).then(function (response) {
            if(response.data.status === 1) {
                message.success("successfully")
                window.setTimeout(function (){
                    component.handleChangeSelectedChannelIndex(component.state.selectedChannelIndex)
                }, 2000)
            } else {
                message.warn(response.data.message)
            }
        }).catch(function (e) {
            console.log(e)
        }).finally(() => {
            component.setState({processing: false})
        })
    }

  render() {
    const component = this;
    const channels = this.state.channels, pageInfoOfSection = this.state.pageInfoOfSection, video = this.state.video;
    let videos = pageInfoOfSection === null ? null: pageInfoOfSection.list;
    let videosDisplay = null;
    let channel = null;
    if(this.state.selectedChannelIndex >= 0) {
        channel = channels[this.state.selectedChannelIndex];
    }
    if(channels === null) {
        return <Skeleton active paragraph={{ rows: 6 }} />
    }else if(channels.length === 0) {
        return <Empty description={<span>No Videos</span>}></Empty>;
    } else if(videos === null) {
        videosDisplay = <Skeleton active paragraph={{ rows: 6 }} />;
    } else if(videos.length === 0) {
        videosDisplay = <Empty description={<span>No Videos</span>}></Empty>;
    } else {
        videosDisplay = []
        const cols = 3, span = 8;
        const rows = Math.ceil(videos.length / cols);
        for(let r = 0; r < rows; r ++) {
            let lineDisplay = []
            for(let c = 0, i = r * cols; c < cols && i < videos.length; c ++, i ++) {
                const v = videos[i];
                lineDisplay.push(<Col span={span}>
                    <div onClick={() => {
                        component.setState({video: null});
                        component.handleRetrieveVideo(v.id);
                    }}
                        style={{padding:10, width: '100%', height:250, cursor: 'pointer', textAlign:'left', fontSize:14}}>
                        <Image width={'100%'} preview={false} src={v.cover}
                               placeholder={<Image width={'100%'} src={placeholderImg} preview={false}/>}
                               fallback={fallbackImg}/><br/>
                        <p style={{width: '100%', fontSize:16, fontWeight:600, wordWrap:"break-word", marginBottom:3}}>{v.title}</p>
                        <span>{new Date(v.createdTime).toDateString()}</span>
                    </div>
                </Col>)
            }
            while(lineDisplay.length < cols) lineDisplay.push(<Col span={span}></Col>)
            videosDisplay.push(<Row>{lineDisplay}</Row>)
        }
        videosDisplay.push(<Pagination size="small" total={pageInfoOfSection.total} pageSize={pageInfoOfSection.pageSize}
                                       current={pageInfoOfSection.pageNum} hideOnSinglePage={true}
                                       onChange={(page, pageSize) => {
                                           this.handleListVideoForChannel(channel.id, page, pageSize)}}
                                       style={{textAlign:'right'}}/>)
    }
    const channelOptions = [];
    for(let i = 0; i < channels.length; i ++) {
        channelOptions.push({value: i, label: channels[i].title})
    }
    console.log(this.state.video)
    return(
        <div style={{
            width: '100%', overflowY: 'scroll', borderRadius: 8, padding: "60px 26px 0px 26px", background: 'white',
            textAlign: 'center', margin: "0 auto", fontSize: 16
        }}>
            <div style={{textAlign: 'center'}}>
                <span><b>Select the channel:&nbsp;&nbsp;</b></span>
                <Select value={this.state.selectedChannelIndex} options={channelOptions}
                        onChange={(value) => component.handleChangeSelectedChannelIndex(value)}/><br/>
            </div><br/>
            {
                video === null ? <Button type="primary"
                                         onClick={() => component.setState(
                                             {video: JSON.parse(JSON.stringify(initVideo))})}>
                                            Upload Video
                                    </Button>:
                    <div style={{textAlign: 'left'}}>
                        <div style={{background:'#e6f7ff', textAlign: 'center', fontSize: 16, fontWeight:600, padding:10}}>
                            {video.id ? "Update Video": "Upload video to channel - " + channel.title}
                        </div><br/>
                        <Row>
                            <Col span={3}><p>title:</p></Col>
                            <Col span={21}><Input value={video.title} onProgess={(e) => {console.log(11111, e)}}
                                                  onChange={(e) => {
                                                      video.title = e.target.value;
                                                      component.setState({video: video})
                                                  }}/>
                            </Col>
                        </Row><br/>
                        <Row>
                            <Col span={3}><p>description:</p></Col>
                            <Col span={21}><TextArea rows={4} value={video.description}
                                                     onChange={(e) => {
                                                         video.description = e.target.value;
                                                         component.setState({video: video})
                                                     }}/>
                            </Col>
                        </Row><br/>
                        <Row>
                            <Col span={3}><p>video:</p></Col>
                            <Col span={9}>
                                <Upload fileList={video.videoList} customRequest={customVideoRequest} accept={"video/*"}
                                        progress={{strokeWidth: 3, showInfo: true}}
                                        onChange={({fileList: newFileList}) => {
                                            let fileList = [];
                                            if (newFileList.length > 0) {
                                                let file = newFileList[newFileList.length - 1];
                                                if(file.status === 'uploading') {
                                                    file.percent = file.originFileObj.percent;
                                                }
                                                if (file.status === 'done') {
                                                    video.unSignedVideoKey = videoKeyPrefix + file.name;
                                                    video.video = file.originFileObj.url;
                                                    const url = URL.createObjectURL(file.originFileObj);
                                                    const audioElement = new Audio(url);
                                                    audioElement.addEventListener('loadedmetadata', (_event) => {
                                                        video.duration = Math.floor(audioElement.duration);
                                                        component.setState({video: video})
                                                      });
                                                }
                                                fileList.push(file);
                                            }
                                            video.videoList = fileList;
                                            component.setState({video: video})
                                        }}
                                >
                                    <Button>Upload</Button>
                                </Upload>
                            </Col><Col span={3}/>
                            <Col span={9}>
                                {
                                    video.video ? <video width="240" height="135" controls autoPlay>
                                        <source src={video.video}/>
                                        Your browser does not support the video attribute.
                                    </video>:<></>
                                }
                            </Col>
                        </Row><br/>
                        <Row>
                            <Col span={3}><p>cover:</p></Col>
                            <Col span={15}>
                                <ImgCrop rotationSlider aspect={16 / 9}>
                                    <Upload
                                        listType="picture-card" accept={"image/*"}
                                        customRequest={customCoverRequest}
                                        fileList={video.coverList}
                                        onChange={({fileList: newFileList}) => {
                                            let fileList = [];
                                            if (newFileList.length > 0) {
                                                let file = newFileList[newFileList.length - 1];
                                                fileList.push(file);
                                                if(file.status === 'uploading') {
                                                    file.percent = file.originFileObj.percent;
                                                }
                                                if (file.status === 'done') {
                                                    video.unSignedCoverKey = coverKeyPrefix + file.name;
                                                }
                                            }
                                            video.coverList = fileList;
                                            component.setState({video: video})
                                        }}
                                        onPreview={onPreview}
                                    >
                                        + Upload
                                    </Upload>
                                </ImgCrop>
                            </Col>
                            <Col span={6}>
                                <div style={{marginTop:60}}>
                                    <Button disabled={this.state.processing} onClick={() => {
                                        component.setState({video: null})
                                    }}>
                                        Cancel
                                    </Button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <Button type="primary" loading={this.state.processing} onClick={() => this.handleSubmit()}>
                                        Submit
                                    </Button>
                                </div>
                            </Col>
                        </Row><br/>
                    </div>
            }
            <Divider />
            {videosDisplay}
        </div>
    )
  }
}

export default SelfChannelSectionsComponent;

