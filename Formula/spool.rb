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
      sha256 "5f82520ef74e28acd75bd13636b32dde2c0185c8a3948e10697802b7f7429713"
    end

    on_linux do
      url "https://github.com/withakay/spool/releases/download/v0.21.1/spool-v0.21.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "01f7298053213f06f28ec11d22c1985d811300b255d0e45a742243569497fdf1"
    end
  end

  on_arm do
    on_macos do
      url "https://github.com/withakay/spool/releases/download/v0.21.1/spool-v0.21.1-aarch64-apple-darwin.tar.gz"
      sha256 "67502b7130824854c2b34c4b9d3169f6da1fdaa05102861af3d0a1bf4611877f"
    end

    on_linux do
      url "https://github.com/withakay/spool/releases/download/v0.21.1/spool-v0.21.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "127c4d2740903280e96616ec630c747ad426f2837faace1d7442ec3d6e445b62"
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
