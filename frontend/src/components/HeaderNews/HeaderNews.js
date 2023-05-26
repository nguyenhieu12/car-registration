import React from 'react';
import './HeaderNews.css';

function HeaderNews(props) {
    return (
        <div className='news-header'>
            <h2>Tin tức mới nhất về</h2>
            <h1>
                <strong>"</strong>Đăng kiểm<strong>"</strong>
            </h1>
            <p>
                Nơi cập nhật các thông tin mới nhất về đăng kiểm ô tô <br /> các lịch thông báo từ phía trung tâm đăng kiểm,
                cục đăng kiểm.
            </p>
        </div>
    );
}

export default HeaderNews;