import React, {useState} from 'react';
import './Timeline.css';
import moment from 'moment';

function Timeline({pair, vehicle}) {
    const [modal, setModal] = useState(false);

    const triggerModal = () => {
        setModal(!modal);
    };

    return (
        <div>
            <div className='infor-container'>
            <div className='layout'>
                <div className='infor-header'>
                    <div className='textDiv'>
                        <h2 className='title'>Thông tin đăng kiểm</h2>
                        <hr />
                        <p>Nơi hiển thị thông tin lịch sử đăng kiểm sau khi xác nhận các thông tin trên</p>
                    </div>
                </div>
            </div>
        </div>
        <div className="timeline-container">
            <nav className="tmln tmln--box">
                <ul className="tmln__list">
                    {pair.sort((a, b) => moment(b.inspection.inspection_date) - moment(a.inspection.inspection_date)).map((info) => {
                        const year = moment(info.inspection.inspection_date).format("YYYY");
                        const time = moment(info.inspection.inspection_date).format("DD/MM/YYYY");
                        const stationName = info.station.station_name;
                        const stationAddress = info.station.station_address;
                        const stationStatus = info.station.station_status;
                        const brand = vehicle.brand;
                        const inspectionID = info.inspection.inspection_id;
                        const province = info.station.province;
                        const stationManager = info.station.station_manager;
                        return (
                            <li className="tmln__item">
                            <h3 className="tmln__item-headline">{year}</h3>
                            <div className='tmln__description'>
                                Thời gian: {time}<br />
                                Tên trung tâm: {stationName}<br/>
                                Địa điểm: {stationAddress}<br />
                                Kết quả đăng kiểm: <span className="true">{stationStatus ? <i className='bx bxs-check-circle' style={{"color": "#00FF7F"}}></i> : <i className='bx bxs-x-circle' style={{"color": "#FF4500"}}></i>}</span>
                            </div>
                            <a href='#' className="tmln__description nav-link" onClick={triggerModal}>
                                <div>Xem thông tin <span className="nav-text">&#8594;</span></div>
                                {modal && (
                                    <div>
                                    <div className="popup-history">
                                      <div onClick={triggerModal} className="overlay-history"></div>
                                      <div className="modal-content-history">
                                        <form className='form-history'>
                                        <div class="card">
                                            <div class="left-column background1-left-column">
                                                    <h6>Hệ thống đăng kiểm</h6>
                                                    <h2>Tra cứu</h2>
                                                    <i class="fa fa-github"></i>
                                                </div>

                                                <div class="right-column">
                                                    <div>
                                                        <h4 className='title-history'>Thông tin cơ bản</h4>
                                                    </div>
                                                    <p>1. Mã số đăng kiểm: <span className="bigger">{inspectionID}</span></p>
                                                    <p>2. Người sở hữu: <span className="bigger">Hoàng Đức Chinh</span></p>
                                                    <p>3. Ngày đăng kiểm: <span className="bigger">{time}</span></p>
                                                    <p>4. Nhãn: <span className="bigger">{brand}</span></p>
                                                    <p>5. Loại: <span className="bigger">Ô tô con</span></p>
                                                    <p>6. Trung tâm: <span className="bigger">{stationName}</span></p>
                                                    <p>7. Quản lý: <span className="bigger">{stationManager}</span></p>
                                                    <p>8. Tỉnh: <span className="bigger">{province}</span></p>
                                                </div>
                                            </div>
                                        </form>
                                      </div>
                                    </div>
                                  </div>
                                )}
                            </a>
                            </li>
                        );
                        })}
                </ul>
            </nav>
        </div>
        </div>
    );
}

export default Timeline;