import React from 'react';
import LoginComponent from "../components/header/login";
import {clearCookie} from "../config/cookie";
import HeaderComponent from "../components/header/header";


class LoginPage extends React.Component {
  constructor(props) {
    super(props);
    clearCookie();
  }
  render() {
    return(
      <div style={{width:'100%', height:'100%', background:'#eff3f9'}}>
        <HeaderComponent anonymousAllowed={true}/>
        <div style={{margin:"auto", paddingTop:30, width:350, height:420}}>
          <LoginComponent width={400} height={520}/>
        </div>
      </div>
    )
  }
}
export default LoginPage;
