# typed: false
# frozen_string_literal: true

class Spool < Formula
  desc "Spec-driven workflow management for AI-assisted development"
  homepage "https://github.com/withakay/spool"
  license "MIT"
  version "0.22.1"

  on_intel do
    on_macos do
      url "https://github.com/withakay/spool/releases/download/v0.22.1/spool-v0.22.1-x86_64-apple-darwin.tar.gz"
      sha256 "1c7c4d41264deb0ec5f04c6c858cbffa6384e5d4fc856c1329c5444a2b30a74a"
    end

    on_linux do
      url "https://github.com/withakay/spool/releases/download/v0.22.1/spool-v0.22.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bb9dc36968696bf7266f28b4cba9d084a34d17e9ed2ef0308f46434032a96794"
    end
  end

  on_arm do
    on_macos do
      url "https://github.com/withakay/spool/releases/download/v0.22.1/spool-v0.22.1-aarch64-apple-darwin.tar.gz"
      sha256 "0384a4f222a7ae46bf700facc2075fff51affa2f1494ccfdb37c746f692bc399"
    end

    on_linux do
      url "https://github.com/withakay/spool/releases/download/v0.22.1/spool-v0.22.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "301aadf9c005e345b5782ed44f6bdf4a05ae6d7fcaa26a72669d2bcc97a5e978"
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
