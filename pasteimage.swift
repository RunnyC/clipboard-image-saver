#!/usr/bin/env swift

import AppKit
import Quartz

let pasteboard = NSPasteboard.general
let fileManager = FileManager.default

// --- Parse command-line arguments ---
var outputName: String? = nil
var customFolder: String? = nil

var args = CommandLine.arguments.dropFirst()
while let arg = args.first {
    if arg == "--folder", args.count > 1 {
        args = args.dropFirst()
        customFolder = args.first
    } else if outputName == nil {
        outputName = arg
    }
    args = args.dropFirst()
}

// --- Determine save folder (cwd by default) ---
let saveFolder: String
if let folder = customFolder {
    let expanded = (folder as NSString).expandingTildeInPath
    if !fileManager.fileExists(atPath: expanded) {
        do { try fileManager.createDirectory(atPath: expanded, withIntermediateDirectories: true) }
        catch { print("❌ Failed to create folder: \(error)"); exit(1) }
    }
    saveFolder = expanded
} else { saveFolder = fileManager.currentDirectoryPath }

// --- Determine base output filename with human-readable timestamp ---
let baseOutput: String
if let name = outputName, !name.isEmpty {
    baseOutput = name.hasSuffix(".png") ? String(name.dropLast(4)) : name
} else {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyyMMdd_HHmmss"
    let tsString = formatter.string(from: Date())
    baseOutput = "clipboard_\(tsString)"
}

// --- Helper: resolve filename collisions ---
func resolvedPath(for base: String, folder: String) -> String {
    var candidate = "\(folder)/\(base).png"
    var index = 1
    while fileManager.fileExists(atPath: candidate) {
        candidate = "\(folder)/\(base)_\(index).png"
        index += 1
    }
    return candidate
}

// --- Helper: save NSImage as PNG ---
func saveAsPNG(_ image: NSImage, to path: String) -> Bool {
    guard let tiffData = image.tiffRepresentation,
          let bitmap = NSBitmapImageRep(data: tiffData),
          let pngData = bitmap.representation(using: .png, properties: [:]) else {
        return false
    }
    do { try pngData.write(to: URL(fileURLWithPath: path)); return true }
    catch { return false }
}

// --- 1️⃣ File URLs on clipboard ---
if let types = pasteboard.types, types.contains(.fileURL),
   let fileURLs = pasteboard.readObjects(forClasses: [NSURL.self], options: nil) as? [URL],
   let firstURL = fileURLs.first {

    let fileExtension = firstURL.pathExtension.lowercased()
    
    // a) PDF: multi-page, collision-safe
    if fileExtension == "pdf", let pdfDoc = PDFDocument(url: firstURL) {
        for i in 0..<pdfDoc.pageCount {
            guard let page = pdfDoc.page(at: i) else { continue }
            let pageRect = page.bounds(for: .mediaBox)
            let image = NSImage(size: pageRect.size)
            image.lockFocus()
            guard let context = NSGraphicsContext.current?.cgContext else { continue }
            context.setFillColor(NSColor.white.cgColor)
            context.fill(pageRect)
            page.draw(with: .mediaBox, to: context)
            image.unlockFocus()
            
            let pageBase = "\(baseOutput)_page\(i+1)"
            let pageOutput = resolvedPath(for: pageBase, folder: saveFolder)
            if saveAsPNG(image, to: pageOutput) {
                print("📄 Saved PDF page \(i+1) as PNG: \(pageOutput)")
            } else { print("❌ Failed to save page \(i+1)") }
        }
        exit(0)
    }
    
    // b) Standard image file
    if let image = NSImage(contentsOf: firstURL) {
        let finalPath = resolvedPath(for: baseOutput, folder: saveFolder)
        if saveAsPNG(image, to: finalPath) {
            print("📸 Saved clipboard image file as PNG: \(finalPath)")
            exit(0)
        }
    }
    
    // c) Fallback: copy raw file
    do {
        let finalPath = resolvedPath(for: baseOutput, folder: saveFolder)
        let fileData = try Data(contentsOf: firstURL)
        try fileData.write(to: URL(fileURLWithPath: finalPath))
        print("📸 Saved raw clipboard file as: \(finalPath)")
        exit(0)
    } catch {
        print("❌ Failed to copy file from clipboard: \(error)")
        exit(1)
    }
}

// --- 2️⃣ Clipboard bitmap ---
if let data = pasteboard.data(forType: .png) ?? pasteboard.data(forType: .tiff),
   let image = NSImage(data: data) {
    let finalPath = resolvedPath(for: baseOutput, folder: saveFolder)
    if saveAsPNG(image, to: finalPath) {
        print("📸 Saved bitmap clipboard image as: \(finalPath)")
        exit(0)
    }
}

print("❌ No image data in clipboard.")
exit(1)
