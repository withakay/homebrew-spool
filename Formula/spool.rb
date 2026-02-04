# typed: false
# frozen_string_literal: true

class Spool < Formula
  desc "Spec-driven workflow management for AI-assisted development"
  homepage "https://github.com/withakay/spool"
  license "MIT"
  version "0.22.2"

  on_intel do
    on_macos do
      url "https://github.com/withakay/spool/releases/download/v0.22.2/spool-v0.22.2-x86_64-apple-darwin.tar.gz"
      sha256 "954fd6c76db1110bc9fc4f3c08dbd6ecb142cb342594dec012f65207c98d0d3e"
    end

    on_linux do
      url "https://github.com/withakay/spool/releases/download/v0.22.2/spool-v0.22.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8b5f117e9b8828431141418095ed5ef8856093a4b551743613662ef196327c9c"
    end
  end

  on_arm do
    on_macos do
      url "https://github.com/withakay/spool/releases/download/v0.22.2/spool-v0.22.2-aarch64-apple-darwin.tar.gz"
      sha256 "72b28f8d1e4216b87793f742b21e51dc7fabba5499fd519a6ea0d4185117d2ef"
    end

    on_linux do
      url "https://github.com/withakay/spool/releases/download/v0.22.2/spool-v0.22.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e31a938c07a4783f028d3e9369fc81cd05031a22352ae0fed2d0f350a9fa7721"
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
