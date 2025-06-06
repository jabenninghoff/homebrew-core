class AmdatuBootstrap < Formula
  desc "Bootstrapping OSGi development"
  homepage "https://bitbucket.org/amdatuadm/amdatu-bootstrap/"
  url "https://bitbucket.org/amdatuadm/amdatu-bootstrap/downloads/bootstrap-bin-r9.zip"
  sha256 "937ef932a740665439ea0118ed417ff7bdc9680b816b8b3c81ecfd6d0fc4773b"
  license "Apache-2.0"
  revision 2

  livecheck do
    url "https://bitbucket.org/amdatuadm/amdatu-bootstrap/downloads/"
    regex(/href=.*?bootstrap[._-]v?(?:bin-)?r(\d+(?:\.\d+)*)(?:-bin)?\./i)
  end

  no_autobump! because: :requires_manual_review

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, all: "0094a50b87c8bf6f25f9fc0e68bcb95a2c46923a240eb83210748a280ee8cd27"
  end

  depends_on "openjdk@8"

  def install
    env = Language::Java.java_home_env("1.8")
    # Add java to PATH to fix Linux issue: amdatu-bootstrap: line 35: java: command not found
    env["PATH"] = "$JAVA_HOME/bin:$PATH"
    # Use bash to avoid issues with shells like dash: amdatu-bootstrap: 34: [: --info: unexpected operator
    inreplace "amdatu-bootstrap", %r{^#!/bin/sh$}, "#!/bin/bash"

    libexec.install %w[amdatu-bootstrap bootstrap.jar conf]
    (bin/"amdatu-bootstrap").write_env_script libexec/"amdatu-bootstrap", env
  end

  test do
    output = shell_output("#{bin}/amdatu-bootstrap --info")
    assert_match "Amdatu Bootstrap R9", output
  end
end
