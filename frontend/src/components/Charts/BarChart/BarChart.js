import React from "react";
import { Bar } from "react-chartjs-2";
import {} from 'chart.js/auto';
import './BarChart.css';

function BarChart({ chartData, chartOptions }) {
    return(
      <div className='bar-chart-container'>
          <Bar data={chartData} options={chartOptions}/>
      </div>
    );
}

export default BarChart;