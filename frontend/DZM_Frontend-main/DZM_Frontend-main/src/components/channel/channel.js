import React from 'react';

import {Input, Avatar, message, Empty, Skeleton, Divider, Row, Col, Pagination, Spin, Image, Select} from 'antd'
import { LoadingOutlined } from '@ant-design/icons';
import ImgCrop from 'antd-img-crop';
import axios from "axios";
import {backendPath, frontendPath, getBackendUrl, getFrontendUrl} from "../../config/url";
import {calculateFileBase64MD5} from "../../config/file";
import fallbackImg from "../img/fallbackImg.png"
import placeholderImg from "../img/placeholderImg.png"
import {getJwtPayload} from "../../config/cookie";
import ChannelSectionsComponent from "./sections";

const { TextArea } = Input;


const PageSize = 12;


class ChannelComponent extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
        channel: null,
        pageInfoOfSections: null,
        checkAccessByPaidOrder: true,
        processing: false
    }
    const component = this, channelId = this.props.channelId;
    component.handleListSections(1, PageSize);
    axios.get(
        getBackendUrl(String.format(backendPath.channel.retrieve.path, channelId))
      ).then(
        function (response) {
          if(response.data.status === 1) {
            const result = response.data.result;
            component.setState({channel: result});
          }
        }
      ).catch(
        (error) => console.log(error)
      );
    axios.get(
        getBackendUrl(String.format(backendPath.order.checkChannelAccessByPaidOrder.path, channelId))
      ).then(
        function (response) {
          if(response.data.status === 1) {
            const result = response.data.result;
            component.setState({checkAccessByPaidOrder: result});
          }
        }
      ).catch(
        (error) => console.log(error)
      );
  }

  handlePaginationChange(pageNum, pageSize) {
      this.handleListSections(pageNum, pageSize);
  }

  handleSubscribe() {
      const component = this;
      if(component.state.processing) {
          return ;
      }
      component.setState({processing: true})
      axios.post(getBackendUrl(backendPath.order.create.path), {
          channel: component.state.channel.id
      }).then(function (response) {
          if(response.data.status === 1) {
              message.success("go to pay the subscription ... ")
              window.setTimeout(function () {
                  window.open(getFrontendUrl(frontendPath.account) + "#subscriptions", "_self")
              }, 2000)
          } else {
              message.warn(response.data.message)
          }
      }).catch(
        (error) => console.log(error)
      ).finally(() => {component.setState({processing: false})});
  }

  handleListSections(pageNum, pageSize) {
    const component = this, channelId = this.props.channelId;
    axios.get(
        getBackendUrl(String.format(backendPath.channelSection.listSectionForChannel.path, channelId, pageNum, pageSize))
      ).then(
        function (response) {
          if(response.data.status === 1) {
            const result = response.data.result;
            component.setState({pageInfoOfSections: result});
          }
        }
      ).catch(
        (error) => console.log(error)
      );
  }

  render() {
    const component = this;
    const channel = this.state.channel, pageInfoOfSections = this.state.pageInfoOfSections;
    if(channel !== null) {
        document.title = channel.title + "DZM Quant"
    }
    let access = (channel !== null && getJwtPayload("user_id") === channel.creatorId) ||
                        this.state.checkAccessByPaidOrder;
    access = this.state.checkAccessByPaidOrder;

    return(
        <div style={{
            width: '100%', overflowY: 'scroll', borderRadius: 8, padding: "60px 26px 60px 26px", background: 'white',
            textAlign: 'center', margin: "0 auto", fontSize: 16
        }}>
            <div style={{textAlign: 'center'}}>
                {
                    channel === null ? <Skeleton active paragraph={{rows:5}}/>:
                        <div style={{fontSize: 16, fontWeight: 600}}>
                            <Avatar size={50}
                                    src={<Image preview={false} src={channel.creatorAvatar} style={{width: 50}}/>}/>
                            <p style={{marginTop: 10}}>{channel.creatorNickname}</p>
                            <div style={{background: '#e6f7ff', padding: 10}}>
                                {channel.title}
                                <p style={{marginTop:20, width: '100%', textAlign: 'left', fontSize: 14, fontWeight: 400, wordWrap:"break-word", whiteSpace: "pre-line"}}>
                                    {channel.description}
                                </p>
                            </div>
                            {
                                !access ? <p style={{marginTop: 20}}>
                                    Subscription Price：${channel.price / 100} &nbsp;&nbsp;&nbsp;
                                    <span onClick={() => {this.handleSubscribe()}}
                                        style={{color: "#0080ff", fontWeight: 600, cursor: 'pointer'}}>
                                        Subscribe &nbsp; {this.state.processing ? <Spin/>: <></>}
                                    </span>
                                </p>: <></>
                            }
                        </div>
                }
            </div>
            <ChannelSectionsComponent pageSize={PageSize} cols={3}
                                      showCreator={true} pageInfoOfSections={pageInfoOfSections} parent={component}/>
        </div>
    )
  }
}

export default ChannelComponent;

