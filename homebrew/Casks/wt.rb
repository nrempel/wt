cask "wt" do
  version "0.1.0"
  sha256 "5cc8003a5bcc743dcfcd09a9a62479f83eb01db66c4dc29d552f3cfceb022265"

  url "https://github.com/nrempel/wt/releases/download/v#{version}/wt-#{version}.zip"
  name "wt"
  desc "Friendly wrapper around git worktrees"
  homepage "https://github.com/nrempel/wt"

  binary "wt"
end
