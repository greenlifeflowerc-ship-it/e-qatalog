# Quick Reference: AT Prefix Item Numbers

## Item Number Format
**Correct Format**: `AT-XXXX`  
**Examples**: AT-9130, AT-9610, AT-9844

## Auto-Normalization Examples

### When Adding/Editing Products

| You Type | System Normalizes To | Status |
|----------|---------------------|--------|
| 9130 | AT-9130 | ✅ Valid |
| at-9130 | AT-9130 | ✅ Valid |
| AT-9130 | AT-9130 | ✅ Valid |
| ar-9130 | AT-9130 | ✅ Valid (converted) |
| AR-9130 | AT-9130 | ✅ Valid (converted) |

### Search Functionality

| You Search | System Finds | Works? |
|------------|-------------|--------|
| AT-9130 | AT-9130 | ✅ Yes |
| AR-9130 | AT-9130 | ✅ Yes (auto-converted) |
| at-9130 | AT-9130 | ✅ Yes |
| 9130 | AT-9130 | ✅ Yes (number match) |
| Olive | AT-9130 (if category/name matches) | ✅ Yes |

## Editor Form Guide

### Adding a New Product

1. **Item Number Field**:
   - Enter: `9130` → Automatically becomes: `AT-9130`
   - Enter: `ar-9130` → Automatically becomes: `AT-9130`
   - Required format: `AT-[numbers/letters]`

2. **Category Dropdown**:
   - Select category (e.g., "Olive Trees")
   - Arabic name auto-fills

3. **Upload Image**:
   - Must enter item number + category first
   - Image uploads to: `flower-center/products/olive-trees/AT-9130`
   - Filename: `AT-9130.png` (or .jpg, .webp)

4. **Validation**:
   - ✅ "AT-9130" → Valid
   - ❌ "AR-9130" → Shows error (after conversion to AT-9130, it's valid)
   - ❌ "9130" → Shows error (after auto-prefix to AT-9130, it's valid)

### Image Upload Path Examples

| Item Number | Category | Upload Folder | Public ID | Final Path |
|-------------|----------|---------------|-----------|------------|
| AT-9130 | Olive Trees | olive-trees | AT-9130 | flower-center/products/olive-trees/AT-9130 |
| AT-9610 | Bamboo | bamboo | AT-9610 | flower-center/products/bamboo/AT-9610 |
| AT-9844 | Bonsai | bonsai | AT-9844 | flower-center/products/bonsai/AT-9844 |

## Default Products (10 Total)

| Item Number | Category | Name (English) |
|-------------|----------|----------------|
| AT-9610 | Bamboo | Artificial Bamboo Tree |
| AT-9701 | Bougainvillea | Artificial Bougainvillea Tree |
| AT-9844 | Bonsai | Artificial Bonsai Pine Tree |
| AT-9750 | Cherry Blossom | Artificial Cherry Blossom Tree |
| AT-9130 | Olive Trees | Artificial Olive Tree |
| AT-9200 | Ghaf Trees | Artificial Ghaf Tree |
| AT-9300 | Ficus Trees | Artificial Ficus Tree |
| AT-9400 | Lemon Trees | Artificial Lemon Tree |
| AT-9500 | Maple Trees | Artificial Maple Tree |
| AT-9600 | Palm Trees | Artificial Palm Tree |

## Common Scenarios

### Scenario 1: User Types Numbers Only
```
Input: "9130"
System: Adds "AT-" prefix automatically
Result: "AT-9130" ✅
```

### Scenario 2: User Types Old AR Prefix
```
Input: "AR-9130"
System: Converts AR to AT automatically
Result: "AT-9130" ✅
```

### Scenario 3: User Searches for Old Item
```
Search: "AR-9130"
System: Converts to "AT-9130" internally
Result: Finds product with "AT-9130" ✅
```

### Scenario 4: Image Upload
```
1. Enter item number: "9130" → Normalized to "AT-9130"
2. Select category: "Olive Trees"
3. Upload button enabled
4. Select image file
5. Uploads to: flower-center/products/olive-trees/AT-9130
6. Image URL saved in database
```

## Validation Rules

### Valid Item Numbers
- `AT-9130` ✅
- `AT-A001` ✅
- `AT-XYZ123` ✅
- `AT-9999` ✅

### Invalid Item Numbers (Rejected)
- `AR-9130` ❌ (Will be auto-converted to AT-9130)
- `9130` (without prefix after normalization) ❌
- `XYZ-9130` ❌
- `AT` (no number/code) ❌
- Empty string ❌

## Migration Tips

### If You Have Old AR- Data:

**Option 1: Quick Console Fix**
```javascript
// Open DevTools Console
let data = JSON.parse(localStorage.getItem('flower-center-catalog'));
data.products = data.products.map(p => ({
  ...p,
  item_number: p.item_number.replace('AR-', 'AT-')
}));
localStorage.setItem('flower-center-catalog', JSON.stringify(data));
location.reload();
```

**Option 2: Supabase SQL Update**
```sql
UPDATE public.products
SET item_number = REPLACE(item_number, 'AR-', 'AT-')
WHERE item_number LIKE 'AR-%';
```

**Option 3: Manual Re-entry**
1. Note down all products
2. Delete old AR- products
3. Add new products with AT- prefix

## Technical Details

### Helper Functions (src/utils/itemNumber.ts)

1. **normalizeItemNumber(value: string): string**
   - Purpose: Convert any input to AT-XXXX format
   - Used in: ProductEditorForm (on change, before save, before upload)

2. **isValidItemNumber(value: string): boolean**
   - Purpose: Validate final format is AT-XXXX
   - Used in: ProductEditorForm validation

3. **normalizeSearchQuery(query: string): string**
   - Purpose: Convert AR- searches to AT-
   - Used in: App.tsx search logic

---

**Need Help?**
- Check SETUP-GUIDE.md for full setup instructions
- Check ITEM-NUMBER-UPDATE.md for detailed change log
- All item numbers must start with AT-
- System automatically handles AR→AT conversion
