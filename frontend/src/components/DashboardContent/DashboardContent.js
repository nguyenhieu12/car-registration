import React, { useEffect, useState} from 'react';
import './DashboardContent.css';
import BarChart from '../Charts/BarChart/BarChart';
import LineChart from '../Charts/LineChart/LineChart';
import PieChart from '../Charts/PieChart/PieChart';

function DashboardContent(props) {
    /**
     Test chart
     **/


    function getRandomInt(min, max) {
        return Math.floor(Math.random() * (max - min + 1) + min);
    }

    function generateRandomDates() {
        const currentDate = new Date();
        const currentYear = currentDate.getFullYear();
        const startDate = new Date('2022-01-01');

        const randomDates = [];

        for (let i = 0; i < 20; i++) {
            const randomYear = getRandomInt(2022, currentYear);
            const randomMonth = getRandomInt(0, 11);
            const randomDay = getRandomInt(1, 28);

            const randomDate = new Date(randomYear, randomMonth, randomDay);
            randomDates.push({
                day: randomDate.getDate(),
                month: randomDate.getMonth() + 1,
                year: randomDate.getFullYear()
            });
        }

        return randomDates;
    }

    const randomDateArray = generateRandomDates();

    function generateRandomColors() {
        const colors = [];

        for (let i = 0; i < 12; i++) {
            const color = "#" + Math.floor(Math.random() * 16777215).toString(16);
            colors.push(color);
        }

        return colors;
    }

    const randomColors = generateRandomColors();

    /**
     Test chart
     **/

    const token = localStorage.getItem('token');

    const [inspectionData, setInspectionData] = useState([]);
    const [selectedDateOption, setSelectedDateOption] = useState('month');
    const [selectedChartOption, setSelectedChartOption] = useState('bar');
    const [chartData, setChartData] = useState({
        labels: randomDateArray.map(data => data.year),
        datasets: [
            {
                label: "Số liệu thống kê",
                data: randomDateArray.map(data => data.month),
                // data: handleChartData(inspectionData, 'month'),
                backgroundColor: randomColors
            }
        ]
    });

    function handleChartData(inspectionData, selectedOption) {
        if (selectedOption === 'day') {
            return inspectionData.map(data => data.inspection_day);
        } else if (selectedOption === 'month') {
            return inspectionData.map(data => data.inspection_month);
        } else {
            return inspectionData.map(data => data.inspection_year);
        }
    }

    let inspectionDates = [];

    useEffect(() => {
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
                    inspectionDates = inspections.map(inspection => inspection.inspection_date);

                    console.log(inspectionDates);
                } else {
                    console.log('Error:', response.status);
                }
            } catch (error) {
                console.error('Error:', error);
            }

        };

        fetchData();
    }, [selectedDateOption]);

    const handleDateSelectChange = (event) => {
        setSelectedDateOption(event.target.value);
    };

    const handleChartSelectChange = (event) => {
        setSelectedChartOption(event.target.value);
    };

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

    const testGetStation = async () => {
        try {
            const response = await fetch('http://localhost:5000/api/v1/insp/all', {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                    Authorization: `Bearer ${token}`,
                },
            });

            const data = await response.json();
            const inspections = data.data.inspections;
            console.log(inspections);
            const formattedData = inspections.map((item) => ({
                inspection_id: item.inspection_id,
                registration_id: item.registration_id,
                inspection_day: new Date(item.inspection_date).getDay(),
                inspection_month: new Date(item.inspection_date).getMonth() + 1,
                inspection_year: new Date(item.inspection_date).getFullYear(),
                expiry_date: item.expiry_date,
                station_code: item.station_code
            }));
            setInspectionData(formattedData);
        } catch (error) {
            console.log(error);
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
            </div>
            {/*<button onClick={testGetStation}>Get station</button>*/}
            {/*<BarChart chartData={chartData} chartOptions={ptions}/>*/}
            {/*<LineChart chartData={chartData} chartOptions={chartOptions}/>*/}
            {/*<PieChart chartData={chartData} chartOptions={chartOptions}/>*/}
            {selectedChartOption === 'bar' ? <BarChart chartData={chartData} chartOptions={options}/>
                : (selectedChartOption === 'line' ? <LineChart chartData={chartData} chartOptions={options}/>
                : <PieChart chartData={chartData} chartOptions={options}/>)}
        </div>
    );
}

export default DashboardContent;
