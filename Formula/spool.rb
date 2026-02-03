# typed: false
# frozen_string_literal: true

class Spool < Formula
  desc "Spec-driven workflow management for AI-assisted development"
  homepage "https://github.com/withakay/spool"
  license "MIT"
url "https://github.com/withakay/spool/archive/refs/tags/v0.21.1.tar.gz"
sha256 "2801c28e0241c2e53af84e417c40c5b017afe1b1ecace1cbfc8b52b9ef2f5633"
  head "https://github.com/withakay/spool.git", branch: "main"

  # Stable version will be added automatically when first release is published
  # url "https://github.com/withakay/spool/archive/refs/tags/vX.Y.Z.tar.gz"
  # sha256 "..."

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
    assert_match(/^\d+\.\d+\.\d+/, output)
  end
end
