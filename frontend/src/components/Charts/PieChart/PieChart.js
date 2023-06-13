import React from "react";
import { Pie } from "react-chartjs-2";
import "chartjs-plugin-datalabels";
import "./PieChart.css";

function PieChart({ chartData, chartOptions }) {
    return (
        <div className="pie-chart-container">
            <Pie data={chartData} options={chartOptions} />
        </div>
    );
}

export default PieChart;
