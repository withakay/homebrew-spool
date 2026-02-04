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
      sha256 "6f927181f70012a8a85db1b1a70d63f70c2c3ed568725dd1cdce16026d99856d"
    end

    on_linux do
      url "https://github.com/withakay/spool/releases/download/v0.22.2/spool-v0.22.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1f92d9eb43d2bd16d1a40b27a7f65548f1040feffd01a197a5971d543f2788cc"
    end
  end

  on_arm do
    on_macos do
      url "https://github.com/withakay/spool/releases/download/v0.22.2/spool-v0.22.2-aarch64-apple-darwin.tar.gz"
      sha256 "6442fbb0ff006796a6cd41355d16da6f83d4a6b4246147b3f646f423c06cc8cf"
    end

    on_linux do
      url "https://github.com/withakay/spool/releases/download/v0.22.2/spool-v0.22.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e2fd96ed4cb0450e4c7a45752d1462624fc482180d5be2d4229eb08dcb87795f"
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
