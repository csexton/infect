module Infect
  class Command
    class Prereqs < Command
      def call
        mkdir_p "~/.vim/bundle"
        # create the cache directories for sensible.vim:
        # TODO: Support Windows
        if RUBY_PLATFORM =~ /darwin/
          mkdir_p "~/Library/Vim/swap"
          mkdir_p "~/Library/Vim/backup"
          mkdir_p "~/Library/Vim/undo"
        else
          mkdir_p "~/.local/share/vim/swap"
          mkdir_p "~/.local/share/vim/backup"
          mkdir_p "~/.local/share/vim/undo"
        end
      end
    end
  end
end
