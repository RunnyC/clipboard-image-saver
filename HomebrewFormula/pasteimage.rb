class Pasteimage < Formula
  desc "Fast clipboard image saving for macOS"
  homepage "https://github.com/RunnyC/clipboard-image-saver"
  url "https://github.com/RunnyC/clipboard-image-saver/releases/download/v1.0.2/pasteimage-macos.tar.gz"
  sha256 "8366b3c09f03dc3c0cf75293dfd28e56ba9785b43b4f5f352cb0f613cfbbdb03"
  license "MIT"

  depends_on :macos

  def install
    bin.install "pasteimage"
  end

  test do
    system "#{bin}/pasteimage", "--help" 2>&1
  end
end