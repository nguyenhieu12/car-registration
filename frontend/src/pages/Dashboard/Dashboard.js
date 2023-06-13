import React, { useState, useEffect } from 'react';
import DashboardContent from '../../components/DashboardContent/DashboardContent';
import ProfileContent from '../../components/ProfileContent/ProfileContent';
import NewsContent from '../../components/NewsContent/NewsContent';
import './Dashboard.css';
import 'boxicons/css/boxicons.min.css';
import SearchContent from '../../components/SearchContent/SearchContent';
import RegistrationCar from '../../components/RegistrationCar/RegistrationCar';
import {useNavigate} from "react-router-dom";
import AccountContent from '../../components/AccountContent/AccountContent';

function Dashboard() {
    const currentUser = JSON.parse(localStorage.getItem('currentUser'));

    const navigate = useNavigate();

    const [isLoggedIn, setIsLoggedIn] = useState(
        currentUser !== null
    )

    const [tabs, setTabs] = useState([
        { id: Date.now(), title: 'Dashboard', content: <DashboardContent />, iconName: 'bx bxs-dashboard' },
    ]);

    const [activeTab, setActiveTab] = useState(tabs[0].id);

    const [contentTabs, setContentTabs] = useState([
        {
            id: tabs[0].id,
            content: <DashboardContent />,
        },
    ]);

    const addTab = (title, content, iconName) => {
        const existingTab = tabs.find((tab) => tab.title === title);
        if (existingTab) {
            setActiveTab(existingTab.id);
            return;
        }
        const newTab = {
            id: Date.now(),
            title: title,
            content: content,
            iconName: iconName,
        };

        setTabs([...tabs, newTab]);
        setActiveTab(newTab.id);

        const newContentTab = {
            id: newTab.id,
            content: content,
        };
        setContentTabs([...contentTabs, newContentTab]);
    };

    const removeTab = (id) => {
        if (tabs.length === 1) {
            return;
        }

        let updatedTabs = [];
        let updatedContentTabs = [];

        if (id === activeTab) {
            const index = tabs.findIndex(tab => tab.id === activeTab);
            if (index > 0 && index < tabs.length) {
                setActiveTab(tabs[index - 1].id)
            } else if (index === 0) {
                setActiveTab(tabs[0].id)
            } else if (index === tabs.length) {
                setActiveTab(tabs[tabs.length - 1].id)
            }
            updatedTabs = tabs.filter((tab) => tab.id !== id);
            setTabs(updatedTabs);

            updatedContentTabs = contentTabs.filter((tab) => tab.id !== id);
            setContentTabs(updatedContentTabs);
            return;
        } else {
            updatedTabs = tabs.filter((tab) => tab.id !== id);
            setTabs(updatedTabs);
            setActiveTab(activeTab);

            updatedContentTabs = contentTabs.filter((tab) => tab.id !== id);
            setContentTabs(updatedContentTabs);
            return;
        }
    };

    const [isOpen, setIsOpen] = useState(false);

    const handleToggle = () => {
        setIsOpen(!isOpen);
    };

    const handleLogout = async () => {
        await localStorage.removeItem('token');
        navigate('/');
    };

    return (
        <div className='dashboard-container'>
            <div className={`sidebar-container ${isOpen ? 'open' : ''}`}>
                <div className="logo-details">
                    <i className="bx bxl-c-plus-plus icon"></i>
                    <div className="logo_name">Hệ thống đăng kiểm</div>
                    <i
                        className={`bx ${isOpen ? 'bx bx-x' : 'bx-menu'}`}
                        id="btn"
                        onClick={handleToggle}
                    ></i>
                </div>
                <ul className="sidebar-list">
                    <li>
                        <a href="#" className={`.sidebar-container li a ${tabs.find(tab => tab.title === 'Dashboard') ? 'isActive' : ''}`} onClick={() => addTab('Dashboard', <DashboardContent />, 'bx bxs-dashboard')}>
                            <i className='bx bxs-dashboard' ></i>
                            <span className="sidebar-links">Dashboard</span>
                        </a>
                        <span className="tooltip">Dashboard</span>
                    </li>
                    <li>
                        <a href="#" className={`.sidebar-container li a ${tabs.find(tab => tab.title === 'Thông tin đăng ký xe') ? 'isActive' : ''}`} onClick={() => addTab('Thông tin đăng ký xe', <RegistrationCar />, 'bx bx-car')}>
                            <i className='bx bx-car'></i>
                            <span className="sidebar-links">Thông tin đăng ký xe</span>
                        </a>
                        <span className="tooltip">Thông tin đăng ký xe</span>
                    </li>
                    <li>
                        <a href="#" className={`.sidebar-container li a ${tabs.find(tab => tab.title === 'Tra cứu đăng kiểm') ? 'isActive' : ''}`} onClick={() => addTab('Tra cứu đăng kiểm', <SearchContent/>, 'bx bx-search-alt')}>
                        <i className='bx bx-search-alt' ></i>
                            <span className="sidebar-links">Tra cứu đăng kiểm</span>
                        </a>
                        <span className="tooltip">Tra cứu đăng kiểm</span>
                    </li>
                    <li>
                        <a href="#" className={`.sidebar-container li a ${tabs.find(tab => tab.title === 'Thông tin cá nhân') ? 'isActive' : ''}`} onClick={() => addTab('Thông tin cá nhân', <ProfileContent isLoggedIn={isLoggedIn}/>, 'bx bx-user')}>
                            <i className='bx bx-user' ></i>
                            <span className="sidebar-links">Thông tin cá nhân</span>
                        </a>
                        <span className="tooltip">Thông tin cá nhân</span>
                    </li>
                    <li>
                        <a href="#" className={`.sidebar-container li a ${tabs.find(tab => tab.title === 'Cấp tài khoản') ? 'isActive' : ''}`} onClick={() => addTab('Cấp tài khoản', <AccountContent isLoggedIn={isLoggedIn}/>, 'bx bxs-user-account')}>
                            <i class='bx bxs-user-account'></i>
                            <span className="sidebar-links">Cấp tài khoản</span>
                        </a>
                        <span className="tooltip">Cấp tài khoản</span>
                    </li>
                    <li>
                        <a href="#" className={`.sidebar-container li a ${tabs.find(tab => tab.title === 'Quản lý tin tức') ? 'isActive' : ''}`} onClick={() => addTab('Quản lý tin tức', <NewsContent />, 'bx bx-news')}>
                            <i className='bx bx-news' ></i>
                            <span className="sidebar-links">Quản lý tin tức</span>
                        </a>
                        <span className="tooltip">Quản lý tin tức</span>
                    </li>
                    <li className='logout'>
                        <a href="" onClick={handleLogout}>
                            <i className='bx bx-log-out' ></i>
                            <span className="sidebar-links">Đăng xuất</span>
                        </a>
                        <span className="tooltip">Đăng xuất</span>
                    </li>
                </ul>
            </div>

            <section className="main-container">
                <div className="main-container-header">
                    <div className='welcome'>
                        <p style={{"color": "#000"}}>Chào mừng quay trở lại,</p>
                        <h2 className='user-name-title'>{isLoggedIn ? (currentUser.first_name) : ''}</h2>
                    </div>
                    <div className="user-info">
                        <div className="search-box">
                            <i className='bx bx-search'></i>
                            <input type="text" placeholder="Search" />
                        </div>
                        <img
                            src="https://scontent.fhan14-4.fna.fbcdn.net/v/t1.6435-9/182741929_107870648128506_6644574165595211881_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=5kAhAr4PEkoAX-zfreP&_nc_ht=scontent.fhan14-4.fna&oh=00_AfCJqeKHCh0PvtaZ9Y9AiY_0vUc6X8QkOtlc9loxucFV0w&oe=649DFFEE"
                            alt=""
                        />
                    </div>
                </div>

                <div className="tab-container">
                    <div className="tab-header">
                        {tabs.map((tab) => (
                            <div
                                className={`tab-item ${tab.id === activeTab ? 'active' : ''}`}
                                key={tab.id}>
                                <i className={tab.iconName}></i>
                                <p className='tab-title' onClick={() => setActiveTab(tab.id)}>{tab.title}</p>
                                {tabs.length > 1 && (
                                    <span className="tab-close" onClick={() => removeTab(tab.id)}>
                                        &times;
                                    </span>
                                )}
                                { }
                            </div>
                        ))}
                    </div>
                    <div className="tab-content">
                        {contentTabs.find((tab) => tab.id === activeTab)?.content}
                    </div>
                </div>
            </section>
        </div>
    );
}

export default Dashboard;