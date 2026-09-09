import React from 'react';
import { Menu, Input } from 'antd';
import { AppstoreOutlined, FileTextOutlined, TeamOutlined, DeploymentUnitOutlined, SnippetsOutlined } from '@ant-design/icons';
import './header.css';
import {backendPath, frontendPath, getBackendUrl, getFrontendUrl, getQueryVariable} from "../../config/url";
import {
  clearCookie,
  getJwtPayload,
  isLoggedIn,
  getUserAttribute,
} from "../../config/cookie";
import {checkRoles} from "../../config/roles";
import {Role} from "../../config/roles";
import axios from "axios";
import message from 'antd/lib/message'
import 'antd/lib/message/style'
import avatar from "../img/avatar.jpg"
import iconHome from "../img/icon/icon-home.png"
import iconQuant from "../img/icon/icon-quant.png"

const { SubMenu } = Menu;
const { Search } = Input;


class HeaderComponent extends React.Component {

  constructor(props){
    super(props);
    const initRole = getUserAttribute('role');
    this.state = {
      userInfo : {
        nickname: "",
        role: initRole ? Number(initRole) : Role.user, avatar: avatar
      }
    };
    const current = this;
    if(isLoggedIn()) {
      axios.get(
        getBackendUrl(backendPath.user.retrieveInfo.path)
      ).then(
        function (response) {
          if(response.data.status === 2) {
            if(getFrontendUrl(frontendPath.ban) !== window.location.href) {
              window.open(getFrontendUrl(frontendPath.ban), "_self");
            }
          } else if(response.data.status === 1) {
            current.setState({userInfo: response.data.result});
          }
        }
      ).catch(
        (error) => console.log(error)
      );
    } else {
      if(!this.props.anonymousAllowed) {
        message.warning("Please log in ...");
        window.open(getFrontendUrl(frontendPath.login) + "?next=" + window.location.href, "_self");
      }
    }
  }

  handleClick = e => {
    if(e.key === 'home') window.open(getFrontendUrl(frontendPath.home), "_self");
    if(e.key === 'quant') window.open(getFrontendUrl(frontendPath.quant), "_self");
    if(e.key === 'quant') window.open(getFrontendUrl(frontendPath.quant), "_self");
    if(e.key === 'account') window.open(getFrontendUrl(frontendPath.account), "_self");
    if(e.key === 'log-out') {
      clearCookie();
      window.open(getFrontendUrl(frontendPath.home), "_self");
    }
  };

  handleLog() {
    window.open(getFrontendUrl(frontendPath.login), "_self");
  }

  render() {
    const info = this.state.userInfo;
    return (
      <div id={"header-menu"}>
          <Menu onClick={this.handleClick} mode="horizontal" style={{minWidth:1200, padding:"0 120px"}}>
            <li onClick={() => window.open(getFrontendUrl(frontendPath.home), "_self")}
                style={{display: 'inline-block', marginRight:30, height:80, paddingTop:20, cursor:'pointer'}}
            >
              <p style={{paddingTop: 10, fontSize:26, lineHeight:'30px', fontFamily:'ArialRoundedMTBold', color:'#0080ff', fontWeight:800}}>
                DZM Quant
              </p>
            </li>
            <Menu.Item key="home" icon={<img src={iconHome}/>}>
              Home Page
            </Menu.Item>
            <Menu.Item key="quant" icon={<img src={iconQuant} />}>
              Quant Platform
            </Menu.Item>
            <Menu.Item key="search" disabled={true}>
              <Search placeholder={getQueryVariable("search")} size={"large"}
                      onSearch={(value) => {
                        window.open(getFrontendUrl(frontendPath.home + "?search=" + value), "_self")}}
                      style={{width: 300, marginTop:-8, border: 2}} enterButton/>
            </Menu.Item>
            {
              !isLoggedIn() ?
                <div style={{
                    position:'absolute', right:120, top:18, marginTop:0, fontSize:17, width:180, fontWeight:600,
                    padding: 0, borderRadius:25, textAlign:'center', zIndex:1, cursor: 'pointer'
                  }}
                  >
                    <span className={'home-user-button'}
                          onClick={() => window.open(getFrontendUrl(frontendPath.login), "_self")}>Log In</span>
                    &nbsp;&nbsp;|&nbsp;&nbsp;
                    <span className={'home-user-button'}
                          onClick={() => window.open(getFrontendUrl(frontendPath.signup), "_self")}>Sign Up</span>
                </div> :
                <SubMenu style={{position:'absolute', right:120}} title={
                  <div style={{height:40, background:'#e9f2ff', borderRadius:20, padding:"5px 30px 5px 5px",
                    display:'flex', textAlign:'center', marginTop:-10, minWidth: 150}}>
                    <img src={info.avatar ? info.avatar: avatar}
                         style={{width:30, height:30, borderRadius:30}} alt=""/>
                    &nbsp;&nbsp;
                    <p style={{color:'#282828', fontSize:13, fontWeight:400, margin:"6px 0", width:'100%', textAlign:'center'}}>{info.nickname}</p>
                  </div>
                }
                         className={"profile-sub-menu"}
                >
                  <Menu.Item key="account">Personal Center</Menu.Item>
                  <Menu.Item key="log-out">Log Out</Menu.Item>
                </SubMenu>
            }
          </Menu>
      </div>
    );
  }
}



export default HeaderComponent;
