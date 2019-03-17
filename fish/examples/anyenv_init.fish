source "/Users/tt/.anyenv/libexec/../completions/anyenv.fish"
function anyenv
  set command $argv[1]
  set -e argv[1]

  command anyenv "$command" $argv
end
set -x GOENV_ROOT "/Users/tt/.anyenv/envs/goenv"
set -x PATH $PATH "/Users/tt/.anyenv/envs/goenv/bin"
set -gx PATH '/Users/tt/.anyenv/envs/goenv/shims' $PATH
set -gx GOENV_SHELL fish
source '/Users/tt/.anyenv/envs/goenv/libexec/../completions/goenv.fish'
command goenv rehash 2>/dev/null
function goenv
  set command $argv[1]
  set -e argv[1]

  switch "$command"
  case rehash shell
    source (goenv "sh-$command" $argv|psub)
  case '*'
    command goenv "$command" $argv
  end
end
set -x NDENV_ROOT "/Users/tt/.anyenv/envs/ndenv"
set -x PATH $PATH "/Users/tt/.anyenv/envs/ndenv/bin"
set -gx PATH '/Users/tt/.anyenv/envs/ndenv/shims' $PATH
set -gx NDENV_SHELL fish
command ndenv rehash 2>/dev/null
function ndenv
  set command $argv[1]
  set -e argv[1]

  switch "$command"
  case rehash shell
    source (goenv "sh-$command" $argv|psub)
  case '*'
    command goenv "$command" $argv
  end
end
set -x PHPENV_ROOT "/Users/tt/.anyenv/envs/phpenv"
set -x PATH $PATH "/Users/tt/.anyenv/envs/phpenv/bin"
set -gx PATH '/Users/tt/.anyenv/envs/phpenv/shims' $PATH
set -gx PHPENV_SHELL fish
command phpenv rehash 2>/dev/null
function phpenv
  set command $argv[1]
  set -e argv[1]

  switch "$command"
  case shell
    source (goenv "sh-$command" $argv|psub)
  case '*'
    command goenv "$command" $argv
  end
end
set -x PYENV_ROOT "/Users/tt/.anyenv/envs/pyenv"
set -x PATH $PATH "/Users/tt/.anyenv/envs/pyenv/bin"
set -gx PATH '/Users/tt/.anyenv/envs/pyenv/shims' $PATH
set -gx PYENV_SHELL fish
source '/Users/tt/.anyenv/envs/pyenv/libexec/../completions/pyenv.fish'
command pyenv rehash 2>/dev/null
function pyenv
  set command $argv[1]
  set -e argv[1]

  switch "$command"
  case activate deactivate rehash shell
    source (pyenv "sh-$command" $argv|psub)
  case '*'
    command pyenv "$command" $argv
  end
end
