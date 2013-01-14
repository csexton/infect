# Infect

Asset Pipeline for Vim and Pathogen

## Installation

    $ gem install infect

## Objective

The point of Infect it to make it easy to manage your vim config. You should be able to check in yoru `.vimrc` into source control and use that one file to easily install any plugins you need.

## Usage

Infect reads your `.vimrc` file and looks for magic comments. It uses those to install pathogen style vim bundles.

    " Include bundle:
    "=bundle tpope/vim-pathogen
    "=bundle tpope/vim-sensible
    "=bundle csexton/trailertrash.vim

A minimal vimrc to use with infect would look like this:

    " vim bundles:
    "=bundle tpope/vim-pathogen
    "=bundle tpope/vim-sensible
    source ~/.vim/bundle/vim-pathogen/autoload/pathogen.vim
    execute pathogen#infect()
    syntax on
    filetype plugin indent on


