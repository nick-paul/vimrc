if status --is-interactive
    abbr gs git status
    abbr gaa "git add --all"
    abbr gd "git diff"
    abbr fdir "find . | grep"
    abbr aya "rlwrap java -jar ~/Documents/git/aya-lang/aya.jar -i"
    abbr icat "kitty +kitten icat"
    abbr jupnb "jupyter notebook"

    # ROS
    abbr ros "source /opt/ros/melodic/share/rosbash/rosfish"
    abbr sds "bass source devel/setup.bash"
    abbr catkin_unmake "bass source devel/setup.bash; trash -rf build/ devel/"

    abbr rr 'ranger --choosedir=$HOME/.rangerdir; set LASTDIR (cat $HOME/.rangerdir); cd "$LASTDIR"'

    abbr ytdl "youtube-dl -x --audio-format mp3 --no-playlist"

    git config --global alias.adog "log --all --decorate --oneline --graph"

    # pyenv
    if test -d ~/.pyenv
        set -q PYENV_ROOT; or set -l PYENV_ROOT $HOME/.pyenv
        set PATH $PYENV_ROOT/shims $PYENV_ROOT/bin $PATH
        status --is-interactive; and source (pyenv init -|psub)
        status --is-interactive; and source (pyenv virtualenv-init -|psub)


    end

    #if pyenv versions | grep -q andy-rlice
        #pyenv activate andy-rlice
    #end

    set -g theme_nerd_fonts yes
    set -g theme_display_date no
end

# Various path variables

set ADD_TO_PATH \
    ~/blender-2.79b-linux-glibc219-x86_64 \
    /opt/julia-1.1.1/bin \
    /opt/cling/bin \
    ~/.local/kitty.app/bin \
    /opt/nvim/bin

for p in $ADD_TO_PATH
    if test -d "$p"
        set PATH "$p" $PATH
    end
end

