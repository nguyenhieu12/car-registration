// import React, {useState} from 'react';
// import './ChangePassword.css';
// import 'boxicons/css/boxicons.min.css';

// function ChangePassword(props) {
//     return (
//       <div className='change-password-container'>
//         <div>
//           <h2 className='change-password-headerText'>Cập nhật tài khoản</h2>
//           <h4>Cũ</h4>
//           <div className='form-row'>
//             <div className="input-container distance">
//               <label htmlFor="phoneNumber">Tài khoản</label>
//               <input
//                 type="text"
//                 id="phoneNumber"
//               />
//             </div>
//             <div className='input-container'>
//             </div>
//           </div>
//           <div className='form-row'>
//             <div className="input-container distance">
//               <label htmlFor="phoneNumber">Mật khẩu khẩu hiện tại</label>
//               <input
//                 type="text"
//                 id="phoneNumber"
//               />
//             </div>
//             <div className='input-container'>
//             </div>
//           </div>
//           <h4>Mới</h4>
//           <div className='form-row'>
//             <div className="input-container distance">
//               <label htmlFor="email">Mật khẩu mới</label>
//               <input
//                 type="text"
//                 id="email"
//               />
//             </div>
//             <div className="input-container">
//             <label htmlFor="email">Nhập lại mật khẩu</label>
//             <input
//               type="text"
//               id="email"
//             />
//           </div>
//           </div>
//           <div className="form-row">
//             <div className="button-container">
//               <button className='button-update' type="button">
//                 Cập nhật
//               </button>
//               <button className='button-cancel' type="button">
//                 Hủy bỏ
//               </button>
//             </div>
//           </div>
//         </div>
//       </div> 
//     );
// }

// export default ChangePassword;

import React, { useState, useRef } from 'react';
import './ChangePassword.css';
import 'boxicons/css/boxicons.min.css';

function ChangePassword(props) {
  const [currentPassword, setCurrentPassword] = useState('');
  const [newPassword, setNewPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [errorMessage, setErrorMessage] = useState('');
  const currentPasswordRef = useRef(null);
  const newPasswordRef = useRef(null);
  const confirmPasswordRef = useRef(null);


  const currentUser = localStorage.getItem('currentUser');

  const handleUpdate = () => {
    if (currentPassword !== 'Anhyeuem1234!') {
      setErrorMessage('Mật khẩu hiện tại không chính xác');
      return;
    }

    if (newPassword !== confirmPassword) {
      setErrorMessage('Mật khẩu mới không trùng khớp');
      return;
    }

    // Thực hiện cập nhật mật khẩu

    // Reset form
    setCurrentPassword('');
    setNewPassword('');
    setConfirmPassword('');
    setErrorMessage('');
  };

  const handleCancel = () => {
    setCurrentPassword('');
    setNewPassword('');
    setConfirmPassword('');
    setErrorMessage('');
  };

  const handleKeyDown = (event, nextInputRef) => {
    if (event.key === 'Enter') {
      event.preventDefault();
      nextInputRef.current.focus();
    }
  };

  const handlePasswordChange = (e) => {
    const value = e.target.value;
    setNewPassword(value);
  };

  const togglePasswordVisibility = () => {
    const passwordInput = document.getElementById('passwordInput');
    passwordInput.type =
      passwordInput.type === 'password' ? 'text' : 'password';
  };

  const getRequirements = () => [
    { regex: /.{8,}/, index: 0, content: "Lớn hơn 8 ký tự" },
    { regex: /[0-9]/, index: 1, content: "Có ít nhất 1 ký tự số" },
    { regex: /[a-z]/, index: 2, content: "Có ít nhất 1 ký tự in thường" },
    { regex: /[^A-Za-z0-9]/, index: 3, content: "Có ít nhất 1 ký tự đặc biệt" },
    { regex: /[A-Z]/, index: 4, content: "Có ít nhất một ký tự in hoa" },
  ];

  const validatePassword = (password) => {
    const requirements = getRequirements();
    const updatedRequirements = requirements.map((item) => {
      const isValid = item.regex.test(password);
      return { ...item, isValid };
    });
    return updatedRequirements;
  };

  const renderRequirements = () => {
    const updatedRequirements = validatePassword(newPassword);
    return updatedRequirements.map((item) => (
      <li
        key={item.index}
        className={item.isValid ? 'valid' : ''}
      >
        <i className={item.isValid ? 'bx bx-check-circle' : 'bx bx-circle'}></i>
        <span>{item.content}</span>
      </li>
    ));
  };

  return (
    <div className='change-password-container'>
      <div>
        <h2 className='change-password-headerText'>Cập nhật tài khoản</h2>
        <div className='form-row'>
          <div className='input-container distance'>
            <label htmlFor='phoneNumber'>Tài khoản</label>
            <input type='text' id='phoneNumber' value='123456' disabled />
          </div>
          <div className='input-container'></div>
        </div>
        <div className='form-row'>
          <div className='input-container distance'>
            <label htmlFor='currentPassword'>Mật khẩu hiện tại</label>
            <input
              type='password'
              id='currentPassword'
              value={currentPassword}
              onChange={(e) => setCurrentPassword(e.target.value)}
              onKeyDown={(e) => handleKeyDown(e, newPasswordRef)}
              ref={currentPasswordRef}
            />
          </div>
          <div className='input-container'></div>
        </div>
        <div className='form-row'>
          <div className='input-container distance'>
            <label htmlFor='newPassword'>Mật khẩu mới</label>
            <input
              type='password'
              id='newPassword'
              value={newPassword}
              onChange={handlePasswordChange}
              onKeyDown={(e) => handleKeyDown(e, confirmPasswordRef)}
              ref={newPasswordRef}
            />
          </div>
          <div className='input-container'>
            <label htmlFor='confirmPassword'>Nhập lại mật khẩu</label>
            <input
              type='password'
              id='confirmPassword'
              value={confirmPassword}
              onChange={(e) => setConfirmPassword(e.target.value)}
              onKeyDown={(e) => handleKeyDown(e, currentPasswordRef)}
              ref={confirmPasswordRef}
            />
          </div>
        </div>
        <div className="wrapper">
          <div className="content">
            <div>Điều kiện: </div>
            <ul className="requirement-list">
              {renderRequirements()}
            </ul>
          </div>
        </div>
        <div className='form-row'>
          <div className='button-container'>
            <button className='button-update' type='button' onClick={handleUpdate}>
              Cập nhật
            </button>
            <button className='button-cancel' type='button' onClick={handleCancel}>
              Hủy bỏ
            </button>
          </div>
        </div>
        {errorMessage && <div className='error-message'>{errorMessage}</div>}
      </div>
    </div>
  );
}

export default ChangePassword;
