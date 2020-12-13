NPIPERELAY_URL="https://github.com/NZSmartie/npiperelay/releases/download/v0.1/npiperelay.exe"

if [ -n "$WSL_DISTRO_NAME" ]; then
    APPDATA="$(wslvar appdata)"
    APPDATA="${APPDATA//\\/\/}"
    NPIPERELAY_WIN="$APPDATA/wsl2-ssh-gpg-npiperelay.exe"
    NPIPERELAY="$(wslpath "$NPIPERELAY_WIN")"

    if [ ! -f "$NPIPERELAY" ]; then
        curl -L -q -o "$NPIPERELAY" "$NPIPERELAY_URL"
    fi
    #####
    ## Autorun for the gpg-relay bridge
    ##
    SOCAT_PID_FILE=$HOME/.gnupg/socat-gpg.pid
    SOCAT_PID_FILE2=$HOME/.gnupg/socat-gpg.pid.2

    for GPG_SOCK in "$HOME/.gnupg/S.gpg-agent" "/tmp/$UID/gnupg/S.gpg-agent"; do
        if ! ss -a | grep -q "$GPG_SOCK"; then
            rm -f "$GPG_SOCK"
            mkdir -p "$(dirname "$GPG_SOCK")"
            setsid --fork socat UNIX-LISTEN:"$GPG_SOCK",fork EXEC:"$NPIPERELAY -ei -ep -s -a "'"'"$APPDATA"/gnupg/S.gpg-agent'"',nofork
        fi
    done

    #####
    ## Autorun for the ssh-relay bridge
    ##
    export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock
    if ! ss -a | grep -q "$SSH_AUTH_SOCK"; then
        rm -f "$SSH_AUTH_SOCK"
        setsid --fork socat UNIX-LISTEN:"$SSH_AUTH_SOCK",fork EXEC:"$NPIPERELAY -ei -s //./pipe/openssh-ssh-agent",nofork
    fi
fi
