import React from 'react';
import './HeaderSearch.css';

function HeaderSearch(props) {
    return (
        <div className='search-container'>
            <div className="layout">
                <div className="layout-text">
                    <h1 className="title">
                        Tra cứu lịch sử đăng kiểm
                    </h1>
                    <p className="subTitle">
                        Nhập các trường thông tin Căn Cước Công Dân đối với cá nhân hoặc mã số thuế đối với doanh nghiệp và biển số xe
                    </p>
                </div>
                <div className="card">
                    <div className="cccdDiv">
                        <label htmlFor="cccd">
                            Nhập Căn Cước Công Dân hoặc Mã số thuế
                        </label>
                        <input type="text" placeholder="Ví dụ: 012345678910"></input>
                    </div>

                    <div className="carNumberDiv">
                        <label htmlFor="carNumber">
                            Nhập biển số xe
                        </label>
                        <input type="text" placeholder="Ví dụ: 12A-34567"></input>
                    </div>
                    <button className='btn'>Tìm kiếm</button>
                </div>
            </div>
        </div>
    );
}

export default HeaderSearch;