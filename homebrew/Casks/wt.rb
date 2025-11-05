cask "wt" do
  version "0.1.1"
  sha256 "ce2c3ec3b1771295422816c73ffe14ba7873899144124f69f1a2c3568d9fc41d"

  url "https://github.com/nrempel/wt/releases/download/v#{version}/wt-#{version}.zip"
  name "wt"
  desc "Friendly wrapper around git worktrees"
  homepage "https://github.com/nrempel/wt"

  binary "wt"
end
