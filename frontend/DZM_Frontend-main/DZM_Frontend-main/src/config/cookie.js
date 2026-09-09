import {settings, env} from "../config";
import jwt_decode from "jwt-decode";

export const domain = settings[env].domain;

export function setCookie(name,value)
{
    const expire = 24 * 60 * 60 * 1000;
    let exp = new Date();
    exp.setTime(exp.getTime() + expire);
    document.cookie = name + "="+ escape (value) + ";domain=" + domain + ";path=/;expires=" + exp.toUTCString();
}

export function getCookie(name)
{
    let arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
    if(arr = document.cookie.match(reg)) {
        return (arr[2]).replace(/\"/g, "")
    }
    return null;
}

export function delCookie(name) {
    let exp = new Date();
    exp.setTime(exp.getTime() - 1);
    let cval=getCookie(name);
    if(cval!=null)
        document.cookie= name + "="+cval+";domain=" + domain + ";path=/;expires="+exp.toUTCString();
}


export function clearCookie () {
  let keys = document.cookie.match(/[^ =;]+(?==)/g);
  if (keys) {
    for (let i = keys.length; i--;) {
      document.cookie = keys[i] + '=0;domain=' + domain + ';path=/;expires=' + new Date(0).toUTCString();
      document.cookie = keys[i] + '=0;domain=' + domain + ';path=/;domain=' + document.domain + ';expires=' + new Date(0).toUTCString();
      document.cookie = keys[i] + '=0;domain=' + domain + ';path=/;domain=ratingdog.cn;expires=' + new Date(0).toUTCString(); // 清除一级域名下的或指定的，例如 .ratingdog.cn
    }
  }
}

export function isLoggedIn() {
  return getCookie("token") !== null;
}

export function getJwtPayload(key) {
  try {
    return jwt_decode(getCookie('token'))[key];
  } catch (e) {
    return null;
  }
}

export function getUserAttribute(name) {
  return getJwtPayload(name);
}
