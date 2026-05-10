# Quick Start: Admin Authentication

Get admin access to the catalog editor in 5 minutes.

## Prerequisites

- Supabase project created
- Environment variables configured (`.env` file)

---

## Step 1: Run SQL Schema (1 minute)

1. Open Supabase Dashboard
2. Go to **SQL Editor**
3. Click **New Query**
4. Paste content from **`supabase-admin-auth.sql`**
5. Click **Run**

✅ This creates the `admin_profiles` table.

---

## Step 2: Create Admin User (2 minutes)

### Option A: Invite via Dashboard

1. Supabase Dashboard → **Authentication** → **Users**
2. Click **Invite User**
3. Enter your email
4. Check your email and set password
5. Copy your user ID from the users table

### Option B: Sign up via App

1. Try to login to the editor
2. Click "Forgot Password" (if available) or sign up first
3. This creates your auth.users entry
4. Get your user ID from Supabase Dashboard

---

## Step 3: Add to admin_profiles (1 minute)

Run this SQL in Supabase SQL Editor:

```sql
-- Replace 'your-email@example.com' with your actual email
INSERT INTO public.admin_profiles (id, email, full_name, role, is_active)
SELECT 
  id,
  email,
  'Your Full Name',
  'admin',
  true
FROM auth.users
WHERE email = 'your-email@example.com';
```

✅ You're now an admin!

---

## Step 4: Test Login (1 minute)

1. Open your catalog: `http://localhost:5173`
2. Click **Editor** button in navbar
3. Enter your email and password
4. Editor panel should open

🎉 **Success!** You now have admin access.

---

## Troubleshooting

### "Access Denied" Error

**Check if you're in admin_profiles:**
```sql
SELECT * FROM public.admin_profiles WHERE email = 'your-email@example.com';
```

If empty, run Step 3 again.

### "Invalid login credentials"

- Check email spelling
- Verify password is correct
- Check if user exists in `auth.users`

### "Supabase not configured"

- Verify `.env` file exists
- Check `VITE_SUPABASE_URL` and `VITE_SUPABASE_ANON_KEY`
- Restart dev server: `npm run dev`

---

## Next Steps

- **Add more admins**: Repeat Steps 2-3 for each admin
- **Deactivate admin**: `UPDATE admin_profiles SET is_active = false WHERE email = '...'`
- **Change role**: `UPDATE admin_profiles SET role = 'super_admin' WHERE email = '...'`

---

## Security Reminders

✅ Use strong passwords  
✅ Enable email verification in Supabase  
✅ Don't share admin credentials  
✅ Monitor authentication logs  
✅ Use anon key (not service role key)  

---

**Total Time**: ~5 minutes  
**Difficulty**: Easy  
**Prerequisites**: Supabase project + .env configured
