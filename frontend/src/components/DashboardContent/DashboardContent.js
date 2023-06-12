import React, { useLayoutEffect, useState} from 'react';
import './DashboardContent.css';
import BarChart from '../Charts/BarChart/BarChart';
import LineChart from '../Charts/LineChart/LineChart';
import PieChart from '../Charts/PieChart/PieChart';
import 'boxicons/css/boxicons.min.css';

function DashboardContent(props) {
    const token = localStorage.getItem('token');

    const [selectedDateOption, setSelectedDateOption] = useState('year');

    const [selectedChartOption, setSelectedChartOption] = useState('bar');

    const [carInspection, setCarInspection] = useState(0);

    const [carExpiry, setCarExpiry] = useState(0);

    const [chartData, setChartData] = useState({
        labels: '',
        datasets: [
            {
                label: "Số lượng",
                data: '',
                backgroundColor: "red"
            }
        ]
    });

    const generateRandomColors = (number) => {
        const colors = [];

        for (let i = 0; i < number; i++) {
            const color = "#" + Math.floor(Math.random() * 16777215).toString(16);
            colors.push(color);
        }

        return colors;
    }



    useLayoutEffect(() => {
        const fetchData = async () => {
            try {
                const response = await fetch('http://localhost:5000/api/v1/insp/all?size=48&orderBy=inspection_date', {
                    method: 'GET',
                    headers: {
                        'Content-Type': 'application/json',
                        Authorization: `Bearer ${token}`,
                    },
                });

                if (response.ok) {
                    const data = await response.json();
                    const inspections = data.data.inspections;
                    const carData = inspections.reduce((result, inspection) => {
                        const inspectionYear = new Date(inspection.inspection_date).getFullYear();
                        const existingObj = result.find(obj => obj.year === inspectionYear);
                        if (existingObj) {
                            existingObj.car++;
                        } else {
                            result.push({ year: inspectionYear, car: 1 });
                        }
                        return result;
                    }, []);

                    setCarInspection(carData.reduce((cars, currentQuantity) => cars + currentQuantity.car, 0));

                    setCarExpiry(carData.reduce((cars, currentQuantity) =>
                        ((currentQuantity.year >= 2021 && currentQuantity.year < 2023) ? (cars + currentQuantity.car) : cars)
                    , 0));

                    setChartData(
                        {
                            labels: carData.map(data => data.year),
                            datasets: [
                                {
                                    label: "Số lượng",
                                    data: carData.map(data => data.car),
                                    backgroundColor: generateRandomColors(carData.length),
                                    borderWidth: 1,
                                    borderColor: "black"
                                }
                            ]
                        }
                    );
                } else {
                    console.log('Error:', response.status);
                }
            } catch (error) {
                console.error('Error:', error);
            }

        };

        fetchData();
    }, []);

    const handleDateSelectChange = (event) => {
        setSelectedDateOption(event.target.value);
    };

    const handleChartSelectChange = (event) => {
        setSelectedChartOption(event.target.value);
    };

    // chart options
    const options = {
        indexAxis: 'x',
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
            legend: {
                position: 'right'

            },
            title: {
                display: true,
                align: 'end'
            }
        }
    };

    return (
        <div className="dashboard-content">
            <div className='stats-container'>
                <div className="stats-option">
                    <span>Thống kê theo</span>
                    <select value={selectedDateOption} onChange={handleDateSelectChange}>
                        <option value="day">Ngày</option>
                        <option value="month">Tháng</option>
                        <option value="year">Năm</option>
                    </select>
                </div>
                <div className="stats-option">
                    <span>Loại biểu đồ</span>
                    <select value={selectedChartOption} onChange={handleChartSelectChange}>
                        <option value="bar">Cột</option>
                        <option value="line">Đường</option>
                        <option value="pie">Tròn</option>
                    </select>
                </div>
                <div className='stats-quantity car-inspection'>
                    <div className='bx bx-car stats-icon car-icon'></div>
                    <div className='stats-content'>
                        <h3>Xe đã đăng kiểm</h3>
                        <strong>{carInspection}</strong>

                    </div>
                </div>
                <div className='stats-quantity car-expiry'>
                    <div className='bx bx-time-five stats-icon time-icon'></div>
                    <div className='stats-content'>
                        <h3>Xe sắp đến hạn</h3>
                        <strong>{carExpiry}</strong>
                    </div>
                </div>
            </div>
            {selectedChartOption === 'bar' ? <BarChart chartData={chartData} chartOptions={options}/>
                : (selectedChartOption === 'line' ? <LineChart chartData={chartData} chartOptions={options}/>
                : <PieChart chartData={chartData} chartOptions={options}/>)}
        </div>
    );
}

export default DashboardContent;
