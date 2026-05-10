# Product Images Guide

## Image Placeholder Explanation

The catalog comes with **8 default products** that use placeholder image paths:

```
/products/tree-1.png
/products/tree-2.png
/products/tree-3.png
/products/tree-4.png
/products/tree-5.png
/products/tree-6.png
/products/tree-7.png
/products/tree-8.png
```

## How to Add Real Images

### Method 1: Local Images (Recommended)

1. **Create the products folder**:
   ```
   public/
   └── products/
       ├── tree-1.png
       ├── tree-2.png
       ├── tree-3.png
       └── ...
   ```

2. **Add your images**:
   - Copy your tree images to `public/products/`
   - Rename them to match the paths in the catalog
   - Or update the paths in the editor

3. **Image requirements**:
   - **Format**: PNG, JPG, or WebP
   - **Recommended size**: 800x1200px (portrait)
   - **Aspect ratio**: 3:4 or similar
   - **File size**: Under 500KB each
   - **Background**: Transparent PNG or clean white/black background

### Method 2: External URLs

1. **Upload images to a CDN or image host**:
   - Cloudinary
   - ImgBB
   - Your own server
   - Any image hosting service

2. **Update image paths in editor**:
   - Open Editor → Products tab
   - Click edit on a product
   - Change image path to full URL
   - Example: `https://cdn.example.com/images/olive-tree.jpg`

### Method 3: Base64 (Not Recommended for Large Images)

You can use base64-encoded images directly in the image field, but this is only suitable for small images.

## Image Fallback System

The website has a **built-in fallback system**:

- If an image fails to load, a gray placeholder appears
- This ensures the layout never breaks
- You'll see "Product Image" text on failed images

## Recommended Image Specifications

### For Best Visual Quality:

| Property | Recommended | Acceptable |
|----------|-------------|------------|
| Width | 800-1200px | 600-1600px |
| Height | 1200-1800px | 900-2400px |
| Format | PNG | JPG, WebP |
| Background | Transparent or solid | Any |
| File Size | 200-400KB | 100KB-1MB |
| Color Profile | sRGB | Any |

### Image Naming Convention:

Use clear, descriptive names:
```
✅ Good:
- olive-tree-mediterranean-001.png
- bonsai-imperial-002.jpg
- palm-royal-date-003.png

❌ Avoid:
- IMG_1234.jpg
- photo.png
- tree.jpg
```

## Creating Professional Product Photos

### Photography Tips:

1. **Clean Background**: White, black, or transparent
2. **Good Lighting**: Soft, even lighting from multiple angles
3. **Center the Product**: Tree should be centered and fill the frame
4. **Show Details**: Capture trunk texture and foliage clearly
5. **Consistent Style**: All products should have similar photography style

### Quick Photo Editing:

1. **Remove Background**: Use tools like:
   - remove.bg
   - Photoshop
   - GIMP (free)
   - Canva

2. **Adjust Colors**: Enhance natural colors, avoid over-saturation

3. **Crop to Aspect Ratio**: Use 3:4 ratio for consistency

4. **Optimize File Size**: Use TinyPNG or similar tools

## Testing Images

After adding images:

1. **Check desktop view**: Images should look sharp and properly sized
2. **Check mobile view**: Images should load quickly and fit well
3. **Check both languages**: Images should work in AR and EN modes
4. **Check modal view**: Images should look good in the detail modal

## Image Loading Performance

To ensure fast loading:

### 1. Optimize Images:
```bash
# Use tools like:
- TinyPNG (web)
- ImageOptim (Mac)
- Squoosh (web)
```

### 2. Use Lazy Loading:
The website already implements lazy loading for images.

### 3. Consider WebP Format:
Modern format with better compression:
```
tree-1.webp  (smaller file size)
tree-1.png   (fallback for old browsers)
```

## Bulk Image Management

### Adding Multiple Products at Once:

1. Prepare all images in `public/products/` folder
2. Open Editor → Import / Export tab
3. Export current data
4. Edit JSON file with your image paths
5. Import the updated JSON

### Example JSON for Images:
```json
{
  "id": "1",
  "code": "OLV-001",
  "image": "/products/olive-tree-1.png",
  ...
}
```

## Troubleshooting

### Problem: Images not showing

**Solutions**:
1. Check browser console (F12) for errors
2. Verify image path is correct
3. Check file actually exists in `public/products/`
4. Try using full URL instead of relative path
5. Check file permissions

### Problem: Images loading slowly

**Solutions**:
1. Reduce image file size
2. Convert to WebP format
3. Use a CDN for image hosting
4. Compress images before uploading

### Problem: Images look blurry

**Solutions**:
1. Use higher resolution source images
2. Ensure images are at least 800px wide
3. Don't upscale small images
4. Use PNG for better quality

## Advanced: Using a CMS for Images

For easier image management, consider:

1. **Cloudinary**: Free tier, automatic optimization
2. **Imgix**: Real-time image processing
3. **Uploadcare**: Image CDN with editor
4. **AWS S3 + CloudFront**: Scalable solution

## Default Product Categories

Your 8 default products should represent:

1. **Olive Trees** (2-3 products)
2. **Bonsai Trees** (1-2 products)
3. **Palm Trees** (2-3 products)
4. **Bougainvillea** (1 product)
5. **Custom Trees** (1 product)

Make sure each category has representative images!

---

**Ready to add your luxury tree images! 🌲📸**
