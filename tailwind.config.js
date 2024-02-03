/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
			colors: {
					'indigo': '#aaffaa',
			},
    extend: {
      keyframes: {
        wobble: {
          '0%': { transform: 'rotate(0deg)' },
          '20%': { transform: 'rotate(30deg)' },
          '40%': { transform: 'rotate(-30deg)' },
          '50%': { transform: 'rotate(10deg)' },
          '60%': { transform: 'rotate(-10deg)' },
          '65%': { transform: 'rotate(5deg)' },
          '70%': { transform: 'rotate(-5deg)' },
          '73%': { transform: 'rotate(0deg)' },
          '100%': { transform: 'rotate(0deg)' },
        },
      },
      animation: {
        wiggle: 'wobble 1s linear infinite',
      },
    },
  },
  plugins: [],
}

