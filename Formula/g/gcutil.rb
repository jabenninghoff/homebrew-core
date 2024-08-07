class Gcutil < Formula
  desc "Manage your Google Compute Engine resources"
  homepage "https://cloud.google.com/sdk/gcloud/reference/compute"
  url "https://dl.google.com/dl/cloudsdk/release/artifacts/gcutil-1.16.1.zip"
  sha256 "31f438c9ce3471f1404340e3411239b28b63f117d17776271fee1e1a352f3877"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "e5de2c3ea2450af30d6797f821b9ccb3c3da8c47f3086f1c2ccb063e91e9c68c"
  end

  # deprecate in favor of gcloud compute
  # ref, https://cloud.google.com/compute/docs/gcloud-compute/transition-gcloud-gcutil
  disable! date: "2023-08-29", because: :unmaintained

  def install
    libexec.install "gcutil", "lib"
    bin.install_symlink libexec/"gcutil"
  end

  test do
    system bin/"gcutil", "version"
  end
end
