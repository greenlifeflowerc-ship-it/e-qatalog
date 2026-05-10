# Catalog System Setup Guide

## Overview

This catalog system has been updated to use:
- **Supabase** for product database storage
- **Cloudinary** for image hosting and management
- **Fixed category system** with 10 tree categories
- **Item number-based** organization (e.g., AT-9130)

## Features

### Categories (English / Arabic)
1. Bamboo / بامبو
2. Bougainvillea / بوغنفيليا
3. Bonsai / بونساي
4. Cherry Blossom / أزهار الكرز
5. Olive Trees / أشجار الزيتون
6. Ghaf Trees / أشجار الغاف
7. Ficus Trees / أشجار الفيكس
8. Lemon Trees / أشجار الليمون
9. Maple Trees / أشجار القيقب
10. Palm Trees / أشجار النخيل

### Image Organization
Images are uploaded to Cloudinary in category-based folders:
```
flower-center/products/
  ├── bamboo/
  ├── bougainvillea/
  ├── bonsai/
  ├── cherry-blossom/
  ├── olive-trees/
  ├── ghaf-trees/
  ├── ficus-trees/
  ├── lemon-trees/
  ├── maple-trees/
  └── palm-trees/
```

Each product image is named by its item number (e.g., AT-9130.jpg).

## Setup Instructions

### 1. Supabase Setup

#### Create Project
1. Go to [https://supabase.com](https://supabase.com)
2. Sign up or log in
3. Click "New Project"
4. Fill in project details
5. Wait for database to be ready

#### Run SQL Schema
1. Go to SQL Editor in Supabase dashboard
2. Create a new query
3. Copy and paste the contents of `supabase-schema.sql`
4. Click "Run" to execute the schema

#### Get API Credentials
1. Go to Project Settings > API
2. Copy your **Project URL** (looks like: `https://xxxxx.supabase.co`)
3. Copy your **anon public** key (starts with `eyJ...`)
4. Save these for the .env file

### 2. Cloudinary Setup

#### Create Account
1. Go to [https://cloudinary.com](https://cloudinary.com)
2. Sign up for a free account
3. Verify your email

#### Create Upload Preset
1. Go to Settings > Upload
2. Scroll to "Upload presets"
3. Click "Add upload preset"
4. Set the following:
   - **Signing Mode**: Unsigned
   - **Preset name**: Choose a name (e.g., `flower-center-products`)
   - **Folder**: Leave empty (will be set dynamically)
   - **Unique filename**: false (we use item numbers)
   - **Overwrite**: true (allows updating images)
5. Save preset

#### Get Credentials
1. Go to Dashboard
2. Copy your **Cloud name** (shown at the top)
3. Copy your **Upload preset name** (from step above)
4. Save these for the .env file

### 3. Environment Variables

1. Copy `.env.example` to `.env`:
   ```bash
   copy .env.example .env
   ```

2. Edit `.env` and fill in your values:
   ```env
   VITE_SUPABASE_URL=https://your-project.supabase.co
   VITE_SUPABASE_ANON_KEY=eyJhbG...your-key
   VITE_CLOUDINARY_CLOUD_NAME=your-cloud-name
   VITE_CLOUDINARY_UPLOAD_PRESET=flower-center-products
   ```

3. Save the file

### 4. Setup Admin Authentication

**Run the admin auth SQL schema:**

```bash
# File: supabase-admin-auth.sql
```

1. Go to Supabase Dashboard → SQL Editor
2. Paste the content of `supabase-admin-auth.sql`
3. Click "Run"

**Create your first admin:**

1. Sign up with your email via Supabase (Dashboard → Authentication → Invite User)
2. Get your user ID from `auth.users` table
3. Run this SQL:

```sql
INSERT INTO public.admin_profiles (id, email, full_name, role, is_active)
SELECT id, email, 'Your Name', 'admin', true
FROM auth.users
WHERE email = 'your-email@example.com';
```

See **ADMIN-AUTH-GUIDE.md** for detailed instructions.

### 5. Install Dependencies

```bash
npm install @supabase/supabase-js
```

### 6. Run the Application

```bash
npm run dev
```

## Using the Editor

### Accessing the Editor

1. Open the catalog in your browser
2. Click the "Editor" button in the navbar
3. **Login with Supabase Auth**:
   - Email: Your admin email (from `admin_profiles`)
   - Password: Your Supabase Auth password
4. If successful, the editor panel opens

### Adding a New Product

1. Login to the editor (see above)
2. Go to the "Products" tab
3. Click "Add Product"
4. Fill in the form:
   - **Item Number**: e.g., AT-9610 (will be auto-uppercase)
   - **Category**: Select from dropdown (auto-fills Arabic)
   - **Names**: Enter both English and Arabic
   - **Dimensions**: Height, Width, Pot (optional)
   - **Image**: Click "Upload Image" (must enter item number and category first)
   - **Descriptions**: Optional English and Arabic descriptions
5. Click "Save"

### Uploading Images

**Important**: You must enter the **Item Number** and select a **Category** before uploading an image.

The image will be uploaded to:
```
Cloudinary folder: flower-center/products/{category-folder}
Filename: {ITEM_NUMBER}
Full path: flower-center/products/olive-trees/AT-9130
```

**Supported formats**: PNG, JPG, JPEG, WEBP (max 5MB)

### Image Requirements

- Maximum size: 5MB
- Recommended resolution: 1200x1600px (3:4 aspect ratio)
- Use high-quality images with transparent or clean backgrounds
- Product should be centered in the image

## Filtering and Search

### Filtering
- Click category buttons to filter by tree type
- Shows product count per category
- Active filter highlighted in gold
- "All" shows all products

### Search
Search looks in:
- Item number (AT-9130)
- Product name (English & Arabic)
- Category (English & Arabic)
- Description (English & Arabic)

## Data Flow

### Without Supabase (Development)
- Products stored in LocalStorage
- Uses default products from `src/data/defaultProducts.ts`
- Perfect for testing and development

### With Supabase (Production)
1. Products loaded from Supabase on app start
2. Editor saves directly to Supabase
3. Images uploaded to Cloudinary
4. Image URLs saved to Supabase
5. Public catalog displays products from Supabase

## Troubleshooting

### "Supabase not configured" Error
- Check that `.env` file exists and has correct values
- Verify `VITE_` prefix is used (required for Vite)
- Restart dev server after changing .env

### Image Upload Fails
- Verify Cloudinary credentials in `.env`
- Check that upload preset is set to "Unsigned"
- Ensure item number and category are filled in
- Check image size (must be under 5MB)
- Verify image format (PNG, JPG, WEBP only)

### Products Not Showing
- Check Supabase SQL logs for errors
- Verify RLS policies are set correctly
- Check that `is_active` is TRUE for products
- Check browser console for errors

### Categories Not Matching
- Always select category from dropdown
- Arabic category is auto-filled
- Don't manually edit category fields

## Database Schema

### products Table

| Column | Type | Description |
|--------|------|-------------|
| id | UUID | Primary key |
| created_at | TIMESTAMPTZ | Auto-generated |
| updated_at | TIMESTAMPTZ | Auto-updated |
| item_number | TEXT | Unique (e.g., AT-9130) |
| name_en | TEXT | English name |
| name_ar | TEXT | Arabic name |
| category_en | TEXT | English category |
| category_ar | TEXT | Arabic category |
| height | TEXT | Product height |
| width | TEXT | Product width |
| pot | TEXT | Pot description |
| image_url | TEXT | Cloudinary secure_url |
| cloudinary_public_id | TEXT | For deletion/updates |
| description_en | TEXT | English description |
| description_ar | TEXT | Arabic description |
| featured | BOOLEAN | Show as featured |
| sort_order | INTEGER | Display order |
| is_active | BOOLEAN | Show in catalog |

## Security Notes

### Cloudinary
- Use unsigned upload preset for frontend uploads
- Set folder restrictions in Cloudinary settings
- Enable moderation if needed
- Set file size limits

### Supabase
- Row Level Security (RLS) enabled
- Public can only read active products
- Only authenticated users can modify
- Use environment-specific keys
- Never commit .env to version control

## Backup and Migration

### Export Products
1. Open editor
2. Go to "Import / Export" tab
3. Click "Export Data"
4. Save JSON file

### Import Products
1. Open editor
2. Go to "Import / Export" tab
3. Click "Import Data"
4. Select your JSON file
5. Confirm import

## Production Deployment

1. Set environment variables in your hosting platform
2. Ensure Supabase URL and key are production values
3. Use production Cloudinary cloud name
4. Test image uploads before launch
5. Set up proper authentication for editor access

## Support

For issues:
1. Check browser console for errors
2. Check Supabase logs
3. Verify environment variables
4. Test with sample data first
5. Review SQL schema matches your database

---

**Note**: This system uses LocalStorage as fallback when Supabase is not configured, making it easy to develop and test locally.
