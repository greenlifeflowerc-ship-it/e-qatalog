# Quick Start Guide

## Step 1: Install Dependencies

Open your terminal in the project folder and run:

```bash
npm install
```

This will install all required packages:
- React & React DOM
- TypeScript
- Vite
- Tailwind CSS
- Framer Motion
- Lucide React icons

## Step 2: Start Development Server

```bash
npm run dev
```

The website will be available at: **http://localhost:5173**

## Step 3: Access the Editor

1. Open the website in your browser
2. Click the **"Editor"** button in the navigation bar
3. Enter password: **admin123**
4. You can now:
   - Edit page text (hero headlines, buttons)
   - Add/edit/delete products
   - Change settings
   - Import/export catalog data

## Step 4: Add Your Own Product Images

The default products use placeholder image paths like `/products/tree-1.png`.

To add real images:

### Option 1: Local Images
1. Create a `public/products/` folder
2. Add your images (tree-1.png, tree-2.png, etc.)
3. Images will automatically load

### Option 2: External URLs
1. Upload images to any image hosting service
2. In the editor, set the image path to the full URL
3. Example: `https://example.com/images/tree.jpg`

## Step 5: Customize Content

### Edit Text Content
- Click **Editor** → **Page Text** tab
- Edit hero headlines in English and Arabic
- Edit button text
- Click **Save Changes**

### Manage Products
- Click **Editor** → **Products** tab
- Click **Add New Product** to add a product
- Click the edit icon to modify existing products
- Click the trash icon to delete products
- Use up/down arrows to reorder products

### Configure Settings
- Click **Editor** → **Settings** tab
- Toggle product codes display
- Toggle dimensions display
- Enable/disable featured products first
- Select hero featured product

## Step 6: Test Both Languages

Click the **AR / EN** toggle in the navbar to switch between:
- **English** (left-to-right layout)
- **Arabic** (right-to-left layout)

All text and layouts automatically adapt!

## Step 7: Export Your Data

To backup your catalog:

1. Click **Editor** → **Import / Export** tab
2. Click **Export JSON**
3. A JSON file will download with all your data
4. Keep this file safe!

## Step 8: Build for Production

When ready to deploy:

```bash
npm run build
```

This creates a `dist/` folder with optimized files ready for hosting.

## Common Issues & Solutions

### Issue: Images not loading
**Solution**: Check that image paths are correct. Use browser DevTools (F12) → Console to see errors.

### Issue: Changes not saving
**Solution**: Click the **Save Changes** button in the editor. Check that LocalStorage is enabled in your browser.

### Issue: Editor password not working
**Solution**: Make sure you're typing exactly: `admin123` (lowercase, no spaces)

### Issue: Layout broken in Arabic mode
**Solution**: Clear browser cache and refresh. Check that all components support RTL.

### Issue: Port 5173 already in use
**Solution**: Close other Vite instances or run `npm run dev -- --port 3000` to use a different port.

## Next Steps

### 1. Update WhatsApp Number
Search for `971000000000` in the code and replace with your number.

### 2. Customize Colors
Edit `tailwind.config.js` to change the color scheme.

### 3. Add More Categories
Edit the filter list in `src/components/FilterBar.tsx`.

### 4. Add More Languages
Extend the `translations.ts` file with additional languages.

### 5. Deploy to Web
Upload the `dist/` folder to:
- Vercel
- Netlify
- GitHub Pages
- Any web hosting service

## Need Help?

- Check the main README.md for detailed documentation
- Review the code comments in each component
- Test in both languages (AR/EN) before deploying
- Make regular backups using the Export feature

---

**Enjoy your luxury catalog! 🌳✨**
