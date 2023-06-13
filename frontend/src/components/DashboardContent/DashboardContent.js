import React, { useLayoutEffect, useState} from 'react';
import './DashboardContent.css';
import BarChart from '../Charts/BarChart/BarChart';
import LineChart from '../Charts/LineChart/LineChart';
import PieChart from '../Charts/PieChart/PieChart';
import 'boxicons/css/boxicons.min.css';

function DashboardContent(props) {
    const token = localStorage.getItem('token');

    const [selectedStatisticalOption, setSelectedStatisticalOption] = useState('cars');

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

    const carsByYears = async () => {
        try {
            const response = await fetch('http://localhost:5000/api/v1/insp/all?size=3273&orderBy=inspection_date', {
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
                                borderWidth: 0.5,
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

    const carsByQuarters = async () => {
        try {
            const response = await fetch('http://localhost:5000/api/v1/insp/statistic/all', {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                    Authorization: `Bearer ${token}`,
                },
            });

            if (response.ok) {
                const responseData = await response.json();
                const data = responseData.data;

                setChartData(
                    {
                        labels: ['Quý 1', 'Quý 2', 'Quý 3', 'Quý 4'],
                        datasets: data.map((item) => ({
                            label: item.year.toString(),
                            data: Object.values(item.cars_count),
                            backgroundColor: generateRandomColors(4),
                        })),
                    }
                );
            } else {
                console.log('Error:', response.status);
            }
        } catch (error) {
            console.error('Error:', error);
        }
    };

    const carsByRegions = async () => {
        try {
            const response = await fetch('http://localhost:5000/api/v1/insp/statistic/region', {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                    Authorization: `Bearer ${token}`,
                },
            });

            if (response.ok) {
                const responseData = await response.json();
                const data = responseData.data;
                console.log(data);

                setChartData(
                    {
                        labels: ['Miền Bắc', 'Miền Trung', 'Miền Nam'],
                        datasets: data.map((item) => ({
                            label: item.year.toString(),
                            data: Object.values(item.cars_count_region),
                            backgroundColor: generateRandomColors(4),
                        })),
                    }
                );
            } else {
                console.log('Error:', response.status);
            }
        } catch (error) {
            console.error('Error:', error);
        }
    };

    useLayoutEffect(() => {

        if (selectedStatisticalOption === 'cars') {
            carsByYears();
        } else if (selectedStatisticalOption === 'quarters') {
            carsByQuarters();
        } else {
            carsByRegions();
        }

    }, [selectedStatisticalOption]);

    const handleStatisticalSelectChange = (event) => {
        setSelectedStatisticalOption(event.target.value);
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
            title: {
                display: true,
                align: 'end'
            }
        }
    };

    return (
        <div className="dashboard-content">
            <div className='stats-container'>
                <div className="stats-option by-cars">
                    <span>Thống kê theo</span>
                    <select value={selectedStatisticalOption} onChange={handleStatisticalSelectChange}>
                        <option value="cars">Tổng lượng xe</option>
                        <option value="quarters">Quý</option>
                        <option value="regions">Miền</option>
                    </select>
                </div>
                <div className="stats-option by-chart">
                    <span>Loại biểu đồ</span>
                    <select value={selectedChartOption} onChange={handleChartSelectChange}>
                        <option value="bar">Cột</option>
                        <option value="line">Đường</option>
                        <option value="pie">Tròn</option>
                    </select>
                </div>
                <div className='stats-quantity car-inspection'>
                    <div className='bx bx-car stats-icon'></div>
                    <div className='stats-content'>
                        <h3>{carInspection}</h3>
                        <p>Xe đã đăng kiểm</p>
                    </div>
                </div>
                <div className='stats-quantity car-expiry'>
                    <div className='bx bx-time-five stats-icon'></div>
                    <div className='stats-content'>
                        <h3>{carExpiry}</h3>
                        <p>Xe sắp đến hạn</p>
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