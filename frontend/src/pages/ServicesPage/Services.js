import { useState, useEffect } from "react";
import Navbar from "../../components/Navbar/Navbar";
import './Services.css'
import carIcon from '../../assets/icons/car.png';
import certifiIcon from '../../assets/icons/certification.png';
import dbIcon from '../../assets/icons/database.png';
import easyIcon from '../../assets/icons/easy.png';
import {useNavigate, useLocation} from "react-router-dom";
import optionImg1 from '../../assets/images/option1-img.png'
import optionImg2 from '../../assets/images/option2-img.png'
import optionImg3 from '../../assets/images/option3-img.png'
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
                    <p className='option-desc'>Phân chia quyền sử dụng</p>
                    <h3 className='see-more'>Xem thêm</h3>
                </div>
                <div className="options option2" onClick={() => scrollToContainer('certificate')}>
                    <img src={certifiIcon} alt="certification" />
                    <h2>Chứng nhận nhanh chóng</h2>
                    <p className='option-desc'>Ghi nhận kết quả nhanh chóng</p>
                    <h3 className='see-more'>Xem thêm</h3>
                </div>
                <div className="options option3" onClick={() => scrollToContainer('storage')}>
                    <img src={dbIcon} alt="database" />
                    <h2>Lưu trữ hiệu quả</h2>
                    <p className='option-desc'>Dữ liệu được lưu trữ hiệu quả</p>
                    <h3 className='see-more'>Xem thêm</h3>
                </div>
                <div className="options option4" onClick={() => scrollToContainer('tutorial')}>
                    <img src={easyIcon} alt="easy" />
                    <h2>Dễ dàng sử dụng</h2>
                    <p className='option-desc'>Thân thiện với người dùng</p>
                    <h3 className='see-more'>Xem thêm</h3>
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
            <div className="safe-container" id="safe">
                <div className='content-container container1'>
                    <div className='content'>
                        <h1>Đảm bảo an toàn</h1>
                        <p>&#x2022; Tổng số xe cơ giới đang lưu hành là 4,554,590 xe</p>
                        <p>&#x2022; Cần đảm bảo an toàn khi tham gia giao thông</p>
                        <p>&#x2022; Số phương tiện không được kiểm định gia tăng</p>
                        <p>&#x2022; Trang web hỗ trợ các tác vụ đăng kiểm dễ dàng</p>
                        <p>&#x2022; Quyền quản trị, sử dụng được phân chia rõ ràng</p>
                    </div>
                    <div className='illus-img'>
                        <img src={optionImg1} alt='option1'/>
                    </div>
                </div>
            </div>
            <div className="certificate-container" id="certificate">
                <div className='content-container container2'>
                    <div className='illus-img'>
                        <img src={optionImg2} alt='option2'/>
                    </div>
                    <div className='content'>
                        <h1>Chứng nhận nhanh chóng</h1>
                        <p>&#x2022; Nhập dữ liệu một cách gọn gàng</p>
                        <p>&#x2022; Xử lí thông tin đăng ký dễ dàng</p>
                        <p>&#x2022; Cấp giấy chứng nhận nhanh chóng</p>
                        <p>&#x2022; Kết quả đăng ký được ghi nhận chính xác</p>
                    </div>
                </div>
            </div>
            <div className="storage-container" id="storage">
                <div className='content-container container3'>
                    <div className='content'>
                        <h1>Lưu trữ dữ liệu hiệu quả</h1>
                        <p>&#x2022; Dữ liệu được lưu trữ một cách an toàn</p>
                        <p>&#x2022; Hỗ trợ người dùng tra cứu lịch sử đăng kiểm</p>
                        <p>&#x2022; Giúp các cơ quan dễ dàng thống kê số liệu</p>
                        <p>&#x2022; Tạo mô hình dự đoán lượng xe trong tương lai</p>
                    </div>
                    <div className='illus-img'>
                        <img src={optionImg3} alt='option3'/>
                    </div>
                </div>
            </div>
            <div className="tutorial-container" id="tutorial">
                <div className='content-container container4'>
                    <div className='content'>
                        Hi
                    </div>
                    <div className='illus-img'>

                    </div>
                </div>
            </div>
        </div>
    );
}

export default Services;