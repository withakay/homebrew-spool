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
      sha256 "60fac479b51d446fa1de8087ddc75246ba3aed2928f8c7e794222ddfee93e1ce"
    end

    on_linux do
      url "https://github.com/withakay/spool/releases/download/v0.21.1/spool-v0.21.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "63e762d2dd366b543d3337ef8796d39eaf763e08cfb7b6d586884eefceb14448"
    end
  end

  on_arm do
    on_macos do
      url "https://github.com/withakay/spool/releases/download/v0.21.1/spool-v0.21.1-aarch64-apple-darwin.tar.gz"
      sha256 "439569e56e76c592e30bb817257130a3430f53f117461e9d5d02d0207e2a1637"
    end

    on_linux do
      url "https://github.com/withakay/spool/releases/download/v0.21.1/spool-v0.21.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "554ed18c972296e2e3286a85ecac64156ff627ce7350a6fa1eecc7a68ea74e0e"
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
