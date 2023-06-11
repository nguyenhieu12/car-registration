import React, { useState, useRef } from 'react';
import './ChangePassword.css';
import 'boxicons/css/boxicons.min.css';
import {toast, ToastContainer} from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';

function ChangePassword(props) {
  const currentUser = JSON.parse(localStorage.getItem('currentUser'));
  const formRef = useRef();

  const [currentPassword, setCurrentPassword] = useState('');
  const [newPassword, setNewPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const currentPasswordRef = useRef(null);
  const newPasswordRef = useRef(null);
  const confirmPasswordRef = useRef(null);

  const handleUpdate = () => {
    console.log(currentUser.password);
    if (currentPassword !== currentUser.user_name) {
      if (!toast.isActive('checkCurrentPassword')) {
        toast.error('Mật khẩu hiện tại không chính xác', {
          toastId: 'checkCurrentPassword',
          autoClose: 1500,
        });
      }
    } else if (!newPassword) {
      if (!toast.isActive('checkNull')) {
        toast.error('Mật khẩu mới không được để trống', {
          toastId: 'checkNull',
          autoClose: 1500,
        });
      }
    } else if (newPassword !== confirmPassword) {
      if (!toast.isActive('checkConfirm')) {
        toast.error('Mật khẩu không trùng khớp', {
          toastId: 'checkConfirm',
          autoClose: 1500,
        });
      }
    } else if (currentPassword !== currentUser.password && newPassword === confirmPassword) {
      const requirements = validatePassword(newPassword);
      const isAllRequirementsMet = requirements.every((req) => req.isValid);

      if (isAllRequirementsMet) {
        if (!toast.isActive('checkAll')) {
          toast.success('Thay đổi mật khẩu thành công', {
            toastId: 'checkAll',
            autoClose: 1500,
          });
        }
      } else {
        if (!toast.isActive('checkRequirements')) {
          toast.error('Mật khẩu mới không đáp ứng đủ yêu cầu', {
            toastId: 'checkRequirements',
            autoClose: 1500,
          });
        }
      }
    }
  };

  const handleCancel = () => {
    setCurrentPassword('');
    setNewPassword('');
    setConfirmPassword('');
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

  const isCurrentPasswordEmpty = currentPassword.length === 0;

  return (
    <div className='change-password-container'>
      <ToastContainer/>
      <div ref={formRef}>
        <h2 className='change-password-headerText'>Cập nhật tài khoản</h2>
        <div className='form-row'>
          <div className='input-container distance'>
            <label htmlFor='username'>Tài khoản</label>
            <input type='text' id='username' value={currentUser.user_name} disabled />
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
              title={isCurrentPasswordEmpty ? 'Không thể sửa đổi' : null}
              disabled={isCurrentPasswordEmpty}
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
              title={isCurrentPasswordEmpty ? 'Không thể sửa đổi' : null}
              disabled={isCurrentPasswordEmpty}
            />
          </div>
        </div>
        <div className="wrapper">
          <div className="content-rule-password">
            <div>Điều kiện: </div>
            <ul className="requirement-list">
              {renderRequirements()}
            </ul>
          </div>
        </div>
        <div className='form-row'>
          <div className='button-container'>
              <label htmlFor='button-u' className='app-content-headerButton-u'>Cập nhật</label>
              <button id='button-u' className='button-update' type="button" onClick={handleUpdate} style={{ 'display': 'none' }} disabled={isCurrentPasswordEmpty} />
              <label htmlFor='button-c' className='app-content-headerButton-c'>Hủy</label>
              <button id='button-c' className='button-cancel' type="button" onClick={handleCancel} style={{ 'display': 'none' }} disabled={isCurrentPasswordEmpty} />
          </div>
        </div>
      </div>
    </div>
  );
}

export default ChangePassword;
