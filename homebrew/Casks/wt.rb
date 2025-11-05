cask "wt" do
  version "0.1.0"
  sha256 "REPLACE_WITH_SHA256"

  url "https://github.com/USERNAME/REPO/releases/download/v#{version}/wt-#{version}.zip"
  name "wt"
  desc "Friendly wrapper around git worktrees"
  homepage "https://github.com/USERNAME/REPO"

  binary "wt"
end
