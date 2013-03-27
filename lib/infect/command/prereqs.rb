require 'fileutils'
module Infect
  class Command
    class Prereqs < Command
      def mkdirs(list)
        list.each do |path|
          FileUtils.mkdir_p path
        end
      end
      def call
        mkdir "~/.vim/bundle"
        # create the cache directories for sensible.vim:
        # TODO: Support Windows
        if RUBY_PLATFORM =~ /darwin/
          mkdirs %w(~/Library/Vim/swap ~/Library/Vim/backup ~/Library/Vim/undo)
        else
          mkdirs %w(~/.local/share/vim/swap ~/.local/share/vim/backup ~/.local/share/vim/undo")
        end
      end
    end
  end
end
