<p align="center">
  <img width="100%" src="https://cdn.discordapp.com/attachments/282207139752050688/664674681701531654/unknown.png" alt="KDE with compoton for sexy transparency">
  <img width="100%" src="https://cdn.discordapp.com/attachments/282207139752050688/729264536212733952/unknown.png" alt="Gnome + Budgie = awesome!">
</p>

*Screenshot of my setup. Click to see a larger preview.*

# dotfiles

> My personal dotfiles for \*nix.

This includes all of my dotfiles I use on all my \*nix systems (including but not limited to: Ubuntu, Arch, Pop!\_OS, macOS, WSL).

*Disclaimer: Please keep in mind that some of these scripts / configs are things that I made years ago and have yet to update with all of my new scripting knowledge. Additionally, not everything will work on everyone's system, although I am trying to make these scripts as portable as possible (since I want to be able to automatically deploy my scripts to new machines in the future!).*

## Software

* **Terminal:** urxvt
* **Font:** [Iosevka Nerd Font](https://www.nerdfonts.com/)
* **Multiplexer:** tmux
* **Editor:** neovim
* **IDE:** IntelliJ IDEA / WebStorm
* **Music:** Spotify
* **Chat:** Discord
* **Browser:** Google Chrome

## [Wallpapers](WALLPAPERS.md)

## Setup

In order to set up all these config files for yourself, simply clone the repository and run the `setup.sh` script. Example:

```bash
git clone https://github.com/Rayzr522/dotfiles.git
cd dotfiles
# if you're not on linux or don't want to install system dependencies, skip this:
./scripts/install-system-deps.sh
./setup.sh
```

*Note: running `./setup.sh` with the `-f` flag will cause it to blindly overwrite existing config files without prompting. Only do so if you know what you are doing.

## Other Personal Scripts

These are other personal scripts / tools that I made which I use in conjunction with the config files that are here.

- [mcsm](https://github.com/Rayzr522/MinecraftServerManager)
- [server-essentials](https://github.com/Rayzr522/server-essentials)
- [printy](https://github.com/Rayzr522/Printy)

## Join Me

[![Discord Badge](https://github.com/Rayzr522/ProjectResources/raw/master/RayzrDev/badge-small.png)](https://rayzr.dev/join)
