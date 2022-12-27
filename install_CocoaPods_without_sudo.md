1. Install homebrew via this command `mkdir homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew`
2. After successful installation of brew `eval "$(homebrew/bin/brew shellenv)"
brew update --force --quiet
chmod -R go-w "$(brew --prefix)/share/zsh"`
3.Install CocoaPods via this command `brew install cocoapods`

reference
1.https://www.youtube.com/watch?v=Hg7ukb5oxSA // How to Install CocoaPods With Gem or With Homebrew
2.https://www.youtube.com/watch?v=RT8Rh8yJy-w //Install Homebrew Without Sudo (macOS)
3.https://docs.brew.sh/Installation#untar-anywhere-unsupported
3.https://guides.cocoapods.org/using/getting-started.html#installation