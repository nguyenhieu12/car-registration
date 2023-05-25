import { useState, useEffect } from "react";
import Navbar from "../../components/Navbar/Navbar";
import './Services.css'
import carIcon from '../../assets/icons/car.png';
import certifiIcon from '../../assets/icons/certification.png';
import dbIcon from '../../assets/icons/database.png';
import easyIcon from '../../assets/icons/easy.png';
import {useNavigate, useLocation} from "react-router-dom";

function Services() {
    const [isFormOpened, setIsFormOpened] = useState(false);

    const handleOpenForm = () => {
        setIsFormOpened(true);
    };

    const handleCloseForm = () => {
        setIsFormOpened(false);
    };

    const navigate = useNavigate();

    const scrollToContainer = (containerId) => {
        const container = document.getElementById(containerId);
        if (container) {
            container.scrollIntoView({ behavior: 'smooth' });
            navigate(`#${containerId}`);
        }
    };

    const location = useLocation();

    useEffect(() => {
        const containerId = location.hash.substr(1);
        const container = document.getElementById(containerId);
        if (container) {
            container.scrollIntoView({ behavior: 'smooth' });
        }
    }, [location]);

    return (
        <div className="services-container">
            <h1 className="services-heading">Các dịch vụ được cung cấp</h1>
            <div className="services-options">
                <div className="options option1" onClick={() => scrollToContainer('safe')}>
                    <img src={carIcon} alt="car" />
                    <h2>Đảm bảo an toàn</h2>
                    <p>Phân chia quyền sử dụng</p>
                    <h3>Xem thêm</h3>
                </div>
                <div className="options option2" onClick={() => scrollToContainer('certificate')}>
                    <img src={certifiIcon} alt="certification" />
                    <h2>Chứng nhận nhanh chóng</h2>
                    <p>Ghi nhận kết quả nhanh chóng</p>
                    <h3>Xem thêm</h3>
                </div>
                <div className="options option3" onClick={() => scrollToContainer('storage')}>
                    <img src={dbIcon} alt="database" />
                    <h2>Lưu trữ hiệu quả</h2>
                    <p>Dữ liệu được lưu trữ hiệu quả</p>
                    <h3>Xem thêm</h3>
                </div>
                <div className="options option4" onClick={() => scrollToContainer('tutorial')}>
                    <img src={easyIcon} alt="easy" />
                    <h2>Dễ dàng sử dụng</h2>
                    <p>Thân thiện với người dùng</p>
                    <h3>Xem thêm</h3>
                </div>
            </div>
            <div className="services-navbar">
                <Navbar
                    style={3}
                    isOpen={isFormOpened}
                    handleLoginClick={handleOpenForm}
                    handleOutsideClick={handleCloseForm}
                />
            </div>
            <div className="safe" id="safe">
                Hello 1
            </div>
            <div className="certificate" id="certificate">
                Hello 2
            </div>
            <div className="storage" id="storage">
                Hello 3
            </div>
            <div className="tutorial" id="tutorial">
                Hello 4
            </div>
        </div>
    );
}

export default Services;
