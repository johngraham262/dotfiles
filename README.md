# dotfiles
Coding configs to help me be more productive.

These files generally exist in your home directory, `cd ~/`.

### Setup

I started using `zsh` instead of `bash`. Here's how to get set up on `zsh`:

1. Copy `.vimrc` to your home directory (for me it's `~/`).
2. Copy `.zshrc` to your home directory (same as above).
3. Open a new zsh window (or `source ~/.zshrc`)
4. Run `brew install universal-ctags`
5. Open up an instance of `vim` and while in normal mode, run `:PlugInstall` to install vim plugins

### Appendix

`.zshrc` manages your zsh configs if you swich from bash to zsh, like I did.

`.bash_profile` manages your bash prompt.

`.inputrc` manages input, like auto-completion with up-arrow.

`.tmux.conf` manages your tmux configurations. Default tmux key bindings are confusing.

`.vimrc` manages your vim configurations. I use [vim plug](https://github.com/junegunn/vim-plug) to manage vim plugins.

`vscode` directory contains settings for the vscode IDE.

`.xvimrc` somewhat manages a vim port to Xcode.

`init.vim` lives in `~/.config/nvim/init.vim` (first need to install `brew install neovim`). I haven't gotten around to fully switching to neovim yet though.
