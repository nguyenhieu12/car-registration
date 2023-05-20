import React, { useState, useRef, useEffect } from 'react';
import './LoginForm.css';
import userIcon from '../../assets/icons/user-icon.png';
import passwordIcon from '../../assets/icons/password-icon.png';

function LoginForm({ closeForm }) {
  const formRef = useRef();

  useEffect(() => {
    const handleClickOutside = (event) => {
      if (formRef.current && !formRef.current.contains(event.target)) {
        closeForm();
      }
    };

    document.addEventListener('mousedown', handleClickOutside);

    return () => {
      document.removeEventListener('mousedown', handleClickOutside);
    };
  }, [closeForm]);

  const handleClickInside = (event) => {
    event.stopPropagation();
  };

  // const [isFocused, setIsFocused] = useState(false);

  // const handleFocus = () => {
  //   setIsFocused(true);
  // };

  // const handleBlur = () => {
  //   setIsFocused(false);
  // };

  return (
    <div className='login-container' ref={formRef} onClick={closeForm}>
      <div className="login-background" onClick={handleClickInside}>
        <div className='login-form'>
          <h2>Chào mừng</h2>
          <div className='input-wrapper'>
            <img src={userIcon} />
            <input 
              type='text'
              className='input-field'
              placeholder='Tên đăng nhập'
            />
          </div>
          <hr/>
          <div className='input-wrapper'>
            <img src={passwordIcon} />
            <input 
              type='password'
              className='input-field'
              placeholder='Mật khẩu'
            />
          </div>
          <hr/>
          <div className='login-options'>
            <input type='checkbox'/>
            <span>Ghi nhớ đăng nhập</span>
            <span>Quên mật khẩu?</span>
          </div>
          <button className='login'>Đăng nhập</button>
        </div>
      </div>
    </div>
  );
}

export default LoginForm;




