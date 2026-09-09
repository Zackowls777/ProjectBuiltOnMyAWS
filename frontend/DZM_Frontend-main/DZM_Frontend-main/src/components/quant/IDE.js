import React from 'react';

import {Select, Button, Tooltip, message, Modal, Skeleton} from 'antd';
import { RedoOutlined, SettingOutlined, DownOutlined, UpOutlined, ClockCircleOutlined, LoadingOutlined, VideoCameraOutlined, DoubleRightOutlined } from '@ant-design/icons';
import Input from "antd/lib/input";


import AceEditor from "react-ace";

import "ace-builds/src-noconflict/mode-java";
import "ace-builds/src-noconflict/mode-python";
import "ace-builds/src-noconflict/mode-c_cpp";
import "ace-builds/src-noconflict/mode-sql";
import "ace-builds/src-noconflict/mode-sqlserver";
import "ace-builds/src-noconflict/theme-textmate";
import "ace-builds/src-noconflict/theme-monokai";
import "ace-builds/src-noconflict/theme-solarized_light";
import "ace-builds/src-noconflict/theme-solarized_dark";

import {consoleShowResult} from "../../config/quant/submission";
import {backendPath, getBackendUrl, getQueryVariable} from "../../config/url";
import axios from "axios";
import {fetchCSV, parseCSVDataInChartFormat} from "../../config/quant/csv";


const localStoragekey = "dzm-quant-local-code";


class IDEComponent extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      submissionId: null,
      code: localStorage.getItem(localStoragekey) == null ? "": localStorage.getItem(localStoragekey),
      consoleVisible: false,
      result: -4,
      output: ""
    };
  }
  handleEditCode(code) {
    this.setState({code: code});
    localStorage.setItem(localStoragekey, code);
  }

  handleClickConsole() {
    const consoleVisible = this.state.consoleVisible;
    this.setState({consoleVisible: !consoleVisible});
  }

  handleSubmit() {
    const component = this;
    this.setState({consoleVisible: true, result: -3, output: "", submissionId: ""});
    const endDay = getQueryVariable('end_day');
    const startDay = getQueryVariable('start_day');
    const symbol = getQueryVariable('symbol');

    axios.post(getBackendUrl(backendPath.quant.submit.path), {
      symbol: symbol, startDay: startDay, endDay: endDay, code: component.state.code
    }).then(function (response) {
      if(response.data.status === 1) {
        const result = response.data.result;
        component.setState({submissionId: result.submissionId, result: result.result, output: result.output});
        const timer = window.setInterval(function () {
        axios.get(getBackendUrl(String.format(backendPath.quant.fetchSubmissionResult.path, result.submissionId)))
            .then(function (response) {
                if(response.data.status === 1) {
                    const result = response.data.result;
                    component.setState({submissionId: result.submissionId, result: result.result, output: result.output});
                    if(result.result > -2) {
                        clearInterval(timer);
                        component.setState({submissionId: null});
                    }
                } else {
                    message.warn(response.data.message)
                    clearInterval(timer);
                    component.setState({submissionId: null});
                }
            })
    }, 3000)
      } else {
        message.warn(response.data.message);
      }
    })

  }
  render() {
    const consoleVisible = this.state.consoleVisible;
    const height = this.props.height;
    const result = this.state.result, output = this.state.output;
    return(
        <div style={{height: height}}>
          <AceEditor
              mode={"python"}
              theme={"monokai"}
              width={this.props.width}
              height={consoleVisible ? height - 200 - 50 : height - 50}
              style={{marginTop: 0}}
              fontSize={15}
              showPrintMargin={false}
              enableBasicAutocompletion={true}
              value={this.state.code}
              onChange={(code) => this.handleEditCode(code)}
              name="dzm-quant-ide"
              editorProps={{$blockScrolling: true}}
          />
          {
            !consoleVisible ? <></>:
                <div style={{height: 200, padding:8}}>
                  {consoleShowResult(result, output)}
                </div>
          }
          <div style={{height: 50, marginTop: 0}}>
            <p style={{cursor: 'pointer', color:'gray', float:'left', fontSize:18, margin: "10px 0px 0px 10px"}} onClick={() => this.handleClickConsole()}>
              Console {consoleVisible ? <UpOutlined style={{fontSize: 10}}/> :
                <DownOutlined style={{fontSize: 10}}/>}
            </p>
            <Button type="primary" style={{float: 'right', marginRight: 30, marginTop:10, borderRadius: 5}}
                    disabled={this.state.submissionId !== null ? "disable" : null}
                    onClick={() => this.handleSubmit()}
            >
              Submit
            </Button>
          </div>
        </div>
    )
  }
}

export default IDEComponent;
