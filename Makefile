# Makefile for pasteimage
# Build and release automation

.PHONY: build install clean release help

# Get version from git tags, fallback to 0.0.0
VERSION ?= $(shell git describe --tags --abbrev=0 2>/dev/null | sed 's/^v//' || echo "0.0.0")

# Build the executable with version injection
build:
	@echo "🔨 Building pasteimage v$(VERSION)..."
	@sed 's/let version = .*/let version = "$(VERSION)"/' pasteimage.swift > pasteimage_build.swift
	@swiftc pasteimage_build.swift -o pasteimage -O
	@rm -f pasteimage_build.swift
	@echo "✅ Build complete: ./pasteimage (v$(VERSION))"

# Install to /usr/local/bin
install: build
	@echo "📦 Installing to /usr/local/bin..."
	@sudo cp pasteimage /usr/local/bin/
	@sudo chmod +x /usr/local/bin/pasteimage
	@echo "✅ Installed: pasteimage --help"

# Clean build artifacts
clean:
	@echo "🧹 Cleaning..."
	@rm -f pasteimage pasteimage_build.swift
	@echo "✅ Clean complete"

# Create release archive
release: build
	@echo "📦 Creating release package..."
	@mkdir -p dist
	@cp pasteimage dist/
	@cp README.md dist/
	@cp LICENSE dist/
	@cd dist && tar -czf pasteimage-macos.tar.gz pasteimage README.md LICENSE
	@echo "✅ Release package created: dist/pasteimage-macos.tar.gz"

# Help
help:
	@echo "Available commands:"
	@echo "  make build    - Build the executable"
	@echo "  make install  - Install to /usr/local/bin"
	@echo "  make clean    - Clean build artifacts"
	@echo "  make release  - Create release package"