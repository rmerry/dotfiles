if [ -s $HOME/.bashrc ]; then
    source $HOME/.bashrc
fi

# Ensure agent is running
ssh-add -l &>/dev/null
if [ "$?" == 2 ]; then
    # Could not open a connection to your authentication agent.

    # Load stored agent connection info.
    test -r ~/.ssh-agent && \
        eval "$(<~/.ssh-agent)" >/dev/null

    ssh-add -l &>/dev/null
    if [ "$?" == 2 ]; then
        # Start agent and store agent connection info.
        (umask 066; ssh-agent > ~/.ssh-agent)
        eval "$(<~/.ssh-agent)" >/dev/null
    fi
fi

# Load identities
ssh-add -l &>/dev/null
if [ "$?" == 1 ]; then
    # The agent has no identities.
    # Time to add one.
    ssh-add ~/.ssh/azuredevops
    ssh-add ~/.ssh/id_rsa
fi
. "$HOME/.cargo/env"
