# typed: false
# frozen_string_literal: true

class Spool < Formula
  desc "Spec-driven workflow management for AI-assisted development"
  homepage "https://github.com/withakay/spool"
  license "MIT"
  version "0.24.0-local.202602051036"

  on_intel do
    on_macos do
      url "https://github.com/withakay/spool/releases/download/v0.24.0-local.202602051036/spool-v0.24.0-local.202602051036-x86_64-apple-darwin.tar.gz"
      sha256 "30548a607d822fde81cc5a5302c15fc347b772f5062f3923818b0ba43368db8f"
    end

    on_linux do
      url "https://github.com/withakay/spool/releases/download/v0.24.0-local.202602051036/spool-v0.24.0-local.202602051036-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bb2accd2a74daf1660367b445b64626b4cecadc6c801891354599a309b8d5e62"
    end
  end

  on_arm do
    on_macos do
      url "https://github.com/withakay/spool/releases/download/v0.24.0-local.202602051036/spool-v0.24.0-local.202602051036-aarch64-apple-darwin.tar.gz"
      sha256 "96e8af02bb2a6c10bbb8cfc880bceeda22dcf05e3389f257f9e2abbfb0d79f3d"
    end

    on_linux do
      url "https://github.com/withakay/spool/releases/download/v0.24.0-local.202602051036/spool-v0.24.0-local.202602051036-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f416db009564d0e2148b0b0df2dd852ef28156a62b96c957e1377211c9ef9e18"
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
