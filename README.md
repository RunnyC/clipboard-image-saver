# Clipboard Image Saver (`pasteimage`)

A simple, robust macOS terminal tool to save images from your clipboard directly to the filesystem. Supports screenshots, copied images from apps, and multi-page PDFs. All images are saved as PNG with human-readable timestamps and collision-safe filenames.

---

## Features

- Save clipboard images to the **current working directory** by default.
- Optional **custom folder** via `--folder` flag.
- Optional **custom filename**.
- **Multi-page PDF** support: each page is exported as a separate PNG.
- **Automatic collision handling**: appends `_1`, `_2`, etc., if the file already exists.
- Human-readable timestamp default: `clipboard_YYYYMMDD_HHMMSS.png`.
- Supports standard image formats: PNG, JPEG, TIFF, WebP, GIF (static), HEIC.
- Fully written in Swift, no external dependencies.

---

## Installation

### Manual

1. Copy `pasteimage.swift` to a folder in your PATH (e.g., `~/bin` or `/usr/local/bin`):

```bash
cp pasteimage.swift ~/bin/pasteimage
chmod +x ~/bin/pasteimage
```

2. Ensure the folder is in your PATH:

```bash
echo $PATH
# if ~/bin not in PATH, add it
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### Optional: Zsh Alias

You can add a simple alias in ~/.zshrc:

```bash
alias pasteimage="~/bin/pasteimage"
```

Then reload Zsh:

```bash
source ~/.zshrc
```

---

## Usage

### Basic usage (current folder, auto timestamp):

```bash
pasteimage
# -> creates clipboard_20250814_134502.PNG
```

### Optional custom filename:

```bash
pasteimage my_screenshot
# -> my_screenshot.png (collision-safe)
```

### Multi-page PDF:

```bash
pasteimage report.pdf
# -> report_page1.png, report_page2.png, etc.
```

### Custom folder:

```bash
pasteimage my_screenshot --folder ~/Desktop/images
```

---

## Note

- Always saves images as PNG for consistency and safety.
- Animated GIFs will be saved as static PNG (animation is not preserved).
- Collision handling ensures no existing file is overwritten.
- Multi-page PDFs export each page as a separate PNG, also collision-safe.

---

## License

MIT License. Feel free to use, modify, and distribute.

---

Enjoy quick and reliable clipboard image saving on macOS!
