### SSH Directory Tracking

When connected to a remote machine via SSH, the directory displayed in the status bar may not update automatically. This is because the remote shell needs to inform the local tmux about its current directory using an OSC 7 escape sequence.

If you are using Bash on a remote Linux machine (like Amazon Linux 2, CentOS, or Ubuntu), add the following to your `~/.bashrc` on the **remote** machine:

```bash
# Update tmux/terminal current directory (OSC 7) for kanagawa-pills SSH pill
if [ -n "$PS1" ]; then
  update_cwd() {
    printf "\033]7;file://%s%s\033\\" "$HOSTNAME" "$PWD"
  }
  PROMPT_COMMAND="update_cwd; $PROMPT_COMMAND"
fi
```

### TODO

- Display the weather in the status bar (currently a placeholder)
