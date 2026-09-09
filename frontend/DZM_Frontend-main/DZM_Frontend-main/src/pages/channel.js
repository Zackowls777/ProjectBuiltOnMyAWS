import React from 'react';
import HeaderComponent from "../components/header/header";
import axios from "axios";
import {backendPath, getBackendUrl} from "../config/url";
import {message, Row, Col, Menu, Skeleton, Input, Button, Select} from "antd";
import {headerHeight} from "../config";
import {
  HistoryOutlined,
  CameraOutlined,
  SolutionOutlined,
  FileTextOutlined,
  UserOutlined,
  LoadingOutlined
} from '@ant-design/icons';
import InitAvatar from "../components/img/avatar.jpg"
import ResetPasswordComponent from "../components/account/password";
import ResetInfoComponent from "../components/account/info";
import backgroundImg from "../components/img/account-background.png"
import userIcon from "../components/img/account-user-icon.png"
import {calculateFileBase64MD5} from "../config/file";
import UpdateInfoComponent from "../components/account/info";
import SelfChannelsComponent from "../components/account/channels";
import SelfChannelSectionsComponent from "../components/account/channelSections";
import ChannelComponent from "../components/channel/channel";
import FooterComponent from "../components/home/footer";



class ChannelPage extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      clientHeight: Math.max(document.documentElement.clientHeight, 600)
    };
    const component = this;
    window.onresize = function () {
      component.setState({clientHeight: Math.max(document.documentElement.clientHeight, 600)})
    }
  }
  render() {
    document.title = "Channel - DZM Quant";
    const channelId = this.props.match.params.channel_id;
    return (
        <div style={{width: '100%', background: '#eff3f9'}}>
          <HeaderComponent/>
          <div style={{height: this.state.clientHeight - headerHeight - 60, margin: "30px auto", width: 1200}}>
            <ChannelComponent channelId={channelId}/>
          </div>
      </div>
    )
  }
}
export default ChannelPage;
