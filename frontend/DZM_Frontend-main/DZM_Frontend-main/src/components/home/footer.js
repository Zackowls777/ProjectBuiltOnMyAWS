import React from 'react';
import {Input, Button, message, Empty, Skeleton, Avatar, Row, Col, Pagination, Upload, Image, Select} from 'antd'

import {MailOutlined, YoutubeOutlined, TwitterOutlined, SkypeOutlined, LinkedinOutlined, FacebookOutlined, WhatsAppOutlined } from "@ant-design/icons"

class FooterComponent extends React.Component {

  constructor(props){
    super(props);
  }

  render() {
    return (
      <div style={{width: '100%', minHeight: 200, background: 'black'}}>
          <div style={{width: 1000, margin: "10px auto", padding:"40px 0px", color:'white'}}>
              <Row>
                  <Col span={18}>
                      <p style={{fontWeight:700, fontSize:20, color: '#1890ff'}}>Our Contact</p>
                      <p style={{fontWeight:700, fontSize:20, color: '#858585'}}>DZM Quant Platform</p>
                      <p style={{fontSize:18, color: '#858585'}}><MailOutlined />&nbsp;&nbsp;codinggo3@gmail.com</p>
                      <p style={{fontSize:18, color:'#c5c5c5', marginTop:80}}>Copyright © Duan Zhengming All rights reserved.</p>
                  </Col>
                  <Col span={6}>
                      <p style={{marginTop:220, fontSize: 20}}>
                          <YoutubeOutlined />&nbsp;&nbsp;&nbsp;
                          <TwitterOutlined />&nbsp;&nbsp;&nbsp;
                          <SkypeOutlined />&nbsp;&nbsp;&nbsp;
                          <LinkedinOutlined />&nbsp;&nbsp;&nbsp;
                          <FacebookOutlined />&nbsp;&nbsp;&nbsp;
                          <WhatsAppOutlined />
                      </p>
                  </Col>
              </Row>
          </div>
      </div>
    )
  }
}



export default FooterComponent;