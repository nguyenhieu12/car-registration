import React from 'react';
import './Navbar.css';
import logo from '../../assets/images/logo.png';
import { useNavigate, Link  } from 'react-router-dom';
import { useState, useEffect } from "react";
import LoginForm from '../LoginForm/LoginForm';
import axios from "axios";

function Navbar({style, isOpen, handleLoginClick, handleOutsideClick}) {
  const navigate = useNavigate();

  function handleNavigateToHome() {
    navigate('/');
  }

  const [windowWidth, setWindowWidth] = useState(window.innerWidth);

  useEffect(() => {
    // Hàm xử lý sự kiện resize
    const handleResize = () => {
      setWindowWidth(window.innerWidth);
    };

    window.addEventListener('resize', handleResize);

    return () => {
      window.removeEventListener('resize', handleResize);
    };
  }, []);

  const getData = () => {
    fetch('http://localhost:5000/api/v1/auth/all?size=10&page=0', {mode: 'no-cors'})
        .then(respon => respon.json())
        .then(data => console.log(data));
  }

  return (
    <div className='navbar-container'>
      <div className={`navbar ${(style === 4 || style === 5) ? 'navbar-search-news' : `${style === 3 ? 'navbar-services' : ''} `}`}>
        <img src={logo} alt="Logo" className='logo' onClick={handleNavigateToHome}/>
        <div className='nar-tag'>
          <Link to='/' className={`link ${style === 1 ? 'bold-text' : `${(style !== 1 && style !== 4 && style !==5) ? 'white-normal' : ''}`}`}>Trang chủ</Link>
          <Link to='/developers' className={`link ${style === 2 ? 'bold-text white-text' : `${(style !== 1 && style !== 4 && style !== 5) ? 'white-normal' : ''}`}`}>Nhà phát triển</Link>
          <Link to='/services' className={`link ${style === 3 ? 'bold-text white-text' : `${(style !== 1 && style !== 4 && style !== 5) ? 'white-normal' : ''}`}`}>Dịch vụ</Link>
          <Link to='/news' className={`link ${style === 4 ? 'bold-text' : `${(style !== 1 && style !== 4 && style !==5) ? 'white-normal' : ''}`}`}>Tin tức</Link>
          <Link to='/search' className={`link ${style === 5 ? 'bold-text' : `${(style !== 1 && style !== 4) ? 'white-normal' : ''}`}`}>Tra cứu</Link>
        </div>
        <button className={`login-btn btn-style${style}`} onClick={handleLoginClick}>Đăng nhập</button>
        <div className={`menu ${(windowWidth < 740) ? '' : 'not-mobile'}`}>
          <hr className='menu-line'></hr>
          <hr className='menu-line'></hr>
          <hr className='menu-line'></hr>
        </div>
        {/*<button onClick={getData}>get data</button>*/}

        {isOpen && <LoginForm closeForm={handleOutsideClick}/>}
      </div>
    </div>
  );
}

export default Navbar;


