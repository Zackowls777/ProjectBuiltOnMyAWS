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
import SectionComponent from "../components/section/section";
import ChannelSectionsInSectionComponent from "../components/section/sections";
import QuantComponent from "../components/quant/quant";



class QuantPage extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      clientHeight: document.documentElement.clientHeight,
      clientWidth: document.documentElement.clientWidth
    };
    const component = this;
    window.onresize = function () {
      component.setState({
        clientHeight: document.documentElement.clientHeight,
        clientWidth: document.documentElement.clientWidth
      })
    }
  }
  render() {
    document.title = "Quant - DZM Quant";
    const clientWidth = Math.max(this.state.clientWidth, 100), clientHeight = Math.max(this.state.clientHeight, 600);
    return (
        <div style={{width: clientWidth, height:clientHeight, background: '#eff3f9', overflow:'hidden'}}>
          <div style={{height: clientHeight, width: '100%', overflow:'hidden'}}>
            <QuantComponent width={clientWidth} height={clientHeight}/>
          </div>

        </div>
    )
  }
}

export default QuantPage;
