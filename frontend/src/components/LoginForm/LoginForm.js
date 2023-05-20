import React, { useRef, useEffect } from 'react';
import './LoginForm.css';

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

  return (
    <div className='login-container' ref={formRef} onClick={closeForm}>
      <div className="login-content" onClick={handleClickInside}>

      </div>
    </div>
  );
}

export default LoginForm;




