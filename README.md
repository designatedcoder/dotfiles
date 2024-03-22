# dotfiles 
My personal \*neovim configuration files.

**1. Neovim Configuration**

This repository contains my personal Neovim configuration as a mainly Laravel developer with some Vue included as I use that mostly for frontend.
### Please keep in mind that this is my own personal setup for my own personal workflow in my own personal dev environment.  These files are meant to only be some insight into my workflow and to give you ideas for your own. I have no interest in changing my setup to suit your needs.  I will, of course keep this updated to suit my own needs.

### Usage

1. Config requirements:

    Because this is specifically for Laravel development with Vue3, you should make sure that the environment you will use has php, composer and npm installed.


2. Clone this repository to your local machine:

    ```bash
    git clone https://github.com/designatedcoder/dotfiles
    ```

3. Install Neovim:

    Follow the installation instructions provided on the [Neovim website](https://neovim.io/).

4. Install ripgrep:

    Ensure that you have ripgrep installed on your system. You can install it via your package manager or download it from the [ripgrep GitHub repository](https://github.com/BurntSushi/ripgrep).

5. Install a Nerd Font:

    I recommend using a font from [Nerd Fonts](https://www.nerdfonts.com/) to ensure proper display of icons and glyphs in Neovim. Download and install your preferred Nerd Font. *Do this if you have trouble with icons in neo-tree*.

6. Set up Neovim:

    Backup your `~/.config/nvim` folder, then replace `nvim` folder with the `nvim` folder inside this repo. Also, make sure to change name of folder with my name with your own.  I don't care of if you use a username or not, just persornalize is somehow for yourself. 

7. Launch Neovim:

    Open Neovim. It will automatically install any missing plugins and apply the configuration.
    
8. Tmux:

    I'm also including my tmux config for the truly brave of heart.

Feel free to explore the configuration files to understand how different plugins are configured and integrated.
