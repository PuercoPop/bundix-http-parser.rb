Setup to reproduce https://github.com/nix-community/bundix/issues/105

1. nix-shell -A shell
2. irb
3  require 'http/parser' # (in irb the repl)
