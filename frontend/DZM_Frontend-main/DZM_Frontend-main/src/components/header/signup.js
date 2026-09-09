import React from 'react';

import {Input, Button, message} from 'antd'
import axios from "axios";
import { LoadingOutlined } from '@ant-design/icons';
import {backendPath, frontendPath, getBackendUrl, getFrontendUrl} from "../../config/url";
import {clearCookie, setCookie} from "../../config/cookie";
import {getQueryVariable} from "../../config/url";


class SignupComponent extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      cooldown: 0,
      processing: false,
    };
    clearCookie();
  }
  handleSignUp(emailElementId, passwordElementId, verifycodeElementId) {
    if(this.state.processing) {
      message.warning("Pending ...");
      return ;
    }
    const email = document.getElementById(emailElementId).value;
    const password1 = document.getElementById(passwordElementId).value;
    const verifycode = document.getElementById(verifycodeElementId).value;
    this.setState({processing: true});
    const current = this;
    axios.post(
      getBackendUrl(backendPath.user.signup.path),
      {
        'email': email,
        'password': password1,
        "code": verifycode
      }
    ).then(function (response) {
      if(response.data.status === 1) {
        message.success("Sign up successfully");
        setCookie("token", response.data.result.token);

        window.setTimeout(function () {
          window.open(getQueryVariable("next") || getFrontendUrl(frontendPath.home), "_self")
        }, 500);
      } else {
        message.warning(response.data.message);
      }
      current.setState({processing: false});
    }).catch(function (error) {
      console.log(error);
    }).finally(
      () => this.setState({processing: false})
    )
  }
  handleVerifyCodeRequest(emailElementId) {
    if(this.state.cooldown > 0) {
      message.warning("Pending ...");
      return ;
    }
    const email = document.getElementById(emailElementId).value;
    let cur = this, timer = null;
    axios.post(
      getBackendUrl(backendPath.user.retrieveVerifyCode.path),
      {'email': email, 'type': 0}
    ).then(
        function (response) {
          if(response.data.status === 1) {
            message.success("VerifyCode has been sent to E-mail:" + email);
          } else {
            message.warning(response.data.message)
            cur.setState({cooldown: 0});
            window.clearInterval(timer);
          }
        }
      ).catch(
        (error) => console.log(error)
      );
    this.setState({cooldown: 60});
    timer = window.setInterval(function () {
      if(cur.state.cooldown === 0) {
        window.clearInterval(timer);
      } else if(cur.state.cooldown > 0) {
        cur.setState({cooldown: cur.state.cooldown - 1});
      }
    }, 1000);
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
        <Input placeholder="E-mail" id={"sign-up-email"}  style={{marginBottom:30, height:40}}/>
        <Input.Password placeholder="Password" style={{marginBottom:30, height:40}}
              iconRender={visible => (visible ? <span/> : <span/>)} id={"sign-up-password"}
        />
        <Input placeholder="Verification Code" id={"sign-up-verify-code"}
               style={{marginBottom:40, height:40, width: 210, marginRight:6}}/>
        <Button type="primary" style={{width:130, background:'#0a9fff', borderColor:'#0a9fff', color:'white',
                  borderRadius:4, fontFamily:'PingFangSC-Medium', height: 40, fontSize:18}}
                onClick={() => this.handleVerifyCodeRequest('sign-up-email')}
        >
          {this.state.cooldown > 0 ? <span>{this.state.cooldown}&nbsp;Seconds</span> : <span>Fetch Code</span>}
        </Button>
        <Button type="primary"
                style={{width:"100%", background:'#0a9fff', borderColor:'#0a9fff', color:'white',
                  borderRadius:4, fontFamily:'PingFangSC-Medium', height: 40, fontSize:18}}
                onClick={() => this.handleSignUp(
                 "sign-up-email",
                  "sign-up-password",
                  "sign-up-verify-code") }>
          {!this.state.processing ? <span>Sign Up</span> : <LoadingOutlined />}
        </Button>
        <div style={{fontWeight:500, fontFamily:'PingFangSC-Medium', marginTop:20}}>
          <a style={{color:"#7A7A7A", float:'right'}} href={getFrontendUrl(frontendPath.login)} target={"_self"}>
            Log In
          </a>
        </div>
      </div>
    )
  }
}
export default SignupComponent;

