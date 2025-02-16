<template>
    <h2 class="text-xl text-green-500">Risk</h2>
    <div class="">
        <Doughnut :data="chartData" :options="chartOptions" />
    </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';
import { Doughnut } from 'vue-chartjs';
import {
    Chart as ChartJS,
    Title,
    Tooltip,
    Legend,
    ArcElement,
    CategoryScale,
    DoughnutController
} from 'chart.js';
import annotationPlugin from 'chartjs-plugin-annotation';
import ChartDataLabels from 'chartjs-plugin-datalabels';
import { faker } from '@faker-js/faker';

// Register required Chart.js components
ChartJS.register(Title, Tooltip, Legend, ArcElement, CategoryScale, DoughnutController, annotationPlugin, ChartDataLabels);

let risk = faker.number.int({ min: 0, max: 100 });
const COLORS = ['rgb(140, 214, 16)', 'rgb(239, 198, 0)', 'rgb(231, 24, 49)'];
const getColorIndex = (percentage: number) => (percentage < 70 ? 0 : percentage < 90 ? 1 : 2);

const chartData = computed(() => ({
    labels: ['Risk', 'Remaining'],
    datasets: [{
        data: [risk, 100 - risk],
        backgroundColor: [COLORS[getColorIndex(risk)], 'rgb(234,234,234)'],
        borderWidth: 0
    }]
}));

const chartOptions = computed(() => ({
    aspectRatio: 2,
    circumference: 180,
    rotation: -90,
    cutout: '70%',
    responsive: true,
    maintainAspectRatio: false,
    plugins: {
        annotation: {
            annotations: {
                centerLabel: {
                    type: 'label',
                    content: [`${risk} %`, 'Risk'],
                    xValue: 'center',
                    yValue: 'center',
                    yAdjust: 20, // Moves the text slightly downward
                    textAlign: 'center',
                    font: {
                        size: 30,
                        weight: 'bold',
                    },
                    color: COLORS[getColorIndex(risk)],
                }
            }
        },
        legend: { display: false },
        tooltip: { enabled: false },
        datalabels: {
            display: false,
        }
    }
}));

</script>
