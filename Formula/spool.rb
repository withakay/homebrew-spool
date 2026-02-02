# typed: false
# frozen_string_literal: true

class Spool < Formula
  desc "Spec-driven workflow management for AI-assisted development"
  homepage "https://github.com/withakay/spool"
  url "https://github.com/withakay/spool/archive/refs/tags/v0.20.8.tar.gz"
  sha256 "PLACEHOLDER_SHA256"
  license "MIT"
  head "https://github.com/withakay/spool.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "rust" => :build

  def install
    cd "spool-rs" do
      system "cargo", "install", *std_cargo_args(path: "crates/spool-cli")
    end
  end

  test do
    output = shell_output("#{bin}/spool --version")
    # HEAD builds use local version format, stable builds match the tag version
    if build.head?
      assert_match(/^\d+\.\d+\.\d+/, output)
    else
      assert_match version.to_s, output
    end
  end
end
