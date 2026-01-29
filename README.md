# Old Persian Lithography Writing Interface (رابط کاربری نگارش چاپ سنگی)

A web-based writing tool designed to simulate the aesthetic of old Persian lithography books (چاپ سنگی). This interface provides a distraction-free, immersive environment for writing in Persian with advanced formatting and export capabilities.

**Author:** Pouya Sadeghi

## Features

### 🖌️ Visual & Aesthetic
- **Lithography Style:** Simulates aged vintage paper with ink bleed, noise, and texture.
- **Low Quality Mode:** A toggleable filter that adds blur, high contrast, and sepia tones to mimic damaged or very old scanned documents.
- **Folded Book View:** In single-page mode, the interface renders a 3D folded book effect with realistic shadows.
- **Custom Fonts:** Includes a selection of beautiful Persian fonts (Amiri, Gulzar, Lateef, Scheherazade New, Vazirmatn).
- **Ink Color:** Customizable dark ink color with subtle shadows for realism.

### ✍️ Writing Experience
- **Auto-Pagination:** Text automatically flows to the next page as you write, just like a real word processor.
- **Persian Smart Spacing:** Automatically converts standard spaces to Zero Width Non-Joiners (نیم‌فاصله) for correct Persian grammar (e.g., converts `می روم` to `می‌روم` and `کفش ها` to `کفش‌ها`).
- **Mode Indicators:** Visual cues for specific styles like "Dialogue" or "Poetry".
- **Raw Text Editor:** A "Raw Text" mode allows for fast bulk editing and copying/pasting of large texts.

### 🛠️ Functionality
- **Auto-Save:** Your work is automatically saved to the browser's local storage.
- **PDF Export:** Press `Ctrl+S` or the Save button to export your work as a clean, margin-free PDF (via Print).
- **View Modes:** Toggle between Single Page (focused) and Double Page (book spread) views.
- **Animated Navigation:** Smooth page-turn animations.

## Usage

1. Open `index.html` in any modern web browser.
2. Start typing in the main text area.
3. Use the **Bottom Toolbar** to navigate pages, changing view modes, or toggle "Low Quality".
4. Use the **Top Toolbar** to apply styles (Bold, Dialogue, Poetry), change fonts, or Save.
5. **Shortcuts:**
    - `Ctrl+S`: Print/Save as PDF.

## Technical Details

- Built with **Vanilla HTML, CSS, and JavaScript**.
- No external frameworks or dependencies required.
- Uses `contentEditable` for the rich text interface and complex DOM manipulation for auto-pagination.
