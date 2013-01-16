module Infect
  class Command
    class Prereqs < Command
      def call
        mkdir "~/.vim/bundle"
        # sensible.vim keeps these under ~/.cache
        mkdir "~/.cache/swap"
        mkdir "~/.cache/backup"
        mkdir "~/.cache/undo"
      end
    end
  end
end
