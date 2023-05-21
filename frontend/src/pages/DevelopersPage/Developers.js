import { useState  } from "react";
import Navbar from "../../components/Navbar/Navbar";
import './Developers.css';
import dev1 from '../../assets/images/dev1.jpg';
import dev2 from '../../assets/images/dev2.jpg';
import dev3 from '../../assets/images/dev3.jpg';

function Developers() {
    const [isFormOpened, setisFormOpened] = useState(false); 

    const handleOpenForm = () => {
        setisFormOpened(true)
    }

    const handleCloseForm = () => {
        setisFormOpened(false)
    }

    return(
        <div className='container'>
            
            <h1 className="dev-heading">Đội ngũ phát triển</h1>
            <div className='developers'>
                <div className="developer1">
                    <img src={dev1} alt="dev2" className="rounded-img"/>
                    <h1 className="dev-name">Đào Trọng Đăng</h1>
                    <p className="dev-desc">Chiến thần Backend</p>
                </div>
                <div className="developer2">
                    <img src={dev2} alt="dev2" className="rounded-img"/>
                    <h1 className="dev-name">Nguyễn Minh Hiếu</h1>
                    <p className="dev-desc">Chúma hmề</p>
                </div>
                <div className="developer3">
                    <img src={dev3} alt="dev2" className="rounded-img"/>
                    <h1 className="dev-name">Nguyễn Khải Hoàn</h1>
                    <p className="dev-desc">Kẻ hủy diệt Frontend</p>
                </div>
            </div>
            <Navbar className='navbar'
             isOpen={isFormOpened}
             handleLoginClick={handleOpenForm}
             handleOutsideClick={handleCloseForm}
            />
        </div>
    );
}

export default Developers;