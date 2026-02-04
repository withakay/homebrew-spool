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
      sha256 "4c10dec1875c633e413726f676c71a80ae4cc153e7aa942aae9b188eadd2d757"
    end

    on_linux do
      url "https://github.com/withakay/spool/releases/download/v0.22.2/spool-v0.22.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "998fbc7ecbe19d9e94aeb05f8578d280ebcdeb039047b492b09c504dace22bef"
    end
  end

  on_arm do
    on_macos do
      url "https://github.com/withakay/spool/releases/download/v0.22.2/spool-v0.22.2-aarch64-apple-darwin.tar.gz"
      sha256 "074e3d35e188ee8309685c5cb93139c859bf31782ffb722459b046f973a7cbef"
    end

    on_linux do
      url "https://github.com/withakay/spool/releases/download/v0.22.2/spool-v0.22.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2e8275df13a33df84eb981aa90fd842d03e3d6122504ddf2e3bd2793aae33e2e"
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
