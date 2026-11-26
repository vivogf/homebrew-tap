cask "softclick" do
  version "1.0.0"
  sha256 "2d89b7c6c1185cf7575c0e12c6bb8007d8f2c7c05e651ff5c50c7a17a622e968"

  url "https://github.com/vivogf/SoftClick/releases/download/v#{version}/SoftClick.zip"
  name "Soft Click"
  desc "Softer haptic click for the built-in Force Touch trackpad"
  homepage "https://github.com/vivogf/SoftClick"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "SoftClick.app"

  # The app is ad-hoc signed, not notarized.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/SoftClick.app"],
        writable_paths: ["SoftClick.app"],
        writable_base:  :appdir
  end

  # Quitting normally lets the app restore the stock trackpad click.
  uninstall quit: "io.github.vivogf.SoftClick"

  zap trash: [
    "~/Library/Application Support/SoftClick",
    "~/Library/Preferences/io.github.vivogf.SoftClick.plist",
  ]

  caveats <<~EOS
    Soft Click needs Input Monitoring access to know when you click:
      System Settings → Privacy & Security → Input Monitoring

    After every update, remove it from that list and allow it again.
  EOS
end
