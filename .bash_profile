if [ -f ~/.bashrc ]; then . ~/.bashrc; fi
export BASH_SILENCE_DEPRECATION_WARNING=1

export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jatinkathuria/google-cloud-sdk/path.bash.inc' ]; then . '/Users/jatinkathuria/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/jatinkathuria/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/jatinkathuria/google-cloud-sdk/completion.bash.inc'; fi

if [ -f '~/.inputrc' ]; then bind -f ~/.inputrc; fi
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
