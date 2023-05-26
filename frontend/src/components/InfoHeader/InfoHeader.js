import React from 'react';
import './InfoHeader.css';

function InfoHeader(props) {
    return (
        <div className='infor-container'>
            <div className='layout'>
                <div className='infor-header'>
                    <div className='textDiv'>
                        <h2 className='title'>Thông tin đăng kiểm</h2>
                        <hr />
                        <p>Nơi hiển thị thông tin lịch sử đăng kiểm sau khi xác nhận các thông tin trên</p>
                    </div>
                </div>
            </div>
        </div>
    );
}

export default InfoHeader;