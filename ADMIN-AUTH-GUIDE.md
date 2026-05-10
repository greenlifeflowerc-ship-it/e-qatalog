# Admin Authentication Setup Guide

## Overview
The catalog editor uses **Supabase Auth** for secure admin login. Admins must authenticate with email/password before accessing the editor panel.

---

## Prerequisites

1. **Supabase Project** with Auth enabled
2. **Environment Variables** configured:
   ```env
   VITE_SUPABASE_URL=your_supabase_project_url
   VITE_SUPABASE_ANON_KEY=your_supabase_anon_key
   ```

---

## Database Setup

### 1. Run Admin Profiles Schema

Execute the SQL in Supabase SQL Editor:

```bash
# File: supabase-admin-auth.sql
```

This creates:
- `public.admin_profiles` table
- RLS policies for security
- Triggers for auto-updating timestamps
- Indexes for performance

### 2. Table Structure

```sql
CREATE TABLE public.admin_profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id),
  email TEXT NOT NULL UNIQUE,
  full_name TEXT,
  role TEXT NOT NULL DEFAULT 'admin',
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
```

---

## Creating Admin Users

### Method 1: Sign Up + SQL Insert (Recommended)

**Step 1**: Have the user sign up via your app or Supabase Dashboard
- Go to Authentication → Users → Invite User
- Or use Supabase Auth signup flow

**Step 2**: Get the user's UUID from `auth.users` table

**Step 3**: Insert into `admin_profiles`:

```sql
INSERT INTO public.admin_profiles (id, email, full_name, role, is_active)
SELECT 
  id,
  email,
  'Admin Full Name',
  'admin',
  true
FROM auth.users
WHERE email = 'admin@example.com';
```

### Method 2: Manual Insert (If User Exists)

If the user already exists in `auth.users`:

```sql
-- Find user ID first
SELECT id, email FROM auth.users WHERE email = 'admin@example.com';

-- Then insert into admin_profiles
INSERT INTO public.admin_profiles (id, email, full_name, role, is_active)
VALUES (
  'USER_UUID_HERE',
  'admin@example.com',
  'Admin Name',
  'admin',
  true
);
```

---

## Admin Roles

The system supports different admin roles:

| Role | Description | Access Level |
|------|-------------|--------------|
| `admin` | Standard admin | Full editor access |
| `super_admin` | Super administrator | Can manage other admins (optional) |
| `editor` | Content editor | Limited access (optional) |

Current implementation checks for `role = 'admin'` but can be extended.

---

## Security Features

### 1. **Supabase Auth**
- Passwords hashed and secured by Supabase
- No passwords stored in LocalStorage or frontend code
- Session management handled by Supabase

### 2. **Row Level Security (RLS)**
- `admin_profiles` table has RLS enabled
- Only authenticated users can read profiles
- Admins can only see their own profile
- Deletion is blocked for audit trail

### 3. **Active Status Check**
- Only `is_active = true` admins can login
- Deactivated admins are denied access

### 4. **Access Denied Handling**
- If logged in user is not in `admin_profiles`: Access Denied
- If admin is `is_active = false`: Access Denied
- If `role != 'admin'`: Access Denied (can be customized)

---

## User Flow

### Login Flow

1. User clicks "Editor" button
2. If not logged in → Shows **AdminLogin** component
3. User enters email and password
4. System calls `supabase.auth.signInWithPassword()`
5. If successful, checks `admin_profiles` table
6. If admin profile exists with `is_active = true` and `role = 'admin'` → Grant access
7. If no admin profile or inactive → Show "Access Denied" + logout

### Logout Flow

1. User clicks "Logout" in editor
2. System calls `supabase.auth.signOut()`
3. Session cleared
4. User redirected to login screen

---

## Admin Management

### List All Admins

```sql
SELECT 
  id,
  email,
  full_name,
  role,
  is_active,
  created_at
FROM public.admin_profiles
ORDER BY created_at DESC;
```

### Deactivate Admin

```sql
UPDATE public.admin_profiles 
SET is_active = false 
WHERE email = 'admin@example.com';
```

### Reactivate Admin

```sql
UPDATE public.admin_profiles 
SET is_active = true 
WHERE email = 'admin@example.com';
```

### Delete Admin Profile

```sql
DELETE FROM public.admin_profiles 
WHERE email = 'admin@example.com';
```

Note: This does NOT delete the user from `auth.users`. They can still login but won't have admin access.

### Completely Remove User

```sql
-- 1. Delete admin profile
DELETE FROM public.admin_profiles WHERE email = 'admin@example.com';

-- 2. Delete auth user (use Supabase Dashboard or service role)
-- Go to Authentication → Users → Delete User
```

---

## Development Setup

### 1. Create First Admin

After running the SQL schema, create your first admin:

```sql
-- Option A: If you already have a Supabase Auth account
INSERT INTO public.admin_profiles (id, email, full_name, role, is_active)
SELECT id, email, 'Your Name', 'admin', true
FROM auth.users
WHERE email = 'your-email@example.com';

-- Option B: If no auth user exists yet, sign up first:
-- 1. Run the app: npm run dev
-- 2. Click Editor button
-- 3. Try to login (will create auth.users entry)
-- 4. Then run the INSERT above
```

### 2. Test Login

1. Start dev server: `npm run dev`
2. Click "Editor" button in navbar
3. Enter admin email and password
4. If successful → Editor panel opens
5. If "Access Denied" → Check `admin_profiles` table

### 3. Debugging

**Check if user exists in auth:**
```sql
SELECT id, email FROM auth.users WHERE email = 'your-email@example.com';
```

**Check if admin profile exists:**
```sql
SELECT * FROM public.admin_profiles WHERE email = 'your-email@example.com';
```

**Check if admin is active:**
```sql
SELECT is_active, role FROM public.admin_profiles WHERE email = 'your-email@example.com';
```

---

## Production Deployment

### 1. Environment Variables

Ensure production environment has:
```env
VITE_SUPABASE_URL=your_production_supabase_url
VITE_SUPABASE_ANON_KEY=your_production_anon_key
```

### 2. Admin Creation Process

1. **Pre-deployment**: Create admin accounts in Supabase Dashboard
2. **Invite admins** via Supabase Authentication panel
3. **Run SQL** to add them to `admin_profiles` table
4. **Test login** before going live

### 3. Security Checklist

- [ ] RLS enabled on `admin_profiles` table
- [ ] RLS enabled on `products` table (if using Supabase for products)
- [ ] Environment variables secured (not in source control)
- [ ] Supabase anon key is the **anon** key (not service role key)
- [ ] Only trusted emails added to `admin_profiles`
- [ ] Admin passwords are strong (handled by Supabase Auth)
- [ ] CORS configured in Supabase if needed

---

## Troubleshooting

### "Access Denied" Error

**Cause**: User authenticated but not in `admin_profiles` or not active.

**Solution**:
1. Check if user exists in `admin_profiles`:
   ```sql
   SELECT * FROM public.admin_profiles WHERE email = 'user@example.com';
   ```
2. If not found, insert:
   ```sql
   INSERT INTO public.admin_profiles (id, email, role, is_active)
   SELECT id, email, 'admin', true
   FROM auth.users
   WHERE email = 'user@example.com';
   ```
3. If found but `is_active = false`, activate:
   ```sql
   UPDATE public.admin_profiles SET is_active = true WHERE email = 'user@example.com';
   ```

### "Invalid login credentials"

**Cause**: Wrong email or password.

**Solution**:
1. Verify email exists in Supabase Auth
2. Use "Reset Password" feature if needed
3. Check for typos

### "Supabase not configured"

**Cause**: Missing environment variables.

**Solution**:
1. Create `.env` file from `.env.example`
2. Add Supabase URL and anon key
3. Restart dev server

### Session Not Persisting

**Cause**: Cookie/localStorage issues.

**Solution**:
1. Check browser console for errors
2. Verify Supabase project URL is correct
3. Clear browser cache and localStorage
4. Check browser privacy settings (cookies must be enabled)

---

## Migration from Hardcoded Password

If you're migrating from the old `admin123` system:

### Before (Old System)
- Hardcoded password: `admin123`
- Stored in component state
- No user management
- No security

### After (New System)
- Supabase Auth email/password
- Secure password hashing
- User management via database
- RLS policies
- Session management

### Migration Steps

1. ✅ Run `supabase-admin-auth.sql`
2. ✅ Create admin user in Supabase Auth
3. ✅ Add admin to `admin_profiles` table
4. ✅ Test login with new email/password
5. ✅ Remove old hardcoded password references
6. ✅ Update documentation

---

## API Reference

### useAdminAuth Hook

```typescript
const {
  user,          // Current auth user
  session,       // Current session
  adminProfile,  // Admin profile data
  isAdmin,       // Boolean: is active admin
  loading,       // Boolean: loading state
  error,         // String: error message
  login,         // Function: (email, password) => Promise<void>
  logout,        // Function: () => Promise<void>
} = useAdminAuth();
```

### AdminLogin Component

```typescript
<AdminLogin
  isAdmin={boolean}
  loading={boolean}
  error={string | null}
  onLogin={(email, password) => Promise<void>}
  onLogout={() => Promise<void>}
  onClose={() => void}
  userEmail={string | null}
/>
```

---

## Support

For issues:
1. Check Supabase Auth logs in dashboard
2. Check browser console for errors
3. Verify SQL schema was run correctly
4. Confirm RLS policies are active
5. Test with fresh browser session

---

**Status**: Production Ready ✅  
**Last Updated**: May 9, 2026  
**Auth Provider**: Supabase Auth  
**Security**: RLS + Session Management
