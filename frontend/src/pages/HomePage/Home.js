import React, { useState, useEffect } from 'react';
import './Home.css';
import homeBackground1 from '../../assets/images/home-background1.png';
import homeBackground2 from '../../assets/images/home-background2.png';
import homeBackground3 from '../../assets/images/home-background3.png';
import Navbar from '../../components/Navbar/Navbar';
import Developers from '../DevelopersPage/Developers';
import Services from '../ServicesPage/Services';
import News from '../NewsPage/News';
import Search from '../SearchPage/Search';

function Home() {
  const [activeIndex, setActiveIndex] = useState(0);

  useEffect(() => {
    const interval = setInterval(() => {
      setActiveIndex((prevIndex) => (prevIndex + 1) % 3);
    }, 3500);
    return () => clearInterval(interval);
  }, []);

  const [isFormOpened, setisFormOpened] = useState(false); 

  const handleOpenForm = () => {
    setisFormOpened(true)
  }

  const handleCloseForm = () => {
    setisFormOpened(false)
  }

  const [tabSelected, setTabSelected] = useState(1);

  function handleTabSelected(tab) {
    setTabSelected(tab);
  }

  return (
    <div className='home-container' >
      <div
        className="home-slide"
        style={{ transform: `translateX(-${activeIndex * 100}vw)` }}
      >
        <Home1 />
        <Home2 />
        <Home3 />
      </div>
      <Navbar style={1} isOpen={isFormOpened} handleLoginClick={handleOpenForm} handleOutsideClick={handleCloseForm}/>
    </div>
  );
};

function Home1() {
  return (
    <div className="home1">
      <div id="page1" className="page-content">
        <h1>Đảm bảo an toàn</h1>
        <h1>phương tiện</h1>
        <p>Đảm bảo phương tiện luôn được kiểm tra</p>
        <p>đúng hạn trước những hành trình dài</p>
        <button>Xem thêm</button>
      </div>
      <img src={homeBackground1} alt="Home 1" />
    </div>
  );
}

function Home2() {
  return (
    <div className="home2">
      <div id="page2" className="page-content">
        <h1>Truy xuất thông tin</h1>
        <h1>dễ dàng</h1>
        <p>Truy xuất dữ liệu đăng kiểm theo quý, năm</p>
        <p>một cách nhanh chóng và dễ dàng</p>
        <button>Xem thêm</button>
      </div>
      <img src={homeBackground2} alt="Home 2" />
    </div>
  );
}

function Home3() {
  return (
    <div className="home3">
      <div id="page3" className="page-content">
        <h1>Lưu trữ dữ liệu</h1>
        <h1>hiệu quả</h1>
        <p>Dữ liệu được lưu trữ an toàn trong cơ sở</p>
        <p>dữ liệu của cục đăng kiểm</p>
        <button>Xem thêm</button>
      </div>
      <img src={homeBackground3} alt="Home 3" />
    </div>
  );
}

export default Home;

