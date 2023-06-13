import React, { useState } from 'react';
import './Timeline.css';
import moment from 'moment';

function Timeline({ pair, vehicle }) {
  const [currentIndex, setCurrentIndex] = useState(0);
  const [modal, setModal] = useState(false);

  const triggerModal = (index) => {
    setCurrentIndex(index);
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
              <p>
                Nơi hiển thị thông tin lịch sử đăng kiểm sau khi xác nhận các thông tin trên
              </p>
            </div>
          </div>
        </div>
      </div>
      <div className='timeline-container'>
        <nav className='tmln tmln--box'>
          <ul className='tmln__list'>
            {pair.map((info, index) => {
              const tmp_year = moment(info.inspection.inspection_date).format('YYYY');
              const tmp_time = moment(info.inspection.inspection_date).format('DD/MM/YYYY');
              const tmp_stationName = info.station.station_name;
              const tmp_stationAddress = info.station.station_address;
              const tmp_stationStatus = info.station.station_status;

              return (
                <li className='tmln__item' key={index}>
                  <h3 className='tmln__item-headline'>{tmp_year}</h3>
                  <div className='tmln__description'>
                    Thời gian: {tmp_time}
                    <br />
                    Tên trung tâm: {tmp_stationName}
                    <br />
                    Địa điểm: {tmp_stationAddress}
                    <br />
                    Kết quả đăng kiểm:{' '}
                    <span className='true'>
                      {tmp_stationStatus ? (
                        <i className='bx bxs-check-circle' style={{ color: '#00FF7F' }}></i>
                      ) : (
                        <i className='bx bxs-x-circle' style={{ color: '#FF4500' }}></i>
                      )}
                    </span>
                  </div>
                  <a
                    href='#'
                    className='tmln__description nav-link'
                    onClick={() => triggerModal(index)}
                  >
                    <div>
                      Xem thông tin <span className='nav-text'>&#8594;</span>
                    </div>
                    {modal && currentIndex === index && (
                      <div>
                        <div className='popup-history'>
                          <div onClick={() => triggerModal(index)} className='overlay-history'></div>
                          <div className='modal-content-history'>
                            <form className='form-history'>
                              <div className='card'>
                                <div className='left-column background1-left-column'>
                                  <h6>Hệ thống đăng kiểm</h6>
                                  <h2>Tra cứu</h2>
                                  <i className='fa fa-github'></i>
                                </div>

                                <div className='right-column'>
                                  <div>
                                    <h4 className='title-history'>Thông tin cơ bản</h4>
                                  </div>
                                  <p>
                                    1. Mã số đăng kiểm:{' '}
                                    <span className='bigger'>
                                      {pair[currentIndex].inspection.inspection_id}
                                    </span>
                                  </p>
                                  <p>
                                    2. Người sở hữu:{' '}
                                    <span className='bigger'>Hoàng Đức Chinh</span>
                                  </p>
                                  <p>
                                    3. Ngày đăng kiểm:{' '}
                                    <span className='bigger'>{tmp_time}</span>
                                  </p>
                                  <p>
                                    4. Nhãn: <span className='bigger'>{vehicle.brand}</span>
                                  </p>
                                  <p>
                                    5. Loại: <span className='bigger'>Ô tô con</span>
                                  </p>
                                  <p>
                                    6. Trung tâm:{' '}
                                    <span className='bigger'>
                                      {pair[currentIndex].station.station_name}
                                    </span>
                                  </p>
                                  <p>
                                    7. Quản lý:{' '}
                                    <span className='bigger'>
                                      {pair[currentIndex].station.station_manager}
                                    </span>
                                  </p>
                                  <p>
                                    8. Tỉnh:{' '}
                                    <span className='bigger'>
                                      {pair[currentIndex].station.province}
                                    </span>
                                  </p>
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
