import React, { useState, useEffect } from 'react';
import './Home.css';
import homeBackground1 from '../../assets/images/home-background1.png';
import homeBackground2 from '../../assets/images/home-background2.png';
import homeBackground3 from '../../assets/images/home-background3.png';
import Navbar from '../../components/Navbar/Navbar';

function Home() {
  const [activeIndex, setActiveIndex] = useState(0);

  useEffect(() => {
    const interval = setInterval(() => {
      setActiveIndex((prevIndex) => (prevIndex + 1) % 3);
    }, 3500);
    return () => clearInterval(interval);
  }, []);

  return (
    <div className="home-container">
      <Navbar />
      <div
        className="home-slide"
        style={{ transform: `translateX(-${activeIndex * 100}vw)` }}
      >
        <Home1 />
        <Home2 />
        <Home3 />
      </div>
    </div>
  );
};

function Home1() {
  return (
    <div className="home1">
      <img src={homeBackground1} alt="Home 1" />
    </div>
  );
}

function Home2() {
  return (
    <div className="home2">
      <img src={homeBackground2} alt="Home 2" />
    </div>
  );
}

function Home3() {
  return (
    <div className="home3">
      <img src={homeBackground3} alt="Home 3" />
      <div className='page-content'>
        <h1>Lưu trữ dữ liệu</h1>
        <h1>Hiệu quả</h1>
        <p>Dữ liệu được lưu trữ an toàn trong cơ sở</p>
        <p>dữ liệu của cục đăng kiểm</p>
      </div>
    </div>
  );
}

export default Home;