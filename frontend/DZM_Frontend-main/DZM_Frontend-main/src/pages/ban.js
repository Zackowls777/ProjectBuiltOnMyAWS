import React from 'react';
import HeaderComponent from "../components/header/header";
import {headerHeight} from "../config";
import { LockOutlined } from '@ant-design/icons';


class BanPage extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      clientHeight: Math.max(document.documentElement.clientHeight, 600)
    };
    const current = this;
    window.onresize = function () {
      current.setState({clientHeight: Math.max(document.documentElement.clientHeight, 600)})
    }
  }
  render() {
    document.title = "竟乘Offer - Permission Denied";
    const height = this.state.clientHeight;
    return(
      <div style={{width:'100%'}}>
        <HeaderComponent/>
        <div style={{position: 'relative', width: 1130, background:'white', margin: '30px auto',
            padding:40, minHeight:height - headerHeight - 60}}>
          <div style={{margin:"0 auto", marginTop:"10%", fontSize:100, textAlign:'center', fontWeight:600, opacity:0.6}}>
            <LockOutlined/>
          </div>
          <div style={{textAlign:'center', fontSize: 20, fontWeight:500}}>
            Contact administrator to acquire permissions.
          </div>
        </div>
      </div>
    )
  }
}
export default BanPage;
