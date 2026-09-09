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
import {getJwtPayload} from "../config/cookie";
import Orders from "../components/account/subscriptions";
import OrdersComponent from "../components/account/subscriptions";
import SubscriptionsComponent from "../components/account/subscriptions";



class AccountPage extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      processing: false,
      selectedTab: window.location.hash,
      avatar: "",
      unSignedAvatarKey: "",
      nickname: "",
      avatarOpacity: 0,
      clientHeight: Math.max(document.documentElement.clientHeight, 600)
    };
    const component = this;
    axios.get(
        getBackendUrl(backendPath.user.retrieveInfo.path)
      ).then(
        function (response) {
          if(response.data.status === 1) {
            const result = response.data.result;
            component.setState({
              avatar: result.avatar, nickname: result.nickname, school: result.school, company: result.company
            });
          }
        }
      ).catch(
        (error) => console.log(error)
      );
    window.onresize = function () {
      component.setState({clientHeight: Math.max(document.documentElement.clientHeight, 600)})
    }
  }

  handleUpdateUserInfo(nickname, unSignedAvatarKey) {
    this.setState({processing: true})
    const component = this;
    axios.post(
      getBackendUrl(backendPath.user.updateInfo.path),{
        nickname: nickname,
        avatar: unSignedAvatarKey
      }
    ).then(
      function (response) {
          if(response.data.status === 1) {
            message.success("Update successfully.")
          } else {
            message.warning(response.data.message);
          }
          component.setState({processing: false});
        }
    ).catch(
      (error) => console.log(error)
    );
  }

  handleUploadAvatar(file, md5) {
    const component = this;
    const isPict = (file.type === 'image/jpeg' || file.type === 'image/png');
    if (!isPict) {
      message.warning('Please upload JPG/PNG avatar.');
      return ;
    }
    const reader = new FileReader();
    let s3PreSignedPutUrl = "";
    const newUnsignedAvatarKey = getJwtPayload("user_id") + "/avatar/" + new Date().getTime().toString() + "-" + file.name;

    reader.onload = function (e) {

      axios.put(s3PreSignedPutUrl, file, {
        headers: {
          'Content-MD5': md5
        },
          withCredentials: false
      }).then(response => {
          console.log(response)
        component.setState({avatar: e.target.result, unSignedAvatarKey: newUnsignedAvatarKey})
        component.handleUpdateUserInfo(component.state.nickname, newUnsignedAvatarKey);
      }).catch(e => {
          console.log(e)
      })

    };

    axios.post(getBackendUrl(backendPath.s3.preSignS3Key.path), {
      key: newUnsignedAvatarKey, md5: md5
    }).then(function (response) {
        if(response.data.status === 1) {
          s3PreSignedPutUrl = response.data.result.preSignedPutUrl;
          reader.readAsDataURL(file);
        } else {
          message.warning(response.data.message)
        }
      }).catch(function (error) {
        console.log(error);
      });

  }

  render() {
    document.title = "Personal Center - DZM Quant";
    let content = <Skeleton active paragraph={{ rows: 6 }} />;

    let avatar = this.state.avatar;

    if(!avatar) avatar = InitAvatar;

    const component = this;
    let selectedTab = this.state.selectedTab;
    if(selectedTab === '#reset-pwd') {
      content = <ResetPasswordComponent width={600} height={500}/>
    }else if(selectedTab === '#update-info') {
      content = <UpdateInfoComponent parent={this}/>
    }else if(selectedTab === '#videos') {
      content = <SelfChannelSectionsComponent parent={this}/>
    } else if(selectedTab === '#subscriptions') {
      content = <SubscriptionsComponent />
    } else {
      selectedTab = '#channels'
      content = <SelfChannelsComponent/>
    }
    window.location.hash = selectedTab;
    return (
        <div style={{width: '100%', background: '#eff3f9'}}>
          <HeaderComponent/>
          <div style={{height: this.state.clientHeight - headerHeight - 60, margin: "30px auto", width: 1200}}>
            <div style={{
              background: '#e7f2ff', borderRadius: 8,
              height: 120, margin: 0, width: '100%'
            }}>
              <Row>
                <Col span={3} style={{padding: 10}}>
                  <div style={{
                    width: 100, height: 100, borderRadius: 100, marginLeft: 40,
                    backgroundImage: `url(${avatar})`, backgroundSize: '100% 100%', cursor: 'pointer'
                  }}>
                    <div style={{
                      width: 100,
                      height: 100,
                      background: 'gray',
                      borderRadius: 100,
                      opacity: this.state.avatarOpacity,
                      cursor: 'pointer'
                    }}
                         onMouseEnter={() => this.setState({avatarOpacity: 0.8})}
                         onMouseLeave={() => this.setState({avatarOpacity: 0})}>
                      <input type={'file'} id={'avatar-upload'} hidden={true}
                             onChange={(event) => {
                             const file = event.target.files[0];
                             calculateFileBase64MD5(file).then((md5) => {
                                    component.handleUploadAvatar(file, md5)
                                });
                           }}/>
                    <CameraOutlined style={{fontSize:40, marginTop:30, marginLeft:30}}
                           onClick={() => {document.querySelector('#avatar-upload').click()}}/>
                  </div>
                </div>
              </Col>
                <Col span={11}></Col>
              <Col span={10}>
                <img src={backgroundImg} style={{width:'100%', height:120}}/>
              </Col>
            </Row>
          </div>
          <Row style={{height:this.state.clientHeight - headerHeight - 220,
            minHeight:550,
            background:'white', padding:"20px 0"}}>
            <Col span={4} style={{background:'white'}}>
              <Menu mode="vertical" selectedKeys={[selectedTab]}
                onClick={(e) => {this.setState({selectedTab: e.key})}}>
                <Menu.Item key="#channels">Channels</Menu.Item>
                <Menu.Item key="#videos">Videos</Menu.Item>
                <Menu.Item key="#subscriptions">Subscription Orders</Menu.Item>
                <Menu.Item key="#update-info">Account Info</Menu.Item>
                <Menu.Item key="#reset-pwd">Reset Password</Menu.Item>
              </Menu>
              <img src={userIcon} style={{position:'absolute', bottom:25, left:25}}/>
            </Col>
            <Col span={20} style={{background:'white'}}>
              {content}
            </Col>
          </Row>
        </div>

      </div>
    )
  }
}
export default AccountPage;
