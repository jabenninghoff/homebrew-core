class Rio < Formula
  desc "Hardware-accelerated GPU terminal emulator powered by WebGPU"
  homepage "https://raphamorim.io/rio/"
  url "https://github.com/raphamorim/rio/archive/refs/tags/v0.2.3.tar.gz"
  sha256 "92a42c41d76d133b7e32644c89522f2e1223eeb2c65b3f07d99094fe1d5aade5"
  license "MIT"
  head "https://github.com/raphamorim/rio.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7074f4068734eefaa5ff08ad2496eb34d78825cb86d6d7091b57e4eac1f254f6"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "959781c65969a20abb90d2d5e6aad5ea75f3d15662c3825d95ee135250e796a8"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "90811ac1123c36b48961a863cb1fdd268a2da591720a51245b244d14290f204f"
    sha256 cellar: :any_skip_relocation, sonoma:        "62fb690aa9ac6c849161db67ae0b7daa83fa44136bf501b12565fdc77d498075"
    sha256 cellar: :any_skip_relocation, ventura:       "536ac8e9b21e2228ae7456ebc3415dffd53a3a5ae7191863574d78b328557de7"
  end

  depends_on "rust" => :build
  # Rio does work for Linux although it requires a specification of which
  # window manager will be used (x11 or wayland) otherwise will not work.
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args(path: "frontends/rioterm")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rio --version")
    return if Hardware::CPU.intel? && ENV["HOMEBREW_GITHUB_ACTIONS"].present?

    # This test does pass locally for x86 but it fails for containers
    # which is the case of x86 in the CI

    system bin/"rio", "-e", "touch", testpath/"testfile"
    assert_predicate testpath/"testfile", :exist?
  end
end
