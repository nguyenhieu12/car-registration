import React from 'react';
import './Navbar.css';
import logo from '../../assets/images/logo.png';

function Navbar() {
    return (
      <div className='navbar'>
        <img src={logo} alt="Logo" className='logo'/>
        <div className='nar-tag'>
          <h3 className='home-page bold-text'>Trang chủ</h3>
          <h3 className='developers'>Nhà phát triển</h3>
          <h3 className='services'>Dịch vụ</h3>
          <h3 class='news'>Tin tức</h3>
          <h3 className='search'>Tra cứu</h3>
        </div>
        <button className='login-btn'>Đăng nhập</button>
      </div>
    );
}

export default Navbar;
