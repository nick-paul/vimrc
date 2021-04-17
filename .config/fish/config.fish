if status --is-interactive
    abbr gs git status
    abbr gaa "git add --all"
    abbr gd "git diff"
    abbr fdir "find . | grep"
    abbr aya "rlwrap java -jar ~/git/aya/aya.jar -i"
    abbr icat "kitty +kitten icat"
    abbr jupnb "jupyter notebook"
    abbr ilua "rlwrap lua ~/Documents/git/ilua/repl.lua"
    abbr ll 'ls -hal'
    abbr clip 'xclip -selection clipboard'

    # ROS
    abbr ros "source /opt/ros/melodic/share/rosbash/rosfish; bass source ~/isolate_ws/devel/setup.bash"
    abbr ros3 "source ~/py3_ws/install_isolated/share/rosbash/rosfish"
    abbr aware "source /opt/ros/melodic/share/rosbash/rosfish; bass source ~/angler/install_isolated/setup.bash; bass source ~/uuv_ws/devel/setup.bash"
    abbr sds "bass source devel/setup.bash"
    abbr catkin_unmake "bass source devel/setup.bash; trash -rf build/ devel/"

    abbr rr 'ranger --choosedir=$HOME/.rangerdir; set LASTDIR (cat $HOME/.rangerdir); cd "$LASTDIR"'

    abbr ytdl "youtube-dl -x --audio-format mp3 --no-playlist"

    git config --global alias.adog "log --all --decorate --oneline --graph"
    git config --global alias.undo-commit "reset HEAD~1"

    # pyenv
    if test -d ~/.pyenv
        set -q PYENV_ROOT; or set -l PYENV_ROOT $HOME/.pyenv
        set PATH $PYENV_ROOT/shims $PYENV_ROOT/bin $PATH
        status --is-interactive; and source (pyenv init -|psub)
        status --is-interactive; and source (pyenv virtualenv-init -|psub)
    end

    set -g theme_nerd_fonts yes
    set -g theme_display_date no

    function rostopic_types
        for t in (rostopic list)
            echo "$t" (rostopic info $t | grep Type)
        end
    end
end

# Various path variables

set ADD_TO_PATH \
    #~/blender-2.79b-linux-glibc219-x86_64 \
    /opt/blender-2.81-linux-glibc217-x86_64 \
    /opt/julia-1.6.0/bin \
    /opt/cling/bin \
    ~/.local/kitty.app/bin \
    /opt/nvim/bin \
    /opt/jdk12/bin \
    ~/.cargo/bin \
    /opt/bw/bin \
    /opt/typora/bin/Typora-linux-x64 \
    /opt/bitwarden \
    ~/ccls/Release \
    ~/scripts

for p in $ADD_TO_PATH
    if test -d "$p"
        set PATH "$p" $PATH
    end
end

# Soar
set -x SOAR_HOME /home/npaul/isolate/logical_reasoner/soar_ngs_ros/soar/out
set -x PYTHONPATH /home/npaul/isolate/logical_reasoner/soar_ngs_ros/soar/out "$PYTHONPATH"

set -x EDITOR nvim
set -x VISUAL nvim
