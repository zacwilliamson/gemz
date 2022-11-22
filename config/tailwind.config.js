const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],

  darkMode: 'class',
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },

  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
  ],

  theme: {
    extend: {
      colors: {
      'dm-1': '#0c1116',
      'dm-2': '#141b20',
      'dm-text-2': 'c8d1d8',
      'lm-1': '#f2f5f6',
      'lm-2': '#ffffff',
      'lm-text-2': 'c8d1d8',
      },
    }
  }
}
