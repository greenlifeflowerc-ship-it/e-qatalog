# Flower Center - Luxury Artificial Trees Catalog

A premium bilingual (Arabic/English) product catalog website with a built-in visual editor for managing artificial trees.

## ✨ Features

- **Bilingual Support**: Full Arabic and English language support with RTL/LTR layouts
- **Luxury Design**: Black and gold theme with cinematic animations
- **Built-in Visual Editor**: Manage products, edit text, and configure settings without touching code
- **Responsive Design**: Optimized for desktop, tablet, and mobile devices
- **Product Management**: Add, edit, delete, duplicate, and reorder products
- **Advanced Filtering**: Filter by category and search by name, code, or category
- **Product Modal**: Immersive full-screen product details with smooth animations
- **LocalStorage Persistence**: All changes are saved locally in the browser
- **Import/Export**: Export and import catalog data as JSON
- **WhatsApp Integration**: Direct inquiry buttons with pre-filled messages

## 🚀 Installation

### Prerequisites

- Node.js 18+ installed on your system
- npm or yarn package manager

### Quick Start

1. **Install dependencies**:
```bash
npm install
```

2. **Start the development server**:
```bash
npm run dev
```

3. **Open your browser**:
Navigate to `http://localhost:5173`

## 📦 Tech Stack

- **React 18** - UI library
- **TypeScript** - Type safety
- **Vite** - Build tool and dev server
- **Tailwind CSS** - Utility-first styling
- **Framer Motion** - Advanced animations
- **Lucide React** - Icon library

## 🎨 Editor Access

To access the visual editor:

1. Click the "Editor" button in the navigation bar
2. **Login with Supabase Auth**:
   - Email: Your admin email
   - Password: Your admin password
3. Start managing your catalog!

### Admin Setup

The editor uses **Supabase Authentication** for secure access. To set up admin access:

1. **Run the SQL schema**: Execute `supabase-admin-auth.sql` in your Supabase project
2. **Create admin user**: Sign up via Supabase Auth
3. **Add to admin_profiles**: Insert your user into the `admin_profiles` table

See **ADMIN-AUTH-GUIDE.md** for detailed setup instructions.

### Editor Features

- **Page Text Tab**: Edit hero section headlines and button text in both languages
- **Products Tab**: Add, edit, delete, duplicate, and reorder products
- **Settings Tab**: Toggle product codes, dimensions, featured products sorting
- **Import/Export Tab**: Backup and restore your catalog data

## 🖼️ Adding Product Images

Product images are referenced by path. To add your own images:

1. Place your images in the `public/products/` folder
2. Update the image path in the editor (e.g., `/products/tree-1.png`)
3. Or use external URLs (e.g., `https://example.com/image.jpg`)

## 🌐 Language Switching

Click the AR/EN toggle in the navbar to switch between:
- **English** (LTR layout)
- **Arabic** (RTL layout)

All product data, UI text, and layouts automatically adapt.

## 💾 Data Persistence

All catalog data is saved to browser LocalStorage:
- Products
- Page content
- Settings
- Language preference

**Note**: Clearing browser data will reset the catalog to default.

## 📱 WhatsApp Integration

Update the phone number in the code:

Search for `https://wa.me/971000000000` and replace with your number:
```
https://wa.me/YOUR_COUNTRY_CODE_AND_NUMBER
```

Example: `https://wa.me/971501234567`

## 🎯 Customization

### Colors

Edit colors in `tailwind.config.js`:
```js
colors: {
  'luxury-gold': '#D6AA32',
  'deep-black': '#050505',
  // ... more colors
}
```

### Default Products

Edit default product data in `src/data/defaultProducts.ts`

### Translations

Add or modify translations in `src/data/translations.ts`

## 🏗️ Build for Production

```bash
npm run build
```

Built files will be in the `dist/` folder, ready for deployment.

## 📂 Project Structure

```
src/
├── components/          # React components
│   ├── Navbar.tsx
│   ├── Hero.tsx
│   ├── ProductGrid.tsx
│   ├── ProductCard.tsx
│   ├── ProductDetailModal.tsx
│   ├── FilterBar.tsx
│   ├── SearchBar.tsx
│   ├── EditorPanel.tsx
│   ├── ProductEditorForm.tsx
│   ├── PageTextEditor.tsx
│   ├── ConfirmDialog.tsx
│   └── FloatingCatalogButton.tsx
├── data/               # Static data
│   ├── defaultProducts.ts
│   ├── defaultContent.ts
│   └── translations.ts
├── hooks/              # Custom React hooks
│   ├── useCatalogStorage.ts
│   ├── useLanguage.ts
│   └── useBodyScrollLock.ts
├── types/              # TypeScript types
│   └── catalog.ts
├── utils/              # Utility functions
│   └── cn.ts
├── App.tsx             # Main app component
├── main.tsx            # Entry point
└── index.css           # Global styles
```

## 🎬 Animations

The website features cinematic animations powered by Framer Motion:
- Hero entrance animations
- Product card staggered reveals
- Gold sweep effects
- Modal transitions with layoutId morphing
- Floating elements
- Smooth page transitions

## 🔒 Security

The catalog uses **Supabase Authentication** for secure admin access:

- **Email/Password Authentication**: Passwords hashed and secured by Supabase
- **Row Level Security (RLS)**: Database-level access control
- **Admin Profiles**: Only users in `admin_profiles` table with `is_active=true` can access editor
- **Session Management**: Secure session handling via Supabase Auth
- **No Hardcoded Passwords**: All credentials managed through Supabase

For production:
- Enable email verification in Supabase
- Set up password recovery
- Configure CORS in Supabase settings
- Use environment variables for sensitive data
- Monitor authentication logs

See **ADMIN-AUTH-GUIDE.md** for complete security setup.

## 🌟 Design Philosophy

This catalog is designed to feel like a luxury architectural showcase, not a typical ecommerce website. The black and gold color scheme, cinematic animations, and premium typography create an upscale experience suitable for high-end artificial trees used in:

- Luxury hotels
- Corporate headquarters
- Shopping malls
- High-end villas
- Architectural projects

## 📄 License

All rights reserved © 2024 Flower Center

## 🤝 Support

For questions or support, contact via WhatsApp (update the number in the code).

---

**Made with ❤️ for luxury artificial trees**
