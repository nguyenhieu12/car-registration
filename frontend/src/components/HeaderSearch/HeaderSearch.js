import React, { useState } from 'react';
import './HeaderSearch.css';
import Timeline from '../Timeline/Timeline';

function HeaderSearch(props) {
    const [input1, setInput1] = useState("");
    const [input2, setInput2] = useState("");

    const [pair, setPair] = useState([]);
    const [vehicle, setVehicle] = useState([]);

    const getHistoryInspections = async (value1, value2) => {
        const payload = {
            person_identity_number: value1,
            registration_id: value2,
        };
        fetch(`http://localhost:5000/api/v1/visitor`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(payload)
        })
            .then(response => response.json())
            .then(data => {
                setPair(data.data.pair);
                setVehicle(data.data.vehicle);
            })
            .catch(error => {
                console.error(error);
            });
    };

    const handleChange = () => {
        getHistoryInspections(input1, input2);
        scrollToTimeline();
    };

    const scrollToTimeline = () => {
        const timeline = document.getElementById('search-timeline');
        if (timeline) {
            timeline.scrollIntoView({ behavior: 'smooth', block: 'start' }); // Sửa lỗi tại đây
        }
    };

    return (
        <div>
            <div className='search-container'>
                <div className="layout">
                    <div className="layout-text">
                        <h1 className="title">
                            Tra cứu lịch sử đăng kiểm
                        </h1>
                        <p className="subTitle">
                            Nhập các trường thông tin Căn Cước Công Dân đối với cá nhân hoặc mã số thuế đối với doanh nghiệp và biển số xe
                        </p>
                    </div>
                    <div className="card">
                        <div className="cccdDiv">
                            <label htmlFor="cccd">
                                Nhập Căn Cước Công Dân hoặc Mã số thuế
                            </label>
                            <input type="text" placeholder="Ví dụ: 012345678910" onChange={(e) => setInput1(e.target.value)}></input>
                        </div>

                        <div className="carNumberDiv">
                            <label htmlFor="carNumber">
                                Nhập biển số xe
                            </label>
                            <input type="text" placeholder="Ví dụ: 12A-34567" onChange={(e) => setInput2(e.target.value)}></input>
                        </div>
                        <button className='btn' onClick={handleChange}>Tìm kiếm</button>
                    </div>
                </div>
            </div>
            <div id='search-timeline'>
                <Timeline pair={pair} vehicle={vehicle} />
            </div>
        </div>
    );
}

export default HeaderSearch;