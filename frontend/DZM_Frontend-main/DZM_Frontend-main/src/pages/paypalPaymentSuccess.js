import React from 'react';
import HeaderComponent from "../components/header/header";
import {headerHeight} from "../config";
import { LockOutlined } from '@ant-design/icons';
import {message, Row, Col, Menu, Skeleton, Input, Button, Select, Result} from "antd";
import {backendPath, frontendPath, getBackendUrl, getFrontendUrl, getQueryVariable} from "../config/url";
import axios from "axios";


class PaypalPaymentSuccessPage extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      clientHeight: Math.max(document.documentElement.clientHeight, 600),
        channelId: null, processing: true, message: ""
    };
    const component = this;
    window.onresize = function () {
      component.setState({clientHeight: Math.max(document.documentElement.clientHeight, 600)})
    }
    const paymentId = getQueryVariable("paymentId");
    const token = getQueryVariable("token");
    const PayerID = getQueryVariable("PayerID");
    axios.get(getBackendUrl(String.format(backendPath.payment.paypal.execute.path, paymentId, token, PayerID)))
        .then(function (response) {
          if(response.data.status === 1) {
              component.setState({channelId: response.data.result.channelId, message: "Pay successfully ..."})
          } else {
              component.setState({message: response.data.message})
          }
        }).finally(() => {component.setState({processing: false})})
  }
  render() {
    document.title = "Paypal Payment - DZM Quant";
    const height = this.state.clientHeight;
    const compoennt = this;
    const channelId = compoennt.state.channelId;
    return(
      <div style={{width:'100%'}}>
        <HeaderComponent/>
        <div style={{position: 'relative', width: 1130, background:'white', margin: '30px auto',
            padding:40, minHeight:height - headerHeight - 60}}>
            {
                compoennt.state.processing ? <Skeleton active paragraph={{rows: 6}}/>:
                    <Result
                        status={channelId === null ? "warning": "success"}
                        title={channelId === null ? "Payment failed ...": compoennt.state.message}
                        subTitle={channelId === null ? compoennt.state.message: ""}
                        extra={[
                          channelId === null ? <></>: <Button type="primary" key="console"
                                  onClick={() => {window.open(
                                      getFrontendUrl(String.format(frontendPath.channel, channelId)), "_self"
                                  )}}>
                            Go to the Channel
                          </Button>,
                          <Button key="buy" onClick={() => {window.open(getFrontendUrl(frontendPath.home), "_self")}}>Go Home Page</Button>,
                        ]}
                      />
            }
        </div>
      </div>
    )
  }
}
export default PaypalPaymentSuccessPage;
