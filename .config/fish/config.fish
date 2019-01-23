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
set BLENDER_DIR /home/npaul/blender-2.79b-linux-glibc219-x86_64
if test -d $BLENDER_DIR
    set PATH $JULIA_DIR $PATH
end

# julia
set JULIA_DIR /opt/julia-1.0.3/bin
if test -d $JULIA_DIR
    set PATH $JULIA_DIR $PATH
end

# cling
set CLING_DIR /opt/cling/bin
if test -d $CLING_DIR
    set PATH CLING_DIR $PATH
end
