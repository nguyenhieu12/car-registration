// import React, { useState, useEffect } from 'react';
// import DashboardContent from '../../components/DashboardContent/DashboardContent';
// import ProfileContent from '../../components/ProfileContent/ProfileContent';
// import NewsContent from '../../components/NewsContent/NewsContent';
// import './Dashboard.css';
// import 'boxicons/css/boxicons.min.css';
// import SettingContent from '../../components/SettingContent/SettingContent';

// function Dashboard(props) {

//     const [currentId, setCurrentId] = useState(0);

//     const [tabs, setTabs] = useState([
//         { id: 0, title: 'Dashboard', content: <DashboardContent />, activeLink: true },
//     ]);

//     const [activeTab, setActiveTab] = useState(tabs[0].id);

//     const addTab = (title, content) => {
//         const existingTab = tabs.find((tab) => tab.title === title);
//         if (existingTab) {
//             setActiveTab(existingTab.id);
//             return;
//         }
//         const newTab = {
//             id: currentId + 1,
//             title: title,
//             content: content,
//             activeLink: false,
//         };
//         setCurrentId(currentId + 1);
//         setTabs([...tabs, newTab]);
//         setActiveTab(newTab.id);
//     };

//     const removeTab = (id) => {
//         if (tabs.length === 1) {
//             return;
//         }

//         let updatedTabs = [];

//         if (id === activeTab) {
//             const index = tabs.findIndex(tab => tab.id === activeTab);
//             if (index > 0 && index < tabs.length) {
//                 setActiveTab(tabs[index - 1].id)
//             } else if (index === 0) {
//                 setActiveTab(tabs[0].id)
//             } else if (index === tabs.length) {
//                 setActiveTab(tabs[tabs.length - 1].id)
//             }
//             updatedTabs = tabs.filter((tab) => tab.id !== id);
//             setTabs(updatedTabs);
//             return;
//         } else {
//             updatedTabs = tabs.filter((tab) => tab.id !== id);
//             setTabs(updatedTabs);
//             setActiveTab(activeTab);
//             return;
//         }
//     };

//     const [isNavOpen, setIsNavOpen] = useState(false);

//     const toggleNavbar = () => {
//         setIsNavOpen(!isNavOpen);
//     };

//     return (
//         <div className="dashboard-container">
//             <header className="header-container" id="header">
//                 <div className="header__toggle" onClick={toggleNavbar}>
//                     <i className={isNavOpen ? 'bx bx-x' : 'bx bx-menu'} style={{ transform: isNavOpen ? 'translateX(170px)' : 'translateX(0)' }} id="header-toggle"></i>
//                 </div>

//                 <div className="header__img">
//                     <img src="https://c.pxhere.com/photos/dd/a6/business_man_businessman_corporate_suit_executive_successful_entrepreneur-675843.jpg!d" alt="" />
//                 </div>
//             </header>

//             <div className={`l-navbar ${isNavOpen ? 'show' : ''}`} id="nav-bar">
//                 <nav className="nav-container">
//                     <div>
//                         <a href="#" className="nav__logo">
//                             <i className="bx bxs-car-garage nav__logo-icon"></i>
//                             <span className="nav__logo-name">Bedimcode</span>
//                         </a>

//                         <div className="nav__list">
//                             <a href="#" className={`nav__link ${tabs.find(tab => tab.title === 'Dashboard') ? 'isActive' : ''}`} onClick={() => addTab('Dashboard', <DashboardContent />)}>
//                                 <i className="bx bx-grid-alt nav__icon"></i>
//                                 <span className="nav__name">Dashboard</span>
//                             </a>

//                             <a href="#" className={`nav__link ${tabs.find(tab => tab.title === 'Thông tin cá nhân') ? 'isActive' : ''}`} onClick={() => addTab('Thông tin cá nhân', <ProfileContent />)}>
//                                 <i className="bx bx-user nav__icon"></i>
//                                 <span className="nav__name">Thông tin cá nhân</span>
//                             </a>

//                             <a href="#" className={`nav__link ${tabs.find(tab => tab.title === 'Quản lý tin tức') ? 'isActive' : ''}`} onClick={() => addTab('Quản lý tin tức', <NewsContent />)}>
//                                 <i className="bx bx-news nav__icon"></i>
//                                 <span className="nav__name">Quản lý tin nhắn</span>
//                             </a>

//                             <a href="#" className={`nav__link ${tabs.find(tab => tab.title === 'Cài đặt') ? 'isActive' : ''}`} onClick={() => addTab('Cài đặt', <SettingContent />)}>
//                                 <i className="bx bxs-cog nav__icon"></i>
//                                 <span className="nav__name">Cài đặt</span>
//                             </a>
//                         </div>
//                     </div>

//                     <a href="#" className="nav__link">
//                         <i className="bx bx-log-out nav__icon"></i>
//                         <span className="nav__name">Đăng xuất</span>
//                     </a>
//                 </nav>
//             </div>

//             <main>
//                 <div className="tab-container">
//                     <div className="tab-header">
//                         {tabs.map((tab) => (
//                             <div
//                                 className={`tab-item ${tab.id === activeTab ? 'active' : ''}`}
//                                 key={tab.id}>
//                                 <p className='tab-title' onClick={() => setActiveTab(tab.id)}>{tab.title}</p>
//                                 {tabs.length > 1 && (
//                                     <span className="tab-close" onClick={() => removeTab(tab.id)}>
//                                         &times;
//                                     </span>
//                                 )}
//                             </div>
//                         ))}
//                     </div>
//                     <div className="tab-content">
//                         {tabs.find((tab) => tab.id === activeTab)?.content}
//                     </div>
//                 </div>
//             </main>
//         </div>
//     );
// }

// export default Dashboard;

import React, { useState, useEffect } from 'react';
import DashboardContent from '../../components/DashboardContent/DashboardContent';
import ProfileContent from '../../components/ProfileContent/ProfileContent';
import NewsContent from '../../components/NewsContent/NewsContent';
import './Dashboard.css';
import 'boxicons/css/boxicons.min.css';
import SettingContent from '../../components/SettingContent/SettingContent';

function Dashboard(props) {

    const [currentId, setCurrentId] = useState(0);

    const [tabs, setTabs] = useState([
        { id: 0, title: 'Dashboard', content: <DashboardContent />, activeLink: true },
    ]);

    const [activeTab, setActiveTab] = useState(tabs[0].id);

    const addTab = (title, content) => {
        const existingTab = tabs.find((tab) => tab.title === title);
        if (existingTab) {
            setActiveTab(existingTab.id);
            return;
        }
        const newTab = {
            id: currentId + 1,
            title: title,
            content: content,
            activeLink: false,
        };
        setCurrentId(currentId + 1);
        setTabs([...tabs, newTab]);
        setActiveTab(newTab.id);
    };

    const removeTab = (id) => {
        if (tabs.length === 1) {
            return;
        }

        let updatedTabs = [];

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
            return;
        } else {
            updatedTabs = tabs.filter((tab) => tab.id !== id);
            setTabs(updatedTabs);
            setActiveTab(activeTab);
            return;
        }
    };

    const [isNavOpen, setIsNavOpen] = useState(false);

    const toggleNavbar = () => {
        setIsNavOpen(!isNavOpen);
    };

    return (
        <div className="dashboard-container">
            <header className="header" id="header">
                <div className="header__toggle" onClick={toggleNavbar}>
                    <i className={isNavOpen ? 'bx bx-x' : 'bx bx-menu'} style={{ transform: isNavOpen ? 'translateX(170px)' : 'translateX(0)' }} id="header-toggle"></i>
                </div>

                <div className="header__img">
                    <img src="https://c.pxhere.com/photos/dd/a6/business_man_businessman_corporate_suit_executive_successful_entrepreneur-675843.jpg!d" alt="" />
                </div>
            </header>

            <div className={`l-navbar ${isNavOpen ? 'show' : ''}`} id="nav-bar">
                <nav className="nav">
                    <div>
                        <a href="#" className="nav__logo">
                            <i className="bx bx-layer nav__logo-icon"></i>
                            <span className="nav__logo-name">Bedimcode</span>
                        </a>

                        <div className="nav__list">
                            <a href="#" className={`nav__link ${tabs.find(tab => tab.title === 'Dashboard') ? 'active' : ''}`} onClick={() => addTab('Dashboard', <DashboardContent />)}>
                                <i className="bx bx-grid-alt nav__icon"></i>
                                <span className="nav__name">Dashboard</span>
                            </a>

                            <a href="#" className={`nav__link ${tabs.find(tab => tab.title === 'Thông tin cá nhân') ? 'active' : ''}`} onClick={() => addTab('Thông tin cá nhân', <ProfileContent />)}>
                                <i className="bx bx-user nav__icon"></i>
                                <span className="nav__name">Thông tin cá nhân</span>
                            </a>

                            <a href="#" className={`nav__link ${tabs.find(tab => tab.title === 'Quản lý tin tức') ? 'active' : ''}`} onClick={() => addTab('Quản lý tin tức', <NewsContent />)}>
                                <i className="bx bx-news nav__icon"></i>
                                <span className="nav__name">Quản lý tin nhắn</span>
                            </a>

                            <a href="#" className={`nav__link ${tabs.find(tab => tab.title === 'Cài đặt') ? 'active' : ''}`} onClick={() => addTab('Cài đặt', <SettingContent />)}>
                                <i className="bx bxs-cog nav__icon"></i>
                                <span className="nav__name">Cài đặt</span>
                            </a>
                        </div>
                    </div>

                    <a href="#" className="nav__link">
                        <i className="bx bx-log-out nav__icon"></i>
                        <span className="nav__name">Đăng xuất</span>
                    </a>
                </nav>
            </div>

            <main>
                <div className="tab-container">
                    <div className="tab-header">
                        {tabs.map((tab) => (
                            <div
                                className={`tab-item ${tab.id === activeTab ? 'active' : ''}`}
                                key={tab.id}>
                                <p className='tab-title' onClick={() => setActiveTab(tab.id)}>{tab.title}</p>
                                {tabs.length > 1 && (
                                    <span className="tab-close" onClick={() => removeTab(tab.id)}>
                                        &times;
                                    </span>
                                )}
                            </div>
                        ))}
                    </div>
                    <div className="tab-content">
                        {tabs.find((tab) => tab.id === activeTab)?.content}
                    </div>
                </div>
            </main>
        </div>
    );
}

export default Dashboard;