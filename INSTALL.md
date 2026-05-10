# Installation Commands

Copy and paste these commands in order to set up your project.

## 🚀 Complete Setup from Scratch

### Step 1: Navigate to Project Folder
```bash
cd "c:\Users\green\Desktop\e qataloug"
```

### Step 2: Install Dependencies
```bash
npm install
```

**This installs:**
- react@^18.2.0
- react-dom@^18.2.0
- framer-motion@^11.0.0
- lucide-react@^0.344.0
- typescript@^5.2.2
- vite@^5.1.4
- @vitejs/plugin-react@^4.2.1
- tailwindcss@^3.4.1
- postcss@^8.4.35
- autoprefixer@^10.4.18

### Step 3: Start Development Server
```bash
npm run dev
```

**Expected output:**
```
  VITE v5.x.x  ready in xxx ms

  ➜  Local:   http://localhost:5173/
  ➜  Network: use --host to expose
  ➜  press h + enter to show help
```

### Step 4: Open in Browser
Open your browser and navigate to:
```
http://localhost:5173
```

## 📦 All Available Commands

### Development
```bash
# Start dev server with hot reload
npm run dev

# Start dev server on specific port
npm run dev -- --port 3000

# Start dev server and expose to network
npm run dev -- --host
```

### Build
```bash
# Build for production
npm run build

# Preview production build locally
npm run preview
```

### Other Commands
```bash
# Check for outdated packages
npm outdated

# Update packages
npm update

# Clear node_modules and reinstall
rm -rf node_modules package-lock.json
npm install
```

## 🔧 Troubleshooting Installation

### Issue: `npm: command not found`

**Solution:**
Install Node.js from https://nodejs.org/ (LTS version recommended)

Verify installation:
```bash
node --version
npm --version
```

### Issue: Permission errors on Windows

**Solution:**
Run PowerShell or Command Prompt as Administrator

### Issue: `EACCES` permission error

**Solution:**
```bash
# Fix npm permissions
npm config set prefix '~/.npm-global'
export PATH=~/.npm-global/bin:$PATH
```

### Issue: Installation freezes

**Solution:**
```bash
# Clear npm cache
npm cache clean --force

# Delete lock file and try again
rm package-lock.json
npm install
```

### Issue: `gyp ERR!` errors

**Solution:**
Some packages need build tools. On Windows:
```bash
# Install windows build tools
npm install --global windows-build-tools
```

### Issue: Conflicting dependencies

**Solution:**
```bash
# Use legacy peer deps
npm install --legacy-peer-deps
```

## 🌐 Port Already in Use?

If port 5173 is busy:

```bash
# Use a different port
npm run dev -- --port 3000

# Or kill the process using port 5173
# Windows:
netstat -ano | findstr :5173
taskkill /PID <PID> /F

# Mac/Linux:
lsof -ti:5173 | xargs kill -9
```

## 📁 Create Products Folder

To add real images:

```bash
# Windows PowerShell:
New-Item -ItemType Directory -Path "public\products" -Force

# Mac/Linux:
mkdir -p public/products
```

## 🎨 Verify Installation

After `npm run dev`, you should see:

✅ **Homepage with:**
- Black and gold theme
- Hero section with headline
- Language switcher (AR/EN)
- Navigation bar
- Floating "Request Catalog" button

✅ **Editor (password: admin123):**
- Page Text tab
- Products tab (8 default products)
- Settings tab
- Import/Export tab

## 🚨 Common First-Time Issues

### 1. White screen / blank page
**Check browser console (F12):**
- Look for error messages
- Check Network tab for failed requests

### 2. Styles not loading
**Solution:**
- Make sure `npm install` completed successfully
- Check that `index.css` exists
- Restart dev server

### 3. TypeScript errors
**Solution:**
```bash
# Reinstall TypeScript
npm install -D typescript @types/react @types/react-dom
```

### 4. Images showing placeholder
**Normal behavior!** 
Add real images to `public/products/` folder.

## 📱 Test on Mobile Device

### Option 1: Same Network
```bash
# Start with host flag
npm run dev -- --host

# Access from mobile using your computer's IP
# Example: http://192.168.1.100:5173
```

### Option 2: Use ngrok
```bash
# Install ngrok
npm install -g ngrok

# In another terminal:
ngrok http 5173

# Use the https URL provided
```

## 🎯 Quick Verification Checklist

After installation, verify:

- [ ] Dev server starts without errors
- [ ] Website loads at http://localhost:5173
- [ ] Can switch between AR and EN languages
- [ ] Can access editor with password admin123
- [ ] Can add/edit/delete products in editor
- [ ] Can save changes
- [ ] Product modal opens when clicking products
- [ ] Search and filter work
- [ ] Responsive on mobile (use Chrome DevTools)

## 💡 Tips for Smooth Development

### 1. Use Fast Refresh
Vite supports hot module replacement - changes appear instantly!

### 2. Keep Terminal Open
Watch for build errors and warnings in real-time.

### 3. Use Browser DevTools
- Console: See JavaScript errors
- Network: Check failed requests
- Elements: Inspect styling
- Application: Check LocalStorage

### 4. Test Both Languages
Always test Arabic (RTL) and English (LTR) modes.

### 5. Save Often
Click "Save Changes" in editor to persist data.

## 🎓 Learning Resources

- **React**: https://react.dev/
- **TypeScript**: https://www.typescriptlang.org/
- **Tailwind CSS**: https://tailwindcss.com/
- **Framer Motion**: https://www.framer.com/motion/
- **Vite**: https://vitejs.dev/

## ✅ You're Ready!

If all commands executed successfully, you now have:

✨ A fully functional luxury catalog website
✨ Bilingual support (AR/EN)
✨ Built-in visual editor
✨ Responsive design
✨ Premium animations
✨ LocalStorage persistence

**Start building your luxury tree catalog!** 🌳🎨

---

Need help? Check README.md for full documentation.
