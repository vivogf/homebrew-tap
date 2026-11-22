cask "threefingerminimize" do
  version "1.0.0"
  sha256 "SHA256"

  url "https://github.com/vivogf/ThreeFingerMinimize/releases/download/v#{version}/ThreeFingerMinimize.zip"
  name "ThreeFingerMinimize"
  desc "Minimize the focused window by swiping down with three fingers"
  homepage "https://github.com/vivogf/ThreeFingerMinimize"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :ventura"

  app "ThreeFingerMinimize.app"

  # The app is ad-hoc signed, not notarized.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/ThreeFingerMinimize.app"]
  end

  uninstall quit: "io.github.vivogf.ThreeFingerMinimize"

  zap trash: [
    "~/Library/Logs/ThreeFingerMinimize.log",
    "~/Library/Preferences/io.github.vivogf.ThreeFingerMinimize.plist",
  ]

  caveats <<~EOS
    ThreeFingerMinimize needs Accessibility access to minimize windows:
      System Settings → Privacy & Security → Accessibility

    After every update, remove it from that list and allow it again.
  EOS
end
