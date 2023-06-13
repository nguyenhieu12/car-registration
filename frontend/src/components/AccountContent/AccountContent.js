import React, { useState } from 'react';
import './AccountContent.css';

function AccountContent(props) {
    const [currentIndex, setCurrentIndex] = useState(0);
    return (
        <div className='account-content-container'>
            <div className='spaceAround first-item'>
                <h1 className='app-content-headerText'>Cấp mới tài khoản</h1>
                <section className="step-wizard">
                    <ul className="step-wizard-list">
                        <li className={`step-wizard-item  ${currentIndex === 0 ? 'current-item' : ''}`}>
                            <span className="progress-count">1</span>
                            <span className="progress-label">Thông tin</span>
                        </li>
                        <li className={`step-wizard-item  ${currentIndex === 1 ? 'current-item' : ''}`}>
                            <span className="progress-count">2</span>
                            <span className="progress-label">Tài khoản</span>
                        </li>
                        <li className={`step-wizard-item  ${currentIndex === 2 ? 'current-item' : ''}`}>
                            <span className="progress-count">3</span>
                            <span className="progress-label">Thành công</span>
                        </li>
                    </ul>
                </section>
            </div>
            <div className='second-item'>
            {currentIndex === 0 ? <p>0</p> : (currentIndex === 1 ? <p>1</p> : <p>2</p>)}
            </div>
            <div className='spaceAround third-item'>
                <p></p>
                <div>
                    <label htmlFor='button-u' className='app-content-headerButton-u'>Tiếp tục</label>
                    <button id='button-u' className='button-update' type="button" onClick={() => setCurrentIndex(currentIndex + 1)} style={{ 'display': 'none' }} disabled={currentIndex === 2} />
                </div>
            </div>
        </div>
    );
}

export default AccountContent;