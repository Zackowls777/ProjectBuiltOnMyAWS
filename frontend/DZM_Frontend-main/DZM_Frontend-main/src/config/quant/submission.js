import React from 'react';

import { DoubleRightOutlined } from '@ant-design/icons';
import Input from "antd/lib/input";
import {Skeleton} from "antd";

const {TextArea} = Input;


export function getSubmissionResultContext(result) {
  if(result === -3) {
    return {'color': '#0a9fff', 'text': "Pending"};
  }
  if(result === -2) {
    return {'color': '#0a9fff', 'text': "Running"};
  }
  const judgeResult = [
    {'color': '#ff7900', 'text': "Wrong"},
    {'color': '#0a9fff', 'text': "Success"},
    {'color': '#ff7900', 'text': "Time Limit Exceeded"},
    {'color': '#ff7900', 'text': "Time Limit Exceeded"},
    {'color': '#ff7900', 'text': "Memory Limit Exceeded"},
    {'color': '#ff7900', 'text': "Runtime Error"},
    {'color': '#ff7900', 'text': "System Error"},
    {'color': '#ff7900', 'text': "Compile Error"},
    {'color': '#0a9fff', 'text': "No Compile Error"}
  ];
  result = result + 1;
  if(result < 0 || result >= judgeResult.length) return null;
  return judgeResult[result];
}

export function consoleShowResult(result, output) {
  const content = [];
  if (output !== undefined && output !== null) {
    output = output.replace(new RegExp("File \"/judger/run/.*/solution.py\",", "g"), "");
    output = output.replace(new RegExp("/judger/run/.*/", "g"), "");
  }
  let resultContext = getSubmissionResultContext(result);
  if(resultContext !== null) {
    content.push(
      <div style={{marginBottom: 13, height: 21}}>
        <div style={{width: '97%', float: 'left', fontWeight: 700, color: resultContext.color, fontSize: 16}}>
          {resultContext.text}
        </div>
      </div>
    );
  }

  if(result === -3 || result === -2) {
      content.push(<Skeleton active paragraph={{rows: 4}}/> )
  } else {
      content.push(<TextArea rows={6} style={{fontSize: 16, background:'black', color:"#eff3f9"}} disabled={false} value={output}/>)
  }
  return content;
}
