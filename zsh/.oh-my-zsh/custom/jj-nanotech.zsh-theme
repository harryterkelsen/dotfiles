# jj-nanotech.zsh-theme

# This theme is based on the nanotech theme from Oh My Zsh, but uses jj instead of git.

jj_prompt_info() {
  if ! jj status &>/dev/null; then
    return
  fi

  local branch
  branch=$(jj log --no-graph -r @ -T 'description')
  local repo_status
  if jj st --quiet; then
    repo_status=""
  else
    repo_status="%F{red}*%f"
  fi

  echo "%F{yellow}${branch}${repo_status}%f"
}

PROMPT='%F{green}%2c%F{blue} [%f '
RPROMPT='$(jj_prompt_info) %F{blue}] %F{green}%D{%L:%M} %F{yellow}%D{%p}%f'
