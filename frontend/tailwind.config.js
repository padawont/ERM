// tailwind.config.js
module.exports = {
    content: [
        './pages/**/*.{vue,js}',
        './components/**/*.{vue,js}',
        './layouts/**/*.{vue,js}',
        './plugins/**/*.{vue,js}',
        './nuxt.config.{js,ts}',
    ],
    theme: {
        extend: {
            colors: {
                primary: '#ff5733',
            },
        },
    },
    plugins: [],
};
