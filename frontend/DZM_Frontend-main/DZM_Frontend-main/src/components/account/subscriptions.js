import React from 'react';

import {Input, Button, message, Skeleton, Empty, Table, Tag, Pagination, Spin} from 'antd'
import { LoadingOutlined } from '@ant-design/icons';
import axios from "axios";
import {backendPath, frontendPath, getBackendUrl, getFrontendUrl} from "../../config/url";

class SubscriptionsComponent extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
        orders: null, processing: null
    }
    const component = this;
    axios.get(getBackendUrl(backendPath.order.list.path))
        .then(function (response) {
            component.setState({orders: response.data.result})
        }).catch((e) => {console.log(e)})
  }

  handleCancel(orderId) {
      const component = this;
      if(component.state.processing !== null) {
          return ;
      }
      component.setState({processing: orderId})
      axios.post(getBackendUrl(backendPath.order.cancel.path),{
          order: orderId
      }).then(function (response) {
          if(response.data.status === 1) {
              message.success("Cancel successfully ...")
              window.setTimeout(function () {
                  window.location.reload();
              }, 1500)
          } else {
              message.warn(response.data.message);
          }
      }) .finally(() => {component.setState({processing: null})})
  }

  handlePay(order) {
      const orderId = order.orderId, description = order.channelTitle;
      const component = this;
      if(component.state.processing !== null) {
          return ;
      }
      component.setState({processing: orderId})
      axios.post(getBackendUrl(backendPath.payment.create.path),{
          order: orderId, paymentChannel: 1, description: description,
          cancelUrl: getFrontendUrl(frontendPath.payment.paypal.cancel),
          successUrl: getFrontendUrl(frontendPath.payment.paypal.success),
      }).then(function (response) {
          if(response.data.status === 1) {
              window.open(response.data.result.url, "_self");
          } else {
              message.warn(response.data.message);
          }
      }) .finally(() => {component.setState({processing: null})})
  }

  render() {
      const component = this;
    let subscriptionsDisplay = <Skeleton active paragraph={{rows: 6}}/>;
    const orders = this.state.orders;
      const statusTags = [<Tag color={'yellow'}>Unpaid</Tag>,
          <Tag color={'green'}>Paid</Tag>,
          <Tag color={'red'}>Canceled</Tag>,
          <Tag color={'red'}>Expired</Tag>]
    const ordersInfo = [], columns = [
        {title: "Id", key: "id", dataIndex: 'id'},
        {title: "Channel", key: "channel", dataIndex: 'channel'},
        {title: "Price", key: "price", dataIndex: 'price'},
        {title: "Status", key: "status", dataIndex: 'status'},
        {title: "Op", key: "op", dataIndex: 'op'},
    ];
    if(orders !== null) {
        if(orders.length === 0) {
            subscriptionsDisplay = <Empty description={<span>No Subscriptions</span>}></Empty>;
        } else {
            for(let order of orders) {
                ordersInfo.push({
                    id: order.orderId,
                    channel: <span onClick={() => {
                        window.open(getFrontendUrl(String.format(frontendPath.channel, order.channelId)), "_self")}}
                                   style={{cursor: 'pointer'}}>{order.channelTitle}</span>,
                    price: order.paymentPrice / 100,
                    status: statusTags[order.status],
                    op: order.status === 0 ?
                        (component.state.processing === order.orderId ? <Spin/>:
                        <>
                        <span onClick={() => {
                            this.handlePay(order)
                        }} style={{color: '#0080ff', cursor: 'pointer'}}>Pay</span>&nbsp;&nbsp;&nbsp;
                        <span onClick={() => {
                            this.handleCancel(order.orderId)
                        }} style={{color: '#0080ff', cursor: 'pointer'}}>Cancel</span>
                    </> ): <></>
                })
            }
        }
    }
      return (
          <div style={{
              borderRadius: 8, padding: "60px 26px 0px 26px", background: 'white',
            textAlign: 'center', fontSize: 16
        }}>
            <Table columns={columns} dataSource={ordersInfo} pagination={false}/>
        </div>
    )
  }
}

export default SubscriptionsComponent;

