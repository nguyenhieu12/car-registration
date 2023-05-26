import React from 'react';
import './Timeline.css';

function Timeline(props) {
    return (
        <div className="timeline-container">
            <nav className="tmln tmln--box">
                <ul className="tmln__list">
                    <li className="tmln__item">
                        <h3 className="tmln__item-headline">2023</h3>
                        <div className='tmln__description'>Thời gian: 26/5/2023 <br />
                            Địa điểm: TTDK XCG 1101S - Cao Bằng<br />
                            Kết quả đăng kiểm: <span className="false"></span>
                        </div>
                        <a href='#' class="tmln__description nav-link">
                            <div>Xem chi tiết <span class="nav-text">&#8594;</span>
                            </div>
                        </a>
                    </li>
                    <li className="tmln__item">
                        <h3 className="tmln__item-headline">2023</h3>
                        <div className='tmln__description'>Thời gian: 26/5/2023 <br />
                            Địa điểm: TTDK XCG 1101S - Cao Bằng<br />
                            Kết quả đăng kiểm: <span className="true"></span>
                        </div>
                        <a href='#' class="tmln__description nav-link">
                            <div>Xem chi tiết <span class="nav-text">&#8594;</span>
                            </div>
                        </a>
                    </li>
                    <li className="tmln__item">
                        <h3 className="tmln__item-headline">2023</h3>
                        <div className='tmln__description'>Thời gian: 26/5/2023 <br />
                            Địa điểm: TTDK XCG 1101S - Cao Bằng<br />
                            Kết quả đăng kiểm: <span className="true"></span>
                        </div>
                        <a href='#' class="tmln__description nav-link">
                            <div>Xem chi tiết <span class="nav-text">&#8594;</span>
                            </div>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
    );
}

export default Timeline;