class Pasteimage < Formula
  desc "Fast clipboard image saving for macOS"
  homepage "https://github.com/RunnyC/clipboard-image-saver"
  url "https://github.com/RunnyC/clipboard-image-saver/releases/download/v1.1.0/pasteimage-macos.tar.gz"
  sha256 "4648ae53a393ce6fd967604606ce88858a116f4290b0296f6d434e56b5f24a4c"
  license "MIT"

  depends_on :macos

  def install
    bin.install "pasteimage"
  end

  test do
    system bin/"pasteimage", "--help"
    system bin/"pasteimage", "--version"
  end
end