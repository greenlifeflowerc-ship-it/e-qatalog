/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        'deep-black': '#050505',
        'rich-black': '#0B0B0B',
        'charcoal-black': '#111111',
        'emerald-black': '#08140F',
        'luxury-gold': '#D6AA32',
        'champagne-gold': '#F2D27A',
        'antique-gold': '#9E7724',
        'warm-ivory': '#F7EFE0',
        'muted-beige': '#B9A987',
      },
      fontFamily: {
        'sans': ['Inter', 'system-ui', '-apple-system', 'sans-serif'],
        'arabic': ['Cairo', 'system-ui', '-apple-system', 'sans-serif'],
      },
      backgroundImage: {
        'radial-gold': 'radial-gradient(circle, rgba(214, 170, 50, 0.15) 0%, transparent 70%)',
        'radial-dark': 'radial-gradient(circle at center, #0B0B0B 0%, #050505 100%)',
      },
    },
  },
  plugins: [],
}
