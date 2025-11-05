# Publishing Guide

## GitHub

1. Ensure `main` contains the latest changes:
   ```bash
   git push origin main
   ```

## Releases

1. Update `CHANGELOG.md` and docs.
2. Package the script:
   ```bash
   make release VERSION=0.1.0
   ```
3. Create a GitHub release `v0.1.0` and upload `dist/wt-0.1.0.zip`.

## Homebrew Cask

1. Fork or create a tap repo (e.g. `github.com/USERNAME/homebrew-tap`).
2. Copy `homebrew/Casks/wt.rb` into `Casks/` inside the tap repo.
3. Replace `USERNAME/REPO`, `version`, and `sha256` with the real release values:
   ```ruby
   cask "wt" do
     version "0.1.0"
     sha256 "<zip sha256 from dist/wt-0.1.0.zip.sha256>"

     url "https://github.com/USERNAME/wt/releases/download/v#{version}/wt-#{version}.zip"
     ...
   end
   ```
4. Push the tap and run `brew install --cask wt` to verify.
