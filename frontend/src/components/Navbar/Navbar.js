import React from 'react';
import './Navbar.css';
import logo from '../../assets/images/logo.png';
import { Link } from 'react-router-dom';

function Navbar() {
    return (
      <div className='navbar'>
        <img src={logo} alt="Logo" className='logo'/>
        <div className='nar-tag'>
          <Link to='/' className='link home bold-text'>Trang chủ</Link>
          <Link to='/developers' className='link developers'>Nhà phát triển</Link>
          <Link to='/services' className='link services'>Dịch vụ</Link>
          <Link to='/news' className='link news'>Tin tức</Link>
          <Link to='/search' className='link search'>Tra cứu</Link>
        </div>
        <button className='login-btn'>Đăng nhập</button>
      </div>
    );
}

export default Navbar;