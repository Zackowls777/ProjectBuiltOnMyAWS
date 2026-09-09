import React from 'react';

import {Input, Button, message, Empty, Skeleton, Divider, Row, Col, InputNumber, Upload, Image} from 'antd'
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

const customRequest = async (options) => {
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

const initChannel = {id: "", title: "", description: "", cover: "", unSignedCoverKey: "", price: 0, inventory: 0, coverList: []}

class SelfChannelsComponent extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
        channels: null,
        channel: null,
        processing: false
    }
    const component = this;
    axios.get(
        getBackendUrl(backendPath.channel.listChannelForCreator.path)
      ).then(
        function (response) {
          if(response.data.status === 1) {
            const result = response.data.result;
            component.setState({
              channels: result
            });
          }
        }
      ).catch(
        (error) => console.log(error)
      );

  }

      handleRetrieveChannel(channelId) {
        const component = this;
        axios.get(
                getBackendUrl(String.format(backendPath.channel.retrieve.path, channelId))
              ).then(
                function (response) {
                  if(response.data.status === 1) {
                    let channel = response.data.result;
                    channel.coverList = [{
                          uid: '-1',
                          name: channel.unSignedCoverKey,
                          status: 'done',
                          url: channel.cover,
                        }]
                    component.setState({channel: channel});
                  }
                }
              ).catch(
                (error) => console.log(error)
              );
    }

    handleSubmit() {
        const channel = this.state.channel;
        const component = this;
        if(!channel.title) {message.warn("Please input the title");return ;}
        if(!channel.description) {message.warn("Please input the description");return ;}
        if(!channel.unSignedCoverKey) {message.warn("Please upload the cover");return ;}
        component.setState({processing: true})

        let url = getBackendUrl(backendPath.channel.create.path);
        let data = {
            title: channel.title,
            description: channel.description,
            cover: channel.unSignedCoverKey,
            price: channel.price,
            inventory: channel.inventory
        };

        if(channel.id) {
            url = getBackendUrl(backendPath.channel.update.path);
            data.id = channel.id;
        }

        axios.post(url, data).then(function (response) {
            if(response.data.status === 1) {
                message.success("successfully")
                window.setTimeout(function (){
                    window.location.reload();
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
    const channels = this.state.channels, channel = this.state.channel;
    let channelsDisplay = null;
    if(channels === null) {
        channelsDisplay = <Skeleton active paragraph={{ rows: 6 }} />
    }else if(channels.length === 0) {
        channelsDisplay = <Empty description={<span>No Channels</span>}></Empty>;
    } else {
        channelsDisplay = []
        const cols = 3, span = 8;

        const rows = Math.ceil(channels.length / cols);
        for(let r = 0; r < rows; r ++) {
            let lineDisplay = []
            for(let c = 0, i = r * cols; c < cols && i < channels.length; c ++, i ++) {
                const c = channels[i];
                lineDisplay.push(<Col span={span}>
                    <div onClick={() => {
                        component.setState({channel: null});
                        component.handleRetrieveChannel(c.id);
                    }}
                        style={{padding:10, width: '100%', height:250, cursor: 'pointer', textAlign:'left', fontSize:14}}>
                        <Image width={'100%'} preview={false} src={c.cover}
                               placeholder={<Image width={'100%'} src={placeholderImg} preview={false}/>}
                               fallback={fallbackImg}/><br/>
                        <p style={{width: '100%', fontSize:16, fontWeight:600, wordWrap:"break-word", marginBottom:3}}>{c.title}</p>
                        <span>{new Date(c.createdTime).toDateString()}</span>
                    </div>
                </Col>)
            }
            while(lineDisplay.length < cols) lineDisplay.push(<Col span={span}></Col>)
            channelsDisplay.push(<Row>{lineDisplay}</Row>)
        }
    }
    return(
        <div style={{
            width: '100%', overflowY: 'scroll', borderRadius: 8, padding: "60px 26px 0px 26px", background: 'white',
            textAlign: 'center', margin: "0 auto", fontSize: 16
        }}>
            {
                channel === null ? <Button type="primary"
                                           onClick={() => component.setState(
                                               {channel: JSON.parse(JSON.stringify(initChannel))})}>
                                            Create Your Channel
                                    </Button>:
                    <div style={{textAlign: 'left'}}>
                        <div style={{background:'#e6f7ff', textAlign: 'center', fontSize: 16, fontWeight:600, padding:10}}>
                            {channel.id ? "Update Channel": "Create Your Channel"}
                        </div><br/>
                        <Row>
                            <Col span={3}><p>title:</p></Col>
                            <Col span={21}><Input value={channel.title}
                                                  onChange={(e) => {
                                                      channel.title = e.target.value;
                                                      component.setState({channel: channel})
                                                  }}/>
                            </Col>
                        </Row><br/>
                        <Row>
                            <Col span={3}><p>description:</p></Col>
                            <Col span={21}><TextArea rows={4} value={channel.description}
                                                     onChange={(e) => {
                                                         channel.description = e.target.value;
                                                         component.setState({channel: channel})
                                                     }}/>
                            </Col>
                        </Row><br/>
                        <Row>
                            <Col span={3}><p>price:</p></Col>
                            <Col span={6}><InputNumber prefix="$" suffix="USD" min={0} value={channel.price / 100}
                                                       onChange={(value) => {
                                                           if (Number(value)) {
                                                               channel.price = Math.ceil(Number(value * 100));
                                                               component.setState({channel: channel})
                                                           }
                                                       }}/>
                            </Col><Col span={3}></Col>
                            <Col span={3}><p>inventory:</p></Col>
                            <Col span={6}><InputNumber min={0} value={channel.inventory}
                                                       onChange={(value) => {
                                                           if (Number(value)) {
                                                               channel.inventory = Math.ceil(Number(value));
                                                               component.setState({channel: channel})
                                                           }
                                                       }}/>
                            </Col><Col span={3}></Col>
                        </Row><br/>
                        <Row>
                            <Col span={3}><p>cover:</p></Col>
                            <Col span={15}>
                                <ImgCrop rotationSlider aspect={16 / 9}>
                                    <Upload
                                        listType="picture-card" accept={"image/*"}
                                        customRequest={customRequest}
                                        fileList={channel.coverList}
                                        onChange={({fileList: newFileList}) => {
                                            let fileList = [];
                                            if (newFileList.length > 0) {
                                                let file = newFileList[newFileList.length - 1];
                                                fileList.push(file);
                                                if (file.status === 'done') {
                                                    channel.unSignedCoverKey = coverKeyPrefix + file.name;
                                                }
                                                if(file.status === 'uploading') {
                                                    file.percent = file.originFileObj.percent;
                                                }
                                            }
                                            channel.coverList = fileList;
                                            component.setState({channel: channel})
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
                                        component.setState({channel: null})
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
            {channelsDisplay}
        </div>
    )
  }
}

export default SelfChannelsComponent;

