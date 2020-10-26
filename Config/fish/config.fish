# Fish settings
set -U fish_greeting

# Colors
set fish_color_command 26BBD9
set fish_color_param 3FC6DE
set fish_color_error E95678
set fish_color_quote 59E3E3
set fish_color_escape 6BE6E6
set fish_color_search_match --background='232530'
set fish_pager_color_description FAB795
set fish_pager_color_completion FBC3A7
set fish_pager_color_progress FBC3A7 --background='232530'

# LS on CD 
function cs
   cd $argv
   ls
end

# N to launch NNN & CD on quit NNN
function n --wraps nnn --description 'support nnn quit and change directory'
    # Block nesting of nnn in subshells
    if test -n "$NNNLVL"
        if [ (expr $NNNLVL + 0) -ge 1 ]
            echo "nnn is already running"
            return
        end
    end

    # The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
    # To cd on quit only on ^G, remove the "-x" as in:
    #    set NNN_TMPFILE "$XDG_CONFIG_HOME/nnn/.lastd"
    # NOTE: NNN_TMPFILE is fixed, should not be modified
    if test -n "$XDG_CONFIG_HOME"
        set -x NNN_TMPFILE "$XDG_CONFIG_HOME/nnn/.lastd"
    else
        set -x NNN_TMPFILE "$HOME/.config/nnn/.lastd"
    end

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    nnn $argv

    if test -e $NNN_TMPFILE
        source $NNN_TMPFILE
        rm $NNN_TMPFILE
    end
endecho