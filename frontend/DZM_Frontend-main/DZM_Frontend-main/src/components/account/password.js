import React from 'react';

import {Input, Button, message} from 'antd'
import { LoadingOutlined } from '@ant-design/icons';
import {getJwtPayload, setCookie} from "../../config/cookie";
import axios from "axios";
import {backendPath, frontendPath, getBackendUrl, getFrontendUrl, getQueryVariable} from "../../config/url";

class ResetPasswordComponent extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      processing: false,
      pwd: "",
      newPwd1: "",
      newPwd2: ""
    }
  }
  handleReset() {
    if(this.state.processing) {return ;}
    const old = this.state.pwd, new1 = this.state.newPwd1, new2 = this.state.newPwd2;
    if(new1 === old) {
      message.warning('current and previous password are the same');
      return ;
    }
    if(new1 !== new2) {
      message.warning('confirm password');
      return ;
    }
    this.setState({processing: true});
    const current = this;
    axios.post(
      getBackendUrl(backendPath.user.resetPassword.path),
      {
        'email': getJwtPayload('email'),
        'password': new1,
        "code": old
      }
    ).then(function (response) {
      if(response.data.status === 1) {
        message.success("Reset password successfully...");
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
  render() {
    const width = this.props.width, height = this.props.height;
    return(
      <div style={{
        width:width, height:height, borderRadius:8, padding:"60px 26px 0px 26px", background:'white',
        textAlign:'center', margin:"0 auto"
      }}>

        <Input.Password placeholder="Current Password" style={{marginBottom:20, height:40}}
              iconRender={visible => (visible ? <span/> : <span/>)}
              onChange={(e) => this.setState({pwd: e.target.value})}
        />
        <Input.Password placeholder="New Password" style={{marginBottom:20, height:40}}
              iconRender={visible => (visible ? <span/> : <span/>)}
              onChange={(e) => this.setState({newPwd1: e.target.value})}
        />
        <Input.Password placeholder="Confirm the new password" style={{marginBottom:40, height:40}}
              iconRender={visible => (visible ? <span/> : <span/>)}
              onChange={(e) => this.setState({newPwd2: e.target.value})}
        />
        <Button type="primary"
                style={{width:"40%", background:'#007cff', borderColor:'#007cff', color:'white',
                  borderRadius:4, fontFamily:'PingFangSC-Medium', height: 40, fontSize:18}}
                onClick={() => this.handleReset()} >
          {!this.state.processing ? <span>Submit</span> : <LoadingOutlined />}
        </Button>
      </div>
    )
  }
}
export default ResetPasswordComponent;

