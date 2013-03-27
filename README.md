# &#9763; Infect

Bundle manager for [pathogen](https://github.com/tpope/vim-pathogen).

Manage your entire vim config with a single '.vimrc' file. Much the same way that [sprockets](https://github.com/sstephenson/sprockets) lets you include web assets, infect will handle install vim plugins for you.

## Installation

Infect has no dependencies other than a recentish version of ruby. And can be installed as a standalone script, perhaps in your `~/bin` directory.

    $ curl https://raw.github.com/csexton/infect/master/standalone/infect > ~/bin/infect && chmod +x ~/bin/infect

Or if you prefer to manage it at a gem:

    $ gem install infect

## Objective

The point of Infect it to make it easy to manage your vim config. You should be able to check in your `.vimrc` into source control and use that one file to easily install any plugins you need.

## Usage

Infect reads your `.vimrc` file and looks for magic comments. It uses those to install pathogen style vim bundles. A minimal `.vimrc` to use with infect would look like this:

    "=bundle tpope/vim-pathogen
    "=bundle tpope/vim-sensible
    source ~/.vim/bundle/vim-pathogen/autoload/pathogen.vim
    execute pathogen#runtime_append_all_bundles()
    syntax on
    filetype plugin indent on

Just put those lines at the top of your vimrc and infect will install pathogen and the bundles for you.

