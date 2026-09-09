import React from 'react';

import {Input, Button, message} from 'antd'
import { LoadingOutlined } from '@ant-design/icons';

class UpdateInfoComponent extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    const component = this.props.parent;
    return(
        <div style={{
            width: 500, height: 600, borderRadius: 8, padding: "60px 26px 0px 26px", background: 'white',
            textAlign: 'center', margin: "0 auto", fontSize: 16
        }}>
            <div style={{display: 'flex', width: '100%'}}>
                <p style={{
                    width: "30%",
                    color: '#282828',
                    fontWeight: 400,
                    fontFamily: 'PingFangSC-Regular',
                    paddingTop: 7
                }}>
                    nickname:
                </p>
                <Input placeholder="昵称" style={{marginBottom: 20, height: 40}}
                       value={component.state.nickname}
                       onChange={(e) => component.setState({nickname: e.target.value})}
                />
            </div>

            <Button type="primary"
                    style={{
                        width: "40%", background: '#007cff', borderColor: '#007cff', color: 'white',
                        borderRadius: 4, fontFamily: 'PingFangSC-Medium', fontSize: 16, height: 40, marginTop: 120
                    }}
                    onClick={() => component.handleUpdateUserInfo(component.state.nickname, component.state.unSignedAvatarKey)}
                    disabled={component.state.processing}>
                {!component.state.processing ? <span>Submit</span> : <LoadingOutlined/>}
            </Button>
        </div>
    )
  }
}

export default UpdateInfoComponent;

