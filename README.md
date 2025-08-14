# 🖼️ Clipboard Image Saver

**`pasteimage`** — *The fastest way to save clipboard images on macOS*

> **Capture. Save. Done.** ⚡

[![macOS](https://img.shields.io/badge/platform-macOS-blue.svg?style=flat-square)](https://developer.apple.com/macos/) [![Swift](https://img.shields.io/badge/language-Swift-orange.svg?style=flat-square)](https://swift.org/) [![License](https://img.shields.io/badge/license-MIT-green.svg?style=flat-square)](LICENSE) [![Version](https://img.shields.io/badge/version-1.0.2-lightgrey.svg?style=flat-square)](#) [![Terminal](https://img.shields.io/badge/tool-terminal-blueviolet.svg?style=flat-square)](#)

A sleek, robust macOS terminal tool that transforms your clipboard into instant PNG files. From screenshots to PDFs, from web images to app content — save everything with a single command.

**Built for developers, designers, and power users who value speed and simplicity.**

---

## 🌟 Brand Identity

**Clipboard Image Saver** represents the intersection of **efficiency** and **elegance** in developer tooling. Our brand values:

- **⚡ Speed First**: Zero-friction workflow from clipboard to file
- **🔧 Developer-Friendly**: Terminal-native, scriptable, automation-ready
- **🎯 Precision**: Pixel-perfect saves with intelligent naming
- **🛡️ Reliability**: Never lose a clipboard image again

**Tagline**: *"Where clipboard meets filesystem"*

---

## ✨ Features

- Save clipboard images to the **current working directory** by default.
- Optional **custom folder** via `--folder` flag.
- Optional **custom filename**.
- **Built-in help** with `--help` flag.
- **Multi-page PDF** support: each page is exported as a separate PNG.
- **Automatic collision handling**: appends `_1`, `_2`, etc., if the file already exists.
- Human-readable timestamp default: `clipboard_YYYYMMDD_HHMMSS.png`.
- Supports standard image formats: PNG, JPEG, TIFF, WebP, GIF (static), HEIC.
- Fully written in Swift, no external dependencies.

---

## 🚀 Quick Start

### 🍺 Homebrew (Recommended)

```bash
brew install runnyc/tap/pasteimage
```

### 📦 Pre-built Binary

```bash
# Download latest release
curl -L https://github.com/RunnyC/clipboard-image-saver/releases/latest/download/pasteimage-macos.tar.gz | tar -xz
sudo mv pasteimage /usr/local/bin/
```

### 🛠️ Build from Source

```bash
# Clone and build
git clone https://github.com/RunnyC/clipboard-image-saver.git
cd clipboard-image-saver
make install  # Builds and installs to /usr/local/bin
```

---

## 🎯 Usage Examples

### Basic usage (current folder, auto timestamp):

```bash
pasteimage
# -> creates clipboard_20250814_134502.png
```

### Optional custom filename:

```bash
pasteimage my_screenshot
# -> my_screenshot.png (collision-safe)
```

### Custom folder:

```bash
pasteimage my_screenshot --folder ~/Desktop/images
```

### Show help:

```bash
pasteimage --help
```

### Multi-page PDF:

```bash
pasteimage report.pdf
# -> report_page1.png, report_page2.png, etc.
```

---

## 📋 Pro Tips

- Use `pasteimage --help` anytime to see all options
- Always saves images as PNG for consistency and safety
- Animated GIFs will be saved as static PNG (animation is not preserved)
- Collision handling ensures no existing file is overwritten
- Multi-page PDFs export each page as a separate PNG, also collision-safe

---

## 🏛️ License & Community

**MIT License** — Use freely, modify boldly, share generously.

**Clipboard Image Saver** is built with ❤️ for the macOS developer community.

---

<p align="center">
  <strong>Made for developers, by developers</strong><br>
  <em>Because your clipboard deserves better than manual saving</em>
</p>
