import React from "react";
import {Link} from "react-router-dom";
import './NavbarMobile.css';
import LoginForm from "../LoginForm/LoginForm";

function NavbarMobile({ isOpen, handleLoginClick, handleOutsideClick }) {
    return(
        <div className='nav-tag-mobile'>
            <Link className='mobile-link' to='/'>Trang chủ</Link>
            <Link className='mobile-link' to='/developers'>Nhà phát triển</Link>
            <Link className='mobile-link' to='/services'>Dịch vụ</Link>
            <Link className='mobile-link' to='/news'>Tin tức</Link>
            <Link className='mobile-link' to='/search'>Tra cứu</Link>
            <button onClick={() => handleLoginClick}>Đăng nhập</button>
            {isOpen && <LoginForm closeForm={handleOutsideClick} />}
        </div>
    );
}

export default NavbarMobile;
