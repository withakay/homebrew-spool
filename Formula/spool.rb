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
      sha256 "734d7048c5229cfa2a52673b1d50272b53f8431a1a4346842f53c0ac0d408217"
    end

    on_linux do
      url "https://github.com/withakay/spool/releases/download/v0.22.2/spool-v0.22.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0a17a66c05d0032a39718f5fb5de74fbf6ce54fe7b3666c81512302b3f321714"
    end
  end

  on_arm do
    on_macos do
      url "https://github.com/withakay/spool/releases/download/v0.22.2/spool-v0.22.2-aarch64-apple-darwin.tar.gz"
      sha256 "f0682ae9e8bf017547447d9db1c67a0c28d55ea5660426be583b0ce25d3b5f29"
    end

    on_linux do
      url "https://github.com/withakay/spool/releases/download/v0.22.2/spool-v0.22.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f271bb79a321513c0fa0cf17d3862b81d3d024b7f93a806e0506fe327e762ae6"
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
