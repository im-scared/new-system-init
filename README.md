## Introduction
A simple guide (and example of configuration) to install i3 and its and essentials packages and make them look eye candy, 
or at least make them not ugly :grin:

Example configuration in this repo is pretty simple, minimal, and easy to be understood, without reducing the usability.
Only contains about 140 lines of i3 configuration, pretty stock without any custom script, custom packages, and custom patch.
This is my daily i3 configuration by the way. 
And this configuration only use packages that available on most Distros main repository.
So You don't need AUR, PPA, xbps-src, or sudo make install. 

I'm using Debian, with i3 stock metapackages (i3wm, i3bar, i3status, i3lock, i3-sensible-terminal, and i3-dmenu-desktop), so does this guide.
Hence I name this repo *i3-starterpack*.
So, the installation guide here will use Debian command & package name. <br />

## Installation
To install, run the following script:
```bash
curl https://github.com/im-scared/new-system-init/raw/main/install.sh | bash
```

- **First, install i3 of course** <br />
`sudo apt-get install i3` <br />
It will give You i3-wm, dunst, i3lock, i3status, and suckless-tools.
If i3-wm, dunst, i3lock, i3status, and suckless-tools are not installed automatically, just install them manually. <br />
`sudo apt-get install i3-wm dunst i3lock i3status suckless-tools` <br />

- **Then install some additional packages to make your desktop enjoyable** <br />
`sudo apt-get install compton hsetroot rxvt-unicode xsel rofi fonts-noto fonts-mplus xsettingsd lxappearance scrot viewnior`

## Explanations of Additional Packages
- Compton is a compositor to provide some desktop effects like shadow, transparency, fade, and transiton. 
- Hsetroot is a wallpaper handler. i3 has no wallpaper handler by default.
- URxvt is a lightweight terminal emulator, part of *i3-sensible-terminal*.
- Xsel is a program to access X clipboard. We need it to make copy-paste in URxvt available. Hit Alt+C to copy, and Alt+V to paste. 
- Rofi is a program launcher, similar with dmenu but with more options.
- Noto Sans and M+ are my favourite fonts used in my configuration.
- Xsettingsd is a simple settings daemon to load fontconfig and some other options. Without this, fonts would look rasterized in some applications.
- LXAppearance is used for changing GTK theme icons, fonts, and some other preferences.
- Scrot is for taking screenshoot. I use it in my configuration for Print Screen button.
I set my Print Screen button to take screenshoot using scrot, then automatically open it using Viewnior image viewer. <br />

