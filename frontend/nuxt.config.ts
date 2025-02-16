// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2024-11-01',
  devtools: { enabled: true },

  build: {

  },

  css: ['@/assets/css/tailwind.css'],
  modules: ['@nuxtjs/tailwindcss', 'nuxt-echarts'],

  runtimeConfig: {
    echarts: {
      charts: ['BarChart', 'LineChart', 'PieChart', 'GaugeChart', 'HeatmapChart', 'MapChart', 'GeoChart'],
      components: ['DatasetComponent', 'GridComponent', 'TooltipComponent'],
      features: ['LabelLayout', 'UniversalTransition']
    },
  }
})