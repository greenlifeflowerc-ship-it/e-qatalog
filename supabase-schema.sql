-- Supabase Products Table Schema
-- Run this SQL in your Supabase SQL Editor

-- Create products table
CREATE TABLE IF NOT EXISTS public.products (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  item_number TEXT NOT NULL UNIQUE,
  name_en TEXT NOT NULL,
  name_ar TEXT NOT NULL,
  category_en TEXT NOT NULL,
  category_ar TEXT NOT NULL,
  height TEXT,
  width TEXT,
  pot TEXT,
  image_url TEXT,
  cloudinary_public_id TEXT,
  description_en TEXT,
  description_ar TEXT,
  featured BOOLEAN DEFAULT FALSE,
  sort_order INTEGER DEFAULT 0,
  is_active BOOLEAN DEFAULT TRUE
);

-- Add columns if table already exists
ALTER TABLE public.products ADD COLUMN IF NOT EXISTS item_number TEXT;
ALTER TABLE public.products ADD COLUMN IF NOT EXISTS name_en TEXT;
ALTER TABLE public.products ADD COLUMN IF NOT EXISTS name_ar TEXT;
ALTER TABLE public.products ADD COLUMN IF NOT EXISTS category_en TEXT;
ALTER TABLE public.products ADD COLUMN IF NOT EXISTS category_ar TEXT;
ALTER TABLE public.products ADD COLUMN IF NOT EXISTS height TEXT;
ALTER TABLE public.products ADD COLUMN IF NOT EXISTS width TEXT;
ALTER TABLE public.products ADD COLUMN IF NOT EXISTS pot TEXT;
ALTER TABLE public.products ADD COLUMN IF NOT EXISTS image_url TEXT;
ALTER TABLE public.products ADD COLUMN IF NOT EXISTS cloudinary_public_id TEXT;
ALTER TABLE public.products ADD COLUMN IF NOT EXISTS description_en TEXT;
ALTER TABLE public.products ADD COLUMN IF NOT EXISTS description_ar TEXT;
ALTER TABLE public.products ADD COLUMN IF NOT EXISTS featured BOOLEAN DEFAULT FALSE;
ALTER TABLE public.products ADD COLUMN IF NOT EXISTS sort_order INTEGER DEFAULT 0;
ALTER TABLE public.products ADD COLUMN IF NOT EXISTS is_active BOOLEAN DEFAULT TRUE;

-- Create unique index on item_number
CREATE UNIQUE INDEX IF NOT EXISTS products_item_number_unique
ON public.products (item_number);

-- Create index on category for faster filtering
CREATE INDEX IF NOT EXISTS products_category_en_idx
ON public.products (category_en);

-- Create index on is_active for filtering active products
CREATE INDEX IF NOT EXISTS products_is_active_idx
ON public.products (is_active);

-- Create index on sort_order for ordering
CREATE INDEX IF NOT EXISTS products_sort_order_idx
ON public.products (sort_order);

-- Enable Row Level Security (RLS)
ALTER TABLE public.products ENABLE ROW LEVEL SECURITY;

-- Create policy to allow public read access
CREATE POLICY "Allow public read access"
ON public.products
FOR SELECT
USING (is_active = TRUE);

-- Create policy to allow authenticated users to insert
CREATE POLICY "Allow authenticated insert"
ON public.products
FOR INSERT
TO authenticated
WITH CHECK (TRUE);

-- Create policy to allow authenticated users to update
CREATE POLICY "Allow authenticated update"
ON public.products
FOR UPDATE
TO authenticated
USING (TRUE)
WITH CHECK (TRUE);

-- Create policy to allow authenticated users to delete
CREATE POLICY "Allow authenticated delete"
ON public.products
FOR DELETE
TO authenticated
USING (TRUE);

-- Create function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger to automatically update updated_at
DROP TRIGGER IF EXISTS update_products_updated_at ON public.products;
CREATE TRIGGER update_products_updated_at
BEFORE UPDATE ON public.products
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- Insert sample data (optional)
-- INSERT INTO public.products (item_number, name_en, name_ar, category_en, category_ar, height, width, pot, featured, sort_order)
-- VALUES 
--   ('AT-9130', 'Artificial Olive Tree', 'شجرة زيتون صناعية', 'Olive Trees', 'أشجار الزيتون', '160 cm', '90 cm', 'Natural wood planter', TRUE, 1),
--   ('AT-9844', 'Artificial Bonsai Pine Tree', 'شجرة بونساي صنوبر صناعية', 'Bonsai', 'بونساي', '60 cm', '70 cm', 'Traditional ceramic pot', TRUE, 2);

-- Grant permissions (adjust as needed for your setup)
GRANT ALL ON public.products TO authenticated;
GRANT SELECT ON public.products TO anon;
