<h1 style="font: normal normal 80px/90px LeagueGothic,'Helvetica Neue',Helvetica,sans-serif;color:#dedede;padding:0;margin:32px 0 0 0;text-shadow:0 2px 3px rgba(40,41,42,0.6),0 4px 0 rgba(150,150,150,0.5),0 9px 5px rgba(0,0,0,0.5);"> <span font-size:100px;">&#9763;</span> Infect</h1>

Asset Pipeline Bundler for Vim and Pathogen

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

