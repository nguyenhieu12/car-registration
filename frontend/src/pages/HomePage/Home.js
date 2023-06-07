import React, { useState, useEffect } from 'react';
import './Home.css';
import homeBackground1 from '../../assets/images/home-background1.png';
import homeBackground2 from '../../assets/images/home-background2.png';
import homeBackground3 from '../../assets/images/home-background3.png';
import Navbar from '../../components/Navbar/Navbar';
import {useNavigate} from "react-router-dom";

function Home() {
    const [activeIndex, setActiveIndex] = useState(0);

    useEffect(() => {
        const interval = setInterval(() => {
            setActiveIndex((prevIndex) => (prevIndex + 1) % 3);
        }, 3500);
        return () => clearInterval(interval);
    }, []);

    const [isFormOpened, setIsFormOpened] = useState(false);

    const handleOpenForm = () => {
        setIsFormOpened(true);
    };

    const handleCloseForm = () => {
        setIsFormOpened(false);
    };

    const navigate = useNavigate();

    const handleLearnMore = (path, containerId) => {
        navigate(path + '#' + containerId);
    };

    return (
        <div className="home-container">
            <div className="home-slide" style={{ transform: `translateX(-${activeIndex * 100}vw)` }}>
                <Home1 handleLearnMore={handleLearnMore} />
                <Home2 handleLearnMore={handleLearnMore} />
                <Home3 handleLearnMore={handleLearnMore} />
            </div>
            <Navbar style={1}
                    isOpen={isFormOpened}
                    handleLoginClick={handleOpenForm}
                    handleOutsideClick={handleCloseForm}
            />
        </div>
    );
}

function Home1({ handleLearnMore }) {
    return (
        <div className="home1">
            <div id="page1" className="page-content">
                <h1>Đảm bảo an toàn</h1>
                <h1>phương tiện</h1>
                <p>Đảm bảo phương tiện luôn được kiểm tra</p>
                <p>đúng hạn trước những hành trình dài</p>
                <button onClick={() => handleLearnMore('/services', 'safe')}>Xem thêm</button>
            </div>
            <img src={homeBackground1} alt="Home 1" />
        </div>
    );
}

function Home2({ handleLearnMore }) {
    return (
        <div className="home2">
            <div id="page2" className="page-content">
                <h1>Truy xuất thông</h1>
                <h1>tin dễ dàng</h1>
                <p>Truy xuất dữ liệu đăng kiểm theo quý, năm</p>
                <p>một cách nhanh chóng và dễ dàng</p>
                <button onClick={() => handleLearnMore('/services', 'certificate')}>Xem thêm</button>
            </div>
            <img src={homeBackground2} alt="Home 2" />
        </div>
    );
}

function Home3({ handleLearnMore }) {
    return (
        <div className="home3">
            <div id="page3" className="page-content">
                <h1>Lưu trữ dữ liệu</h1>
                <h1>hiệu quả</h1>
                <p>Dữ liệu được lưu trữ an toàn trong</p>
                <p>cơ sở dữ liệu của cục đăng kiểm</p>
                <button onClick={() => handleLearnMore('/services', 'storage')}>Xem thêm</button>
            </div>
            <img src={homeBackground3} alt="Home 3" />
        </div>
    );
}
export default Home;

