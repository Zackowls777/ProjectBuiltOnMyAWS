import React from 'react';
import HeaderComponent from "../components/header/header";
import {headerHeight} from "../config";
import { LockOutlined } from '@ant-design/icons';
import {message, Row, Col, Menu, Skeleton, Input, Button, Select, Result} from "antd";
import {backendPath, frontendPath, getBackendUrl, getFrontendUrl, getQueryVariable} from "../config/url";
import axios from "axios";


class PaypalPaymentCancelPage extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      clientHeight: Math.max(document.documentElement.clientHeight, 600),
        processing: true, message: "", canceled: false
    };
    const component = this;
    window.onresize = function () {
      component.setState({clientHeight: Math.max(document.documentElement.clientHeight, 600)})
    }
    const token = getQueryVariable("token");
    axios.get(getBackendUrl(String.format(backendPath.payment.paypal.cancel.path, token)))
        .then(function (response) {
          if(response.data.status === 1) {
              component.setState({canceled: true, message: "Payment canceled successfully ..."})
          } else {
              component.setState({message: response.data.message})
          }
        }).finally(() => {component.setState({processing: false})})
  }
  render() {
    document.title = "Paypal Payment Cancel - DZM Quant";
    const height = this.state.clientHeight;
    const compoennt = this;
    const canceled = compoennt.state.canceled;
    return(
      <div style={{width:'100%'}}>
        <HeaderComponent/>
        <div style={{position: 'relative', width: 1130, background:'white', margin: '30px auto',
            padding:40, minHeight:height - headerHeight - 60}}>
            {
                compoennt.state.processing ? <Skeleton active paragraph={{rows: 6}}/>:
                    <Result
                        status={!canceled ? "warning": "success"}
                        title={!canceled ? "Payment cancel failed ...": compoennt.state.message}
                        subTitle={!canceled ? compoennt.state.message: ""}
                        extra={[
                          <Button key="buy" onClick={() => {window.open(getFrontendUrl(frontendPath.home), "_self")}}>Go Home Page</Button>,
                        ]}
                      />
            }
        </div>
      </div>
    )
  }
}
export default PaypalPaymentCancelPage;
