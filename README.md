# &#9763; Infect

Package manager for [Vim 8](https://github.com/vim/vim/blob/master/runtime/doc/version8.txt#L97-L103).

The only package manager that makes no impact on start up time.

Manage your entire vim config with a single `.vimrc` file, while keeping the `.vimrc` file functional on systems with out any custom plugins installed, or with older versions of Vim.

## Installation

Infect has no dependencies other than a recentish version of ruby. And can be installed as a standalone script, perhaps in your `~/bin` directory.

    $ curl https://raw.githubusercontent.com/csexton/infect/master/standalone/infect > ~/bin/infect && chmod +x ~/bin/infect

Or if you prefer to manage it at a gem:

    $ gem install infect

## Objective

The point of Infect it to make it easy to manage your vim config. You should be able to check in your `.vimrc` into source control and use that **one** file to easily install any plugins or packages you need.

## Rationale

Why invent another way of managing vim plugins?

* I want to **be able** to use my `.vimrc` when without installing plugins.
* I like having simple command line apps to manage my setup.
* I wanted to the **built-in** plugin loading system.
* I was tired of managing git submodules, nor did I find it very scalable.
* I do not want my plugin manager to **affect the start up time** of my editor.

Many of the other plugins mangers are really slick, but every one I have seen has violated at least one of those.

I don't really want to use my editor for installing stuff. Feels like it goes against the Vim philosophy. Bram said "Each program has its own task and should be good at it" and think installing things is better suited for a command line script.

## Usage

Infect reads your `.vimrc` file and looks for magic comments. It uses those to install vim packages and plugins. A minimal `.vimrc` to use with infect might look like this:

    "=plugin tpope/vim-sensible
    "=plugin csexton/trailertrash.vim

    syntax on
    filetype plugin indent on

Just put those lines at the top of your `.vimrc` and infect will install plugins and packages for you.

## Building plugins

Some plugins have binaries that need to be compiled, and infect can automatically run those commands for you. For example Shougo's [vimproc](https://github.com/Shougo/vimproc.vim) needs you to call `make` after installing it:

    "=plugin Shougo/vimproc.vim build: make

## Plugins vs Packages

Packages are collections of plugins. Introduced in Vim 8, they provide a way to combine a number of plugins together and have Vim load them for you. One of the nice upsides to this is you don't need any external plugin manager to be able to load plugin bundles, just have to put them in the right folder.

Infect will do this for you. If you declare a `plugin`, infect will put that in the default package called `plugins`. That will cause it to automatically be loaded when vim is started.

## Loading automatically or optionally

According to Vim docs:

> Note that the files under "pack/foo/opt" are not loaded automatically, only the
ones under "pack/foo/start".  See |pack-add| below for how the "opt" directory
is used.

This means you have to call `:packadd` to load any optional plugins. This can be handy if you don't want to proactively load up some plugins.

Tell vim to only load Trailer Trash when requested:

    "=plugin csexton/trailertrash.vim load: opt

Then to request it to be loaded:

    :packadd trailertrash.vim



