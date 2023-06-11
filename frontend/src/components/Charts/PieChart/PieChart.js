import React from "react";
import { Doughnut } from "react-chartjs-2";
import "chartjs-plugin-datalabels";
import "./PieChart.css";

function PieChart({ chartData, chartOptions }) {
    const chartPlugins = {
        maintainAspectRatio: false,
        responsive: true,
        plugins: {
            datalabels: {
                align: "end",
                anchor: "end", // Đặt anchor là "end" để label nằm ở bên phải
                offset: 20,
            },
        },
    };

    const options = {
        ...chartOptions,
        ...chartPlugins,
        legend: {
            position: "right", // Đặt label ở bên phải
            align: "start",
        },
    };

    return (
        <div className="pie-chart-container">
            <Doughnut data={chartData} options={chartPlugins} />
        </div>
    );
}

export default PieChart;
