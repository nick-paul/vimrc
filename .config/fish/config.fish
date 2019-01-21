abbr gs git status
abbr gaa "git add --all"
abbr fdir "find . | grep"
abbr aya "rlwrap java -jar ~/Documents/git/aya-lang/aya.jar -i"

# pyenv
set -q PYENV_ROOT; or set -l PYENV_ROOT $HOME/.pyenv
set PATH $PYENV_ROOT/shims $PYENV_ROOT/bin $PATH
status --is-interactive; and source (pyenv init -|psub)
status --is-interactive; and source (pyenv virtualenv-init -|psub)

# blender
set PATH /home/npaul/blender-2.79b-linux-glibc219-x86_64 $PATH
# julia
set PATH /opt/julia-1.0.3/bin $PATH
# cling
set PATH /opt/cling/bin $PATH
