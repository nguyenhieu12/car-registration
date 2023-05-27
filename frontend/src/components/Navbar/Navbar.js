import React from 'react';
import './Navbar.css';
import logo from '../../assets/images/logo.png';
import { useNavigate, Link  } from 'react-router-dom';
import LoginForm from '../LoginForm/LoginForm';

function Navbar({style, isOpen, handleLoginClick, handleOutsideClick}) {
  const navigate = useNavigate();

  function handleNavigateToHome() {
    navigate('/');
  }

  return (
    <div className='navbar-container'>
      <div className='navbar'>
        <img src={logo} alt="Logo" className='logo' onClick={handleNavigateToHome}/>
        <div className='nar-tag'>
          <Link to='/' className={`link ${style === 1 ? 'bold-text' : `${(style !== 1 && style !== 4 && style !== 6) ? 'white-normal' : ''}`}`}>Trang chủ</Link>
          <Link to='/developers' className={`link ${style === 2 ? 'bold-text white-text' : `${(style !== 1 && style !== 4 && style !== 6) ? 'white-normal' : ''}`}`}>Nhà phát triển</Link>
          <Link to='/services' className={`link ${style === 3 ? 'bold-text white-text' : `${(style !== 1 && style !== 4 && style !== 6) ? 'white-normal' : ''}`}`}>Dịch vụ</Link>
          <Link to='/news' className={`link ${style === 4 ? 'bold-text' : `${(style !== 1 && style !== 6) ? 'white-normal' : ''}`}`}>Tin tức</Link>
          {/*<Link to='/search' className={`link ${style === 5 ? 'bold-text white-text' : `${(style !== 1 && style !== 4) ? 'white-normal' : ''}`}`}>Tra cứu</Link>*/}
          <Link to='/search' className={`link ${style === 6 ? 'bold-text' : `${style === 5 ? 'bold-text white-text' : `${(style !== 1 && style !== 4) ? 'white-normal' : ''}`}`}`}>Tra cứu</Link>
        </div>
        <button id='login-button' className={`login-btn btn-style${style}`} onClick={handleLoginClick}>Đăng nhập</button>
        {isOpen && <LoginForm closeForm={handleOutsideClick}/>}
      </div>
    </div>
  );
}

export default Navbar;


