# Educorreia932's Dotfiles

My current Linux dotfiles and scripts.

For the moment, these are the configurations I use in my OS/WSL, but this repository aims to provide a way to port them easily to other systems.

These are managed using [Dotbot](https://github.com/anishathalye/dotbot) and its [apt-get](https://github.com/dein0s/dotbot_plugin_aptget) plugin].

## 💻 System Information

These are some of the applications that I use in my current setup.

- **Distribution:** Ubuntu
- **Window Manager:** i3-gaps
- **Shell:** bash
- **Terminal:** Alacritty
- **Text Editor:** NeoVim

## 📄 Instructions

```sh
./install
sudo ./install -p dotbot_plugin_aptget/aptget.py -c packages.conf.yaml
```

A Dockerfile is also included to test the configurations in a fresh environment.

```sh
docker build -t dotfiles . 
docker run --rm -t -i dotfiles
```

## 📷 Screenshot

![Preview](preview.png)
