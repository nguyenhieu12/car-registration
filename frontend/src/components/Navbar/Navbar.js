import React from 'react';
import './Navbar.css';
import logo from '../../assets/images/logo.png';
import { useNavigate, Link  } from 'react-router-dom';
import { useState, useEffect } from "react";
import LoginForm from '../LoginForm/LoginForm';
import NavbarMobile from "./NavbarMobile";

function Navbar({style, isOpen, handleLoginClick, handleOutsideClick}) {
  const navigate = useNavigate();

  const [isMobile, setIsMobile] = useState(false);

  function handleNavigateToHome() {
    navigate('/');
  }

  const [windowWidth, setWindowWidth] = useState(window.innerWidth);

  useEffect(() => {
    const handleResize = () => {
      if(windowWidth >= 740) {
        setIsMobile(false);
      }
      setWindowWidth(window.innerWidth);
    };

    window.addEventListener('resize', handleResize);

    return () => {
      window.removeEventListener('resize', handleResize);
    };
  }, [windowWidth]);

  const handleDisplayNavbar = () => {
    setIsMobile(!isMobile);
  }

  return (
    <div className='navbar-container'>
      <div className={`navbar ${(style === 4 || style === 5) ? 'navbar-search-news' : `${style === 3 ? 'navbar-services' : ''} `}`}>
        <img src={logo} alt="Logo" className='logo' onClick={handleNavigateToHome}/>
        <div className='nav-tag'>
          <Link to='/' className={`link ${style === 1 ? 'bold-text' : `${(style !== 1 && style !== 4 && style !==5) ? 'white-normal' : ''}`}`}>Trang chủ</Link>
          <Link to='/developers' className={`link ${style === 2 ? 'bold-text white-text' : `${(style !== 1 && style !== 4 && style !== 5) ? 'white-normal' : ''}`}`}>Nhà phát triển</Link>
          <Link to='/services' className={`link ${style === 3 ? 'bold-text white-text' : `${(style !== 1 && style !== 4 && style !== 5) ? 'white-normal' : ''}`}`}>Dịch vụ</Link>
          {/*<Link to='/news' className={`link ${style === 4 ? 'bold-text' : `${(style !== 1 && style !== 4 && style !==5) ? 'white-normal' : ''}`}`}>Tin tức</Link>*/}
          <Link to='/search' className={`link ${style === 5 ? 'bold-text' : `${(style !== 1 && style !== 4) ? 'white-normal' : ''}`}`}>Tra cứu</Link>
        </div>
        <button className={`login-btn btn-style${style}`} onClick={handleLoginClick}>Đăng nhập</button>
        {isMobile && <NavbarMobile isOpen={isOpen} handleLoginClick={handleLoginClick} handleOutsideClick={handleOutsideClick}/>}
        {isOpen && <LoginForm closeForm={handleOutsideClick} />}
        <div
            className={`menu ${(windowWidth < 740) ? '' : 'not-mobile'} ${isMobile ? 'options-open' : ''}`}
            onClick={handleDisplayNavbar}
        >
          <hr className='menu-line' onClick={() => handleDisplayNavbar}></hr>
          <hr className='menu-line' onClick={() => handleDisplayNavbar}></hr>
          <hr className='menu-line' onClick={() => handleDisplayNavbar}></hr>
        </div>
      </div>
    </div>
  );
}

export default Navbar;


