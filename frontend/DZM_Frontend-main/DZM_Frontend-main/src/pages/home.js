import React from 'react';
import {headerHeight} from "../config";
import {Col, Row, Carousel, Image} from "antd";
import HeaderComponent from "../components/header/header";
import LoginComponent from "../components/header/login";
import HomeSectionsComponent from "../components/home/sections";
import HomeChannelsComponent from "../components/home/channels";
import FooterComponent from "../components/home/footer";
import banner1 from "../components/img/banner1.jpg"
import banner2 from "../components/img/banner2.jpg"
import {getQueryVariable, getQueryVariableOrDefault} from "../config/url";


class HomePage extends React.Component {
  constructor(props) {
    super(props);
    // clearCookie();
    this.state = {
      clientHeight: document.documentElement.clientHeight,
      clientWidth: document.documentElement.clientWidth,
    };
    const current = this;
    window.onresize = function () {
      current.setState({clientHeight: document.documentElement.clientHeight})
      current.setState({clientWidth: document.documentElement.clientWidth})
    }
  }
  render() {
    const clientWidth = Math.max(this.state.clientWidth, 1200), clientHeight = Math.max(this.state.clientHeight, 800);
    const bannerStyle = {
      margin: 0,
      width: clientWidth,
      height: clientWidth * 9 / 32,
      color: '#fff',
      lineHeight: '160px',
      textAlign: 'center',
      background: '#364d79',
    }
    const searchContent = getQueryVariableOrDefault("search", "");
    return (
        <div style={{width: clientWidth, minHeight: clientHeight, background: '#eff3f9'}}>
          <HeaderComponent anonymousAllowed={true}/>
            <Carousel autoplay={true} autoplaySpeed={4000} pauseOnFocus={true} pauseOnHover={true}>
                <div>
                    <Image preview={false} src={banner2} style={{width: "100%", height: '100%'}}/>
                </div>
                <div>
                    <Image preview={false} src={banner1} style={{width: "100%", height: '100%'}}/>
                </div>
            </Carousel>
            <div style={{
                margin: "50px auto",
                width: 1200
            }}>
                <p style={{fontSize: 22, fontWeight: 700}}>Hot Quant Channels {searchContent === "" ? "": "About [ " + searchContent +" ]"}</p>
                <p style={{fontSize: 18, fontWeight: 500, marginBottom: 5}}>Your Gateway to Quantitative Stock Trading
                    Excellence!</p>
                <p style={{fontSize: 16, fontWeight: 500, marginBottom: 20, color: '#858585'}}>
                    Dive into the world of data-driven investing with DZM Quant Platform, the premier video channel
                    dedicated to quantitative stock trading. Whether you're a seasoned trader or just starting your
                    journey, our channel offers valuable insights, tutorials, and strategies to help you master the art
                    of algorithmic trading.
                </p>
                <HomeChannelsComponent pagination={false} reload={true}/>
                <p style={{fontSize: 22, fontWeight: 700, marginTop: 80}}>Recent Quant Videos {searchContent === "" ? "": "About [ " + searchContent +" ]"}</p>
                <p style={{fontSize: 18, fontWeight: 500, marginBottom: 5}}>Unlocking the Power of Quantitative Stock Trading!</p>
                <p style={{fontSize: 16, fontWeight: 500, marginBottom: 20, color: '#858585'}}>
                    Are you ready to revolutionize your approach to the stock market? At DZM Quant Platform
                    we bring you a dedicated video channel focused on the world of quantitative trading.
                    From beginners to advanced traders, our content is designed to help you harness the power of data,
                    algorithms, and cutting-edge strategies to maximize your trading potential.
                </p>
                <HomeSectionsComponent pagination={false} reload={true}/>
            </div>
            <FooterComponent/>
        </div>
    )
  }
}

export default HomePage;
