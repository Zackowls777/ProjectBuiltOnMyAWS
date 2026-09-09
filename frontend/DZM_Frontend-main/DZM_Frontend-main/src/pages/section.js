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



class SectionPage extends React.Component {
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
    document.title = "Channel Section - DZM Quant";
    const clientWidth = Math.max(this.state.clientWidth, 1200), clientHeight = Math.max(this.state.clientHeight, 800);
    const sectionId = this.props.match.params.section_id;
    return (
        <div style={{width: clientWidth, minHeight:clientHeight, background: '#eff3f9'}}>
          <HeaderComponent/>
          <div style={{minHeight: clientHeight - headerHeight, width: '100%', padding: "30px 20px", background: '#eff3f9'}}>
            <div style={{width: '100%', height: '100%'}}>
              <Row>
                <Col span={18}>
                  <SectionComponent sectionId={sectionId} width={(clientWidth - 40) * 0.75} minHeight={clientHeight - headerHeight - 60}/>
                </Col>
                <Col span={6}>
                  <ChannelSectionsInSectionComponent sectionId={sectionId} width={(clientWidth - 40) * 0.25} minHeight={clientHeight - headerHeight - 60}/>
                </Col>
              </Row>
            </div>
          </div>

        </div>
    )
  }
}

export default SectionPage;
