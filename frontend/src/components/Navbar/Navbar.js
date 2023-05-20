import React from 'react';
import './Navbar.css';
import logo from '../../assets/images/logo.png';
import { useState } from 'react';
import { useNavigate, Link  } from 'react-router-dom';
import LoginForm from '../LoginForm/LoginForm';

function Navbar({isOpen, handleLoginClick, handleOutsideClick}) {
  // const [isFormOpened, setisFormOpened] = useState(false);  

  // const handleOpenForm = (event) => {
  //   event.stopPropagation();
  //   setisFormOpened(true);
  // };

  // const handleCloseForm = () => {
  //   setisFormOpened(false);
  // }

  const navigate = useNavigate();

  function handleNavigateToHome() {
    navigate('/');
  }

  return (
    <div className='navbar-container'>
      <div className='navbar'>
        <img src={logo} alt="Logo" className='logo' onClick={handleNavigateToHome}/>
        <div className='nar-tag'>
          <Link to='/' className='link home bold-text'>Trang chủ</Link>
          <Link to='/developers' className='link developers'>Nhà phát triển</Link>
          <Link to='/services' className='link services'>Dịch vụ</Link>
          <Link to='/news' className='link news'>Tin tức</Link>
          <Link to='/search' className='link search'>Tra cứu</Link>
        </div>
        <button className='login-btn' onClick={handleLoginClick}>Đăng nhập</button>
        {isOpen && <LoginForm closeForm={handleOutsideClick}/>}
      </div>
    </div>
  );
}

export default Navbar;


