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
      sha256 "c018fdcab491e7e86cd086ea63261c8060e530b2b207474ef86b9b38fc2373b5"
    end

    on_linux do
      url "https://github.com/withakay/spool/releases/download/v0.21.1/spool-v0.21.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "22ab445abbba5c4f7d4e8448ca9a75b604db2a49f4e9b76f3ef943455e6c2e19"
    end
  end

  on_arm do
    on_macos do
      url "https://github.com/withakay/spool/releases/download/v0.21.1/spool-v0.21.1-aarch64-apple-darwin.tar.gz"
      sha256 "324d6da7c1041544331cd16a3e99f442484db5977428060e944b43e2bc26b4fd"
    end

    on_linux do
      url "https://github.com/withakay/spool/releases/download/v0.21.1/spool-v0.21.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f7fc1a4e00b91740d84d1db1e1a16db9b546d0ca864c156a38a424b8fbdd984a"
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
