cask "citebar" do
  version "1.6.4,20261009"
  sha256 "43485779d540adee6601ca856778af1b0590d49a631d4d849e40418625a4695a"

  url "https://github.com/hichipli/CiteBar/releases/download/v#{version.csv.first}/CiteBar-#{version.csv.first}-universal-#{version.csv.second}.dmg"
  name "CiteBar"
  desc "Menu bar app for Google Scholar citations"
  homepage "https://www.citebar.org/"

  livecheck do
    url :url
    regex(/^CiteBar[._-]v?(\d+(?:\.\d+)+)[._-]universal[._-](\d+)\.dmg$/i)
    strategy :github_latest do |json, regex|
      json["assets"]&.map do |asset|
        match = asset["name"]&.match(regex)
        next if match.blank?

        "#{match[1]},#{match[2]}"
      end
    end
  end

  auto_updates true
  depends_on macos: :ventura

  app "CiteBar.app"

  zap trash: [
    "~/Library/Application Support/CiteBar",
    "~/Library/Caches/com.hichipli.citebar",
    "~/Library/HTTPStorages/com.hichipli.citebar",
    "~/Library/Preferences/com.hichipli.citebar.plist",
  ]
end
