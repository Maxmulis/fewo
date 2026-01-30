/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  plugins: [
    require('daisyui'),
  ],
  daisyui: {
    themes: [
      {
        light: {
          ...require("daisyui/src/theming/themes")["light"],
          primary: "#3b82f6",
          "primary-focus": "#2563eb",
          "primary-content": "#ffffff",
        },
      },
    ],
    base: true,
    styled: true,
    utils: true,
  },
}
