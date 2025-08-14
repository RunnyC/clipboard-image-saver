class Pasteimage < Formula
  desc "Fast clipboard image saving for macOS"
  homepage "https://github.com/RunnyC/clipboard-image-saver"
  url "https://github.com/RunnyC/clipboard-image-saver/releases/download/v1.0.0/pasteimage-macos.tar.gz"
  sha256 "[UPDATE_AFTER_RELEASE]"
  license "MIT"

  depends_on :macos

  def install
    bin.install "pasteimage"
  end

  test do
    system "#{bin}/pasteimage", "--help" 2>&1
  end
end