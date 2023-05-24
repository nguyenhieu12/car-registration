import { useState } from "react";
import Navbar from "../../components/Navbar/Navbar";
import './Services.css'
import carIcon from '../../assets/icons/car.png';
import certifiIcon from '../../assets/icons/certification.png';
import dbIcon from '../../assets/icons/database.png';
import easyIcon from '../../assets/icons/easy.png';

function Services() {
    const [isFormOpened, setisFormOpened] = useState(false); 

    const handleOpenForm = () => {
        setisFormOpened(true)
    }

    const handleCloseForm = () => {
        setisFormOpened(false)
    }

    return(
        <div className="services-container">
            <h1 className="services-heading">Các dịch vụ được cung cấp</h1>
                <div className="services-options">
                    <div className="options option1">
                        <img src={carIcon} alt="car"/>
                        <h2>Đảm bao an toàn</h2>
                        <p>Phân chia quyền sử dụng</p>
                        <h3>Xem thêm</h3>
                    </div>  
                    <div className="options option2">
                        <img src={certifiIcon} alt="certification"/>
                        <h2>Chứng nhận nhanh chóng</h2>
                        <p>Ghi nhận kết quả nhanh chóng</p>
                        <h3>Xem thêm</h3>
                    </div>
                    <div className="options option3">
                        <img src={dbIcon} alt="database"/>
                        <h2>Lưu trữ hiệu quả</h2>
                        <p>Dữ liệu được lưu trữ hiệu quả</p>
                        <h3>Xem thêm</h3>
                    </div>
                    <div className="options option4">
                        <img src={easyIcon} alt="easy"/>
                        <h2>Dễ dàng sử dụng</h2>
                        <p>Thân thiện với người dùng</p>
                        <h3>Xem thêm</h3>
                    </div>
                </div>
                <div className="services-navbar">
                    <Navbar style={3}
                        isOpen={isFormOpened}
                        handleLoginClick={handleOpenForm}
                        handleOutsideClick={handleCloseForm}
                    />
                </div>
        </div>
    );
}

export default Services;