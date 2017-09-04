default: install

dependencies:
	sh macos/install-homebrew.sh
	pushd macos; brew bundle; popd;

install: dependencies
