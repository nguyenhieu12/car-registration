import React from "react";
import { Line } from "react-chartjs-2";
import {} from 'chart.js/auto';
import './LineChart.css';

function LineChart({ chartData, chartOptions }) {
    return(
        <div className='line-chart-container'>
            <Line data={chartData} options={chartOptions}/>
        </div>
    );
}

export default LineChart;