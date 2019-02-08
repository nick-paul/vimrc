abbr gs git status
abbr gaa "git add --all"
abbr fdir "find . | grep"
abbr aya "rlwrap java -jar ~/Documents/git/aya-lang/aya.jar -i"
abbr icat "kitty +kitten icat"

abbr rr 'ranger --choosedir=$HOME/.rangerdir; set LASTDIR (cat $HOME/.rangerdir); cd "$LASTDIR"'

# pyenv
if test -d ~/.pyenv
    set -q PYENV_ROOT; or set -l PYENV_ROOT $HOME/.pyenv
    set PATH $PYENV_ROOT/shims $PYENV_ROOT/bin $PATH
    status --is-interactive; and source (pyenv init -|psub)
    status --is-interactive; and source (pyenv virtualenv-init -|psub)
end

# Various path variables

set ADD_TO_PATH \
    ~/blender-2.79b-linux-glibc219-x86_64 \
    /opt/julia-1.0.3 \
    /opt/cling \
    ~/.local/kitty.app/bin

for p in "$ADD_TO_PATH"
    if test -d "$p"
        set PATH "$p" $PATH
    end
end
