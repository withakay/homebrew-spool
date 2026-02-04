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
      sha256 "356125cc7df1354080190e62ebf24bd1970e5cea002061395fee95da83a6bcb3"
    end

    on_linux do
      url "https://github.com/withakay/spool/releases/download/v0.22.2/spool-v0.22.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7ad8f4f73c069a3f8e71950f3609166a3327019c40e70b60c2a2106ff61ed67b"
    end
  end

  on_arm do
    on_macos do
      url "https://github.com/withakay/spool/releases/download/v0.22.2/spool-v0.22.2-aarch64-apple-darwin.tar.gz"
      sha256 "ea244adb38e293ad6ced9e92e4a5721b6a24ab87953230256de311a968b68772"
    end

    on_linux do
      url "https://github.com/withakay/spool/releases/download/v0.22.2/spool-v0.22.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2bd67694b4de7be254a8b00d68af2c2652552b4ca2bc1b7c9a021bed8c9d4644"
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
