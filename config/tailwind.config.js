const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
	safelist: [
		{
			pattern: /(bg|text)-(red|orange|teal|blue|indigo|slate)-(8|9)00/,
			variants: [ 'hover' ],
		},
		{
			pattern: /ring-(red|orange|teal|blue|indigo|slate)-700/,
		},
		{
			pattern: /border-(red|orange|teal|blue|indigo|slate)-800/,
		},
	],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
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
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
