import React from "react";
import { Radar } from "react-chartjs-2";
import "chartjs-plugin-datalabels";
import "./PieChart.css";

function PieChart({ chartData, chartOptions }) {
    return (
        <div className="pie-chart-container">
            <Radar data={chartData} options={chartOptions} />
        </div>
    );
}

export default PieChart;
