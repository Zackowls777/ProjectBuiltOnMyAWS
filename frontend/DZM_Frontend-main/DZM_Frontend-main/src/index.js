import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import reportWebVitals from './reportWebVitals';
import Router from "./router";

String.format =  function (src) {
     if (arguments.length === 0)  return  null;
     let args = Array.prototype.slice.call(arguments, 1);
     return src.replace(/\{(\d+)\}/g,  function (m, i) {
         return args[i];
    });
};

ReactDOM.render(
  <Router/>,
  document.getElementById('root')
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
