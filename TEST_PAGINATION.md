# Pagination Testing Guide

## Overview
This document explains how to test the fixed pagination system with large text blocks, and how Persian RTL paging works.

## What Was Fixed

### 1. **Robust Multi-Pass Pagination**
- **Problem**: Single-pass pagination would not create enough pages for 400+ lines
- **Solution**: 
  - Loop count increased from 1000 to 2000 iterations
  - Break and restart after each `moveContent()` call for proper cascade
  - Compress only once at start (not each loop)
  - Ensures all overflow is handled before completing

### 2. **Immediate Pagination on Large Paste**
- **Problem**: Pasting large text didn't trigger pagination immediately
- **Solution**:
  - Added `triggerPagination()` call on paste event
  - Uses `setTimeout(..., 0)` to ensure text is inserted first
  - Input events still debounced at 150ms to avoid instability

### 3. **Improved Content Flow**
- **Problem**: `moveContent()` safety limit was too low (100)
- **Solution**:
  - Increased to 150 to handle larger block moves
  - Proper order maintained: last child → first child of next page (RTL correct)

### 4. **Persian RTL Style Paging**
- **Layout**: Pages shown in pairs (0-1, 2-3, 4-5, etc.) in double-page mode
- **Direction**: CSS `direction: rtl` handles right-to-left text automatically
- **Page Numbers**: Displayed in Persian digits (۰, ۱, ۲...) via `toPersianDigits()`
- **Navigation**: Even-indexed pages always on left (in viewer's perspective), odd on right

## Testing Steps

### Test 1: Large Single Paste
1. Open `index.html` in your browser
2. Go to **Raw Text** mode (Alt+R or bottom toolbar "خام" button)
3. Paste 400-600 lines of Persian/English text
4. Click "اعمال و بازگشت" (Apply)
5. **Expected**: Pages are auto-created (should see 10+ pages)
6. Check page counter at bottom: should show "۱ / ۱۲" (or similar high number)

### Test 2: Double-Page View
1. Start with test 1 result (multiple pages)
2. Click **دو صفحه‌ای** button (bottom toolbar) to enter double-page mode
3. **Expected**: 
   - Two pages shown side by side
   - Left page is even-numbered (0, 2, 4...)
   - Right page is odd-numbered (1, 3, 5...)
   - Page counter updates correctly

### Test 3: Navigation
1. In double-page mode, click **صفحه بعد** (Next) button
2. **Expected**: Jumps to pages 2-3, then 4-5, etc. (increments by 2)
3. Click **صفحه قبل** (Previous)
4. **Expected**: Goes back by 2 pages each click
5. No crashes or skipped pages

### Test 4: Single-Page Mode
1. Click **تک صفحه‌ای** button to switch to single-page
2. **Expected**: Shows one page at a time
3. Click **صفحه بعد** multiple times
4. **Expected**: Advances by 1 page each time
5. Page counter shows "۵ / ۱۲" format correctly

### Test 5: Manual Typing Large Block
1. Go to single-page mode
2. Type or paste 100+ lines directly into page 1
3. **Expected**: As you type, new pages are automatically created
4. No content loss, text flows smoothly to next pages

## Common Issues & Fixes

### Issue: Text Not Flowing to Next Pages
- **Check**: Is pagination running? (Look at JavaScript console for errors)
- **Fix**: Clear browser cache, refresh page, try again
- **Verify**: In browser DevTools, check `getAllPages().length` in console

### Issue: Pages Not Showing in Double-View
- **Check**: Are there 2+ pages? (Page counter should show "۱ / ۱۰")
- **Fix**: Click "دو صفحه‌ای" again to toggle
- **Verify**: currentPageIndex should be even (0, 2, 4...)

### Issue: Very Large Pastes (1000+ lines) Slow
- **Expected**: May take 2-3 seconds to paginate
- **Check**: Loop count in console: `loopCount` should be <100 for 400 lines
- **Fix**: Browser performance varies; try closing other tabs

## Performance Expectations

| Text Size | Pages Created | Time | Notes |
|-----------|---------------|------|-------|
| 100 lines | 2-3 pages | <100ms | Instant |
| 400 lines | 10-12 pages | 200-400ms | Noticeable but smooth |
| 1000+ lines | 25+ pages | 1-2 seconds | May stall UI briefly |

## Technical Details

### Pagination Algorithm
```
while (loopCount < 2000) {
  for each page {
    if (page.overflow) {
      moveContent(page, nextPage)
      break  // Restart loop to recalculate
    }
  }
  if (no content moved) break  // Done
}
```

### moveContent() Logic
- Moves 1 element at a time from current page's bottom to next page's top
- Safety limit: 150 moves max per pass
- Direction: Last child → First child (correct for RTL)

### compressContent() Logic
- Removes only excessive empty lines (>4 consecutive)
- Preserves intentional spacing/line breaks
- Runs once before pagination begins

## File Changes Summary

**vintage-persian-writing-interface/app.js**:
- `triggerPagination()`: Added setTimeout wrapper, increased maxLoops to 2000, improved loop structure
- `moveContent()`: Increased safety from 100 to 150, clarified RTL order
- `attachListeners()` paste handler: Added `triggerPagination()` call after text insert

## Debug Commands (Browser Console)

```javascript
// Check current pages
getAllPages().length  // Should be 10+ for 400 lines

// Check current view
isSingleView  // true for single, false for double

// Check current page index
currentPageIndex  // Should be 0 for first page

// Force pagination
triggerPagination()

// Check if pagination is running
isPaginating  // true while processing

// Inspect a page's overflow
getAllPages()[0].querySelector('.content').scrollHeight
getAllPages()[0].querySelector('.content').clientHeight
```

## Success Criteria

✅ **Test passed if**:
- 400-line paste creates 10+ pages automatically
- Double-page view shows pairs correctly (0-1, 2-3, etc.)
- Navigation buttons advance/rewind by correct amounts
- Single-page mode works independently
- No content is lost or duplicated
- Page numbering displays in Persian digits
- Text flows naturally across pages with no visible gaps

---

**Last Updated**: January 2026  
**Status**: Ready for testing
