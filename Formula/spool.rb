# typed: false
# frozen_string_literal: true

class Spool < Formula
  desc "Spec-driven workflow management for AI-assisted development"
  homepage "https://github.com/withakay/spool"
  license "MIT"
  version "0.21.1"

  on_intel do
    on_macos do
      url "https://github.com/withakay/spool/releases/download/v0.21.1/spool-v0.21.1-x86_64-apple-darwin.tar.gz"
      sha256 "b7ca0b86d80de99e141c8de9cfe1a291278c8633ebdec3d8578fad49cd5772c6"
    end

    on_linux do
      url "https://github.com/withakay/spool/releases/download/v0.21.1/spool-v0.21.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d362b01b49a3314eea71970a4f6461ae33567d4940733c626a03bf0231493a25"
    end
  end

  on_arm do
    on_macos do
      url "https://github.com/withakay/spool/releases/download/v0.21.1/spool-v0.21.1-aarch64-apple-darwin.tar.gz"
      sha256 "7a71e5f08f59ce348405d8754d744d62bfc679b3318a357ef41c5cc7ffbb76dd"
    end

    on_linux do
      url "https://github.com/withakay/spool/releases/download/v0.21.1/spool-v0.21.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "885f2c73bf09c72471d28cbabf5b5e011d785e5111e7e14230692e99005ba3b8"
    end
  end

  head "https://github.com/withakay/spool.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  head do
    depends_on "rust" => :build
  end

  def install
    if build.head?
      cd "spool-rs" do
        system "cargo", "install", *std_cargo_args(path: "crates/spool-cli")
      end
    else
      bin.install "spool"
    end
  end

  test do
    output = shell_output("#{bin}/spool --version").strip
    if build.head?
      assert_match(/^\d+\.\d+\.\d+/, output)
    else
      assert_match(/^#{Regexp.escape(version.to_s)}$/, output)
    end
  end
end
