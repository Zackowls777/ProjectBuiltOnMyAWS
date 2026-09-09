import React from 'react';

import {Input, Button, message} from 'antd'
import axios from "axios";
import { LoadingOutlined } from '@ant-design/icons';
import {backendPath, frontendPath, getBackendUrl, getFrontendUrl} from "../../config/url";
import {setCookie} from "../../config/cookie";
import {getQueryVariable} from "../../config/url";

class LoginComponent extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      logging: false,
      email: "",
      password: ""
    }
    const mess = getQueryVariable("message");
    if(mess !== null) {
      message.warning(mess);
    }
  }
  handleLogin() {
    if(this.state.logging) {
      return ;
    }
    this.setState({logging: true});
    const current = this;
    axios.post(
      getBackendUrl(backendPath.user.login.path),
      {
        'email': this.state.email,
        'password': this.state.password
      }
    ).then(function (response) {
      if(response.data.status === 1) {
        message.success("Login Successfully ...");
        setCookie("token", response.data.result.token);

        window.setTimeout(function () {
          window.open(getQueryVariable("next") || getFrontendUrl(frontendPath.home), "_self")
        }, 500);
      } else {
        message.warning(response.data.message);
      }
      current.setState({logging: false});
    }).catch(function (error) {
      console.log(error);
    }).finally(() => this.setState({logging: false}))
  }
  render() {
    const width = this.props.width, height = this.props.height;
    return(
      <div style={{
        width:width, height:height, borderRadius:8, padding:"60px 26px 0px 26px",
        border:'1px solid #eaeaea', boxShadow:'0 0 2px #cac6c6', background:'white',
        textAlign:'center'
      }}>
        <p style={{margin:"0px 0px 50px", color:'#0a9fff', fontSize:26, fontFamily:'ArialRoundedMTBold',
          fontWeight:600}}>DZM Quant</p>
        <Input placeholder="E-mail"  style={{marginBottom:30, height:40}}
               onChange={(e) => this.setState({email: e.target.value})}
               onPressEnter={() => this.handleLogin() }
        />
        <Input.Password placeholder="Password" style={{marginBottom:40, height:40}}
              iconRender={visible => (visible ? <span/> : <span/>)}
              onChange={(e) => this.setState({password: e.target.value})}
              onPressEnter={() => this.handleLogin() }
        />
        <Button type="primary"
                style={{width:"100%", background:'#0a9fff', borderColor:'#0a9fff', color:'white',
                  borderRadius:4, fontFamily:'PingFangSC-Medium', height: 40, fontSize:18}}
                onClick={() => this.handleLogin()} >
          {!this.state.logging ? <span>Log In</span> : <LoadingOutlined />}
        </Button>
        <div style={{fontWeight:500, fontFamily:'PingFangSC-Medium', marginTop:20}}>
          <a style={{float:'left', color:"#7A7A7A"}} href={getFrontendUrl(frontendPath.forgetPassword)} target={"_self"}>
            Forget Password ?
          </a>
          <a style={{float:'right', color:"#7A7A7A"}} href={getFrontendUrl(frontendPath.signup)} target={"_self"}>
            Sign Up
          </a>
        </div>
      </div>
    )
  }
}
export default LoginComponent;

