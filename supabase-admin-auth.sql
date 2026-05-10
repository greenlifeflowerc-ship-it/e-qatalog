-- ============================================
-- Admin Profiles Table for Supabase Auth
-- ============================================
-- This table stores admin user profiles linked to Supabase Auth users.
-- Only users in this table with role='admin' and is_active=true can access the editor.

-- Drop table if exists (for clean reinstall)
-- DROP TABLE IF EXISTS public.admin_profiles CASCADE;

-- Create admin_profiles table
CREATE TABLE IF NOT EXISTS public.admin_profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email TEXT NOT NULL UNIQUE,
  full_name TEXT,
  role TEXT NOT NULL DEFAULT 'admin',
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  
  -- Constraints
  CONSTRAINT admin_profiles_email_check CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
  CONSTRAINT admin_profiles_role_check CHECK (role IN ('admin', 'super_admin', 'editor'))
);

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_admin_profiles_email ON public.admin_profiles(email);
CREATE INDEX IF NOT EXISTS idx_admin_profiles_active ON public.admin_profiles(is_active);
CREATE INDEX IF NOT EXISTS idx_admin_profiles_role ON public.admin_profiles(role);

-- Create updated_at trigger
CREATE OR REPLACE FUNCTION update_admin_profiles_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS set_admin_profiles_updated_at ON public.admin_profiles;
CREATE TRIGGER set_admin_profiles_updated_at
  BEFORE UPDATE ON public.admin_profiles
  FOR EACH ROW
  EXECUTE FUNCTION update_admin_profiles_updated_at();

-- ============================================
-- Row Level Security (RLS) Policies
-- ============================================

-- Enable RLS
ALTER TABLE public.admin_profiles ENABLE ROW LEVEL SECURITY;

-- Policy: Admins can read their own profile
CREATE POLICY "Admins can read own profile"
  ON public.admin_profiles
  FOR SELECT
  USING (auth.uid() = id);

-- Policy: Authenticated users can check if they are admin (needed for login)
CREATE POLICY "Anyone can check admin status"
  ON public.admin_profiles
  FOR SELECT
  USING (true);

-- Policy: Super admins can insert new admins (optional - requires service role or manual insert)
-- CREATE POLICY "Super admins can insert"
--   ON public.admin_profiles
--   FOR INSERT
--   WITH CHECK (
--     EXISTS (
--       SELECT 1 FROM public.admin_profiles
--       WHERE id = auth.uid()
--       AND role = 'super_admin'
--       AND is_active = true
--     )
--   );

-- Policy: Super admins can update admin profiles (optional)
-- CREATE POLICY "Super admins can update"
--   ON public.admin_profiles
--   FOR UPDATE
--   USING (
--     EXISTS (
--       SELECT 1 FROM public.admin_profiles
--       WHERE id = auth.uid()
--       AND role = 'super_admin'
--       AND is_active = true
--     )
--   );

-- Policy: Prevent deletion (optional - keep for audit)
CREATE POLICY "Prevent deletion"
  ON public.admin_profiles
  FOR DELETE
  USING (false);

-- ============================================
-- Grant Permissions
-- ============================================

-- Grant access to authenticated users
GRANT SELECT ON public.admin_profiles TO authenticated;
GRANT SELECT ON public.admin_profiles TO anon;

-- For super admin management, use service role or manual SQL

-- ============================================
-- Insert Initial Admin User
-- ============================================
-- IMPORTANT: Replace with your actual admin email
-- This user must already exist in auth.users (sign up first via Supabase Auth)

-- Example (replace with your admin user ID and email):
-- INSERT INTO public.admin_profiles (id, email, full_name, role, is_active)
-- VALUES (
--   'YOUR_AUTH_USER_ID_HERE',
--   'admin@example.com',
--   'Admin User',
--   'admin',
--   true
-- )
-- ON CONFLICT (id) DO NOTHING;

-- ============================================
-- How to Add Admin Users
-- ============================================
-- Step 1: User signs up via Supabase Auth (creates auth.users entry)
-- Step 2: Get the user's UUID from auth.users table
-- Step 3: Insert into admin_profiles:

-- INSERT INTO public.admin_profiles (id, email, full_name, role, is_active)
-- SELECT 
--   id,
--   email,
--   'Admin Name',
--   'admin',
--   true
-- FROM auth.users
-- WHERE email = 'admin@example.com';

-- ============================================
-- Useful Queries
-- ============================================

-- List all admin profiles:
-- SELECT * FROM public.admin_profiles ORDER BY created_at DESC;

-- Check if email is admin:
-- SELECT * FROM public.admin_profiles 
-- WHERE email = 'admin@example.com' 
-- AND is_active = true 
-- AND role = 'admin';

-- Deactivate admin:
-- UPDATE public.admin_profiles SET is_active = false WHERE email = 'admin@example.com';

-- Reactivate admin:
-- UPDATE public.admin_profiles SET is_active = true WHERE email = 'admin@example.com';

-- Delete admin profile:
-- DELETE FROM public.admin_profiles WHERE email = 'admin@example.com';
