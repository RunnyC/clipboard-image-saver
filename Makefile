# Makefile for pasteimage
# Build and release automation

.PHONY: build install clean release

# Build the executable
build:
	@echo "🔨 Building pasteimage..."
	@swiftc pasteimage.swift -o pasteimage -O
	@echo "✅ Build complete: ./pasteimage"

# Install to /usr/local/bin
install: build
	@echo "📦 Installing to /usr/local/bin..."
	@sudo cp pasteimage /usr/local/bin/
	@sudo chmod +x /usr/local/bin/pasteimage
	@echo "✅ Installed: pasteimage --help"

# Clean build artifacts
clean:
	@echo "🧹 Cleaning..."
	@rm -f pasteimage
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