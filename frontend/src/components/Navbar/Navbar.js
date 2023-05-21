import React from 'react';
import './Navbar.css';
import logo from '../../assets/images/logo.png';
import { useState, useLayoutEffect } from 'react';
import { useNavigate, Link  } from 'react-router-dom';
import LoginForm from '../LoginForm/LoginForm';

function Navbar({isOpen, handleLoginClick, handleOutsideClick}) {
  const navigate = useNavigate();

  function handleNavigateToHome() {
    navigate('/');
  }

  const [isSelected, setIsSelected] = useState(1);

  const handleSelected = (buttonId) => {
    setIsSelected(buttonId);
  };

  useLayoutEffect(() => {
    // Cập nhật style cho button khi giá trị isSelected thay đổi
    // Dựa trên isSelected, lấy style tương ứng từ mảng buttonStyles
    const buttonStyles = ['', '1', '2', '3', 'style4', 'style5'];
    const loginButton = document.getElementById('login-button');
    loginButton.classList = `login-btn-style${buttonStyles[isSelected]}`;
  }, [isSelected]);

  const getButtonClassName = (buttonId) => {
    return `login-btn-style${buttonId}`;
  };
  
  return (
    <div className='navbar-container'>
      <div className='navbar'>
        <img src={logo} alt="Logo" className='logo' onClick={handleNavigateToHome}/>
        <div className='nar-tag'>
          <Link to='/' className={`link ${isSelected === 1 ? 'bold-text' : ''}`}>Trang chủ</Link>
          <Link to='/developers' className={`link ${isSelected === 2 ? 'selected' : ''}`} onClick={() => handleSelected(2)}>Nhà phát triển</Link>
          <Link to='/services' className={`link ${isSelected === 3 ? 'selected' : ''}`} onClick={() => handleSelected(3)}>Dịch vụ</Link>
          <Link to='/news' className={`link ${isSelected === 4 ? 'selected' : ''}`} onClick={() => handleSelected(4)}>Tin tức</Link>
          <Link to='/search' className={`link ${isSelected === 5 ? 'selected' : ''}`} onClick={() => handleSelected(5)}>Tra cứu</Link>
        </div>
        <button id='login-button' onClick={handleLoginClick}>Đăng nhập</button>
        {isOpen && <LoginForm closeForm={handleOutsideClick}/>}
      </div>
    </div>
  );
}

export default Navbar;


