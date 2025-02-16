<template>
    <h2 class=" text-xl text-green-500">History Risk</h2>
    <div class=" border border-green-500 m-4">

        <Line id="my-chart-id" :width="1100" :options="chartOptions" :data="chartData" />
    </div>
</template>

<script>
import { Line } from 'vue-chartjs'
import {
    Chart as ChartJS,
    Title,
    Tooltip,
    Legend,
    LineElement,
    PointElement,
    CategoryScale,
    LinearScale
} from 'chart.js'
import { faker } from '@faker-js/faker'

// Register necessary Chart.js components
ChartJS.register(Title, Tooltip, Legend, LineElement, PointElement, CategoryScale, LinearScale)

// Generate mock history data
let history_data = []
let labels = []

for (let i = 0; i < 30; i++) {
    labels.push(`Day ${i + 1}`)
    history_data.push(faker.number.int({ min: 1, max: 100 }));
}

export default {
    name: 'LineChart',
    components: { Line },
    data() {
        return {
            chartData: {
                labels: labels,
                datasets: [{
                    label: 'Risk Score',
                    data: history_data,
                    borderColor: 'blue',
                    backgroundColor: 'rgba(0, 0, 255, 0.2)', // Make background color visible
                    borderWidth: 2,
                    fill: true
                }]
            },
            chartOptions: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                        labels: {
                            color: 'white'
                        }
                    },
                    title: {
                        display: true,
                        text: 'History Risk',
                        color: 'white' // Fix title color
                    }
                },
                scales: { 
                    x: {
                        ticks: {
                            color: 'white'
                        },
                        grid: {
                            color: 'rgba(255, 255, 255, 0.2)' // Light white grid lines
                        }
                    },
                    y: {
                        ticks: {
                            color: 'white'
                        },
                        grid: {
                            color: 'rgba(255, 255, 255, 0.2)' // Light white grid lines
                        }
                    }
                }
            }
        }
    }
}
</script>

<style>
#my-chart-id {
    background-color: rgba(30, 30, 30, 1);
}
</style>
