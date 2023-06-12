import React, {useRef, useEffect, useState} from 'react';
import './LoginForm.css';
import userIcon from '../../assets/icons/user-icon.png';
import passwordIcon from '../../assets/icons/password-icon.png';
import {useNavigate} from "react-router-dom";
import {toast} from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';

function LoginForm({ closeForm }) {
  const formRef = useRef();

  const navigate = useNavigate();

  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');

  var loginData = {
    user_name: username,
    password: password
  }

  var options = {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(loginData)
  }

  const handleValidate = () => {
    if (!toast.isActive('wrongInfo')) {
      toast.error('Tên đăng nhập hoặc mật không đúng. Vui lòng nhập lại', {
        toastId: 'wrongInfo',
        autoClose: 1500
      });
    }
  }

  const handleLogin = async (e) => {
    if (username === '') {
      if (!toast.isActive('emptyUsername')) {
        toast.error('Tên đăng nhập không được trống', {
          toastId: 'emptyUsername',
          autoClose: 1500,
          className: 'custom-toast-error'
        });
      }
    } else if (password === '') {
      if (!toast.isActive('emptyPassword')) {
        toast.error('Mật khẩu không được trống', {
          toastId: 'emptyPassword',
          autoClose: 1500
        });
      }
    } else {
      await fetch('http://localhost:5000/api/v1/auth/login', options)
          .then((response) => response.json())
          .then((data) => {
            const token = data.data.token;
            const currentUser = data.data.user;

            localStorage.setItem('token', token);
            localStorage.setItem('currentUser', JSON.stringify(currentUser));

            console.log(token);

            navigate('/dashboard');
          })
          .catch((error) => {
            handleValidate();
            console.log(error);
          });
    }
  }

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

  return (
      <div className='login-container' ref={formRef} onClick={closeForm}>
        <div className="login-background" onClick={handleClickInside}>
          <div className='login-form'>
            <h2>Chào mừng</h2>
            <div className='input-wrapper'>
              <img src={userIcon} alt='user'/>
              <input
                  type='text'
                  className='input-field'
                  value={username}
                  placeholder='Tên đăng nhập'
                  onChange={(e) => setUsername(e.target.value)}
              />
            </div>
            <hr/>
            <div className='input-wrapper'>
              <img src={passwordIcon} alt='password'/>
              <input
                  type='password'
                  className='input-field'
                  value={password}
                  placeholder='Mật khẩu'
                  onChange={(e) => setPassword(e.target.value)}
              />
            </div>
            <hr/>
            <div className='login-options'>
              <input type='checkbox'/>
              <span>Ghi nhớ đăng nhập</span>
              <span>Quên mật khẩu?</span>
            </div>
            <button className='login' onClick={handleLogin}>Đăng nhập</button>
          </div>
        </div>
      </div>
  );
}

export default LoginForm;