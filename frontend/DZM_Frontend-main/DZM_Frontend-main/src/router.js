import React from 'react';
import './index.css';
import {BrowserRouter, Switch, Redirect, Route} from "react-router-dom";
import LoginPage from "./pages/login";
import BanPage from "./pages/ban";
import AccountPage from "./pages/account";
import ForgetPasswordPage from "./pages/forgetPassword";
import {frontendPath, frontendUrlBase} from "./config/url";
import SignUpPage from "./pages/signup";
import ChannelPage from "./pages/channel";
import PaypalPaymentCancelPage from "./pages/paypalPaymentCancel";
import PaypalPaymentSuccessPage from "./pages/paypalPaymentSuccess";
import SectionPage from "./pages/section";
import HomePage from "./pages/home";
import QuantPage from "./pages/quant";

class Router extends React.Component {
  constructor(props) {
    super(props);
    const href = window.location.href;
    if(!href.startsWith(frontendUrlBase)) {
      window.open(frontendUrlBase, "_self")
    }
  }
  render() {
    return(
      <BrowserRouter>
        <Switch>
          <Route
            path={"/"}
            render={() => (
              <Switch>
                  <Route path={frontendPath.home} component={HomePage}/>
                  <Route path={frontendPath.login} component={LoginPage}/>
                  <Route path={frontendPath.signup} component={SignUpPage}/>
                  <Route path={frontendPath.forgetPassword} component={ForgetPasswordPage}/>
                  <Route path={frontendPath.ban} component={BanPage}/>
                  <Route path={frontendPath.account} component={AccountPage}/>
                  <Route path={frontendPath.quant} component={QuantPage}/>
                  <Route path={frontendPath.payment.paypal.cancel} component={PaypalPaymentCancelPage}/>
                  <Route path={frontendPath.payment.paypal.success} component={PaypalPaymentSuccessPage}/>
                  <Route path={String.format(frontendPath.channel, ":channel_id")} component={ChannelPage}/>
                  <Route path={String.format(frontendPath.section, ":section_id")} component={SectionPage}/>
                  <Route render={() => <Redirect to={frontendPath.home}/>}/>
              </Switch>
            )}
          />
        </Switch>
      </BrowserRouter>
    )
  }
}

export default Router;

