# &#9763; Infect

Bundle manager for [Pathogen](https://github.com/tpope/vim-pathogen).

Manage your entire vim config with a single `.vimrc` file. Much the same way that [sprockets](https://github.com/sstephenson/sprockets) lets you include web assets, infect will handle install vim plugins for you.

## Installation

Infect has no dependencies other than a recentish version of ruby. And can be installed as a standalone script, perhaps in your `~/bin` directory.

    $ curl https://raw.github.com/csexton/infect/master/standalone/infect > ~/bin/infect && chmod +x ~/bin/infect

Or if you prefer to manage it at a gem:

    $ gem install infect

## Objective

The point of Infect it to make it easy to manage your vim config. You should be able to check in your `.vimrc` into source control and use that one file to easily install any plugins you need.

## Rationale

Why invent another way of managing vim plugins?

* I want to be able to use my `.vimrc` when without installing plugins.
* I like having simple command line apps to manage my setup.
* I wanted to use pathogen to do the loading.
* I was tired of managing git submodules, nor did I find it very scalable.


Vundle is really slick, much nicer now than when I used it a few years ago. But I had two main problems with it:

* The `vimrc` is not usable unless vundle is installed. You will get errors on the config lines if you try to run vim with out the vundle plugin no installed. This is probably not normally a problem for most people, but I like to be able to scp my `.vimrc` to servers to get a basic configuration up there, but don't want to worry about installing the plugins.
* Vundle was slower than pathogen to load. Not sure if this is still the case, but at one point it added a noticable delay in loading vim.
* I don't really want to use my editor for installing stuff. Bram said "Each program has its own task and should be good at it" and think installing bundles is better suited for a command line script.

Like I said, [Vundle](https://github.com/gmarik/vundle) is really nice, quite polished and active. Just not for me, you may want to check it out.


## Usage

Infect reads your `.vimrc` file and looks for magic comments. It uses those to install pathogen style vim bundles. A minimal `.vimrc` to use with infect would look like this:

    "=bundle tpope/vim-pathogen
    "=bundle tpope/vim-sensible
    source ~/.vim/bundle/vim-pathogen/autoload/pathogen.vim
    execute pathogen#runtime_append_all_bundles()
    syntax on
    filetype plugin indent on

Just put those lines at the top of your vimrc and infect will install pathogen and the bundles for you.

