import React from "react";
import { Doughnut } from "react-chartjs-2";
import "chartjs-plugin-datalabels";
import "./PieChart.css";

function PieChart({ chartData, chartOptions }) {
    return (
        <div className="pie-chart-container">
            <Doughnut data={chartData} options={chartOptions} />
        </div>
    );
}

export default PieChart;
