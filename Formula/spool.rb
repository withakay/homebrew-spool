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
      sha256 "f287fe794ca1eee182749e23daa5a99a0a648e897210d17cfdf5a2b184996287"
    end

    on_linux do
      url "https://github.com/withakay/spool/releases/download/v0.21.1/spool-v0.21.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e8ad1403d8f51f0e701bf5fd9f7b3f92fdf86b6e408fe8bf9fce44f8710515a8"
    end
  end

  on_arm do
    on_macos do
      url "https://github.com/withakay/spool/releases/download/v0.21.1/spool-v0.21.1-aarch64-apple-darwin.tar.gz"
      sha256 "e9cfe13d53c0305a4ba4ffa8251b1f12767febb9fac5cb290ccc13e3ce9ffaa3"
    end

    on_linux do
      url "https://github.com/withakay/spool/releases/download/v0.21.1/spool-v0.21.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e01c17df62d8f688b034f28401e34f11e2b88b3533f771fab78d1d873372f93e"
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
