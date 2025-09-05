# jj-nanotech.zsh-theme

# This theme is based on the nanotech theme from Oh My Zsh, but uses jj instead of git.

jj_prompt_info() {
  if ! jj status &>/dev/null; then
    return
  fi

  local branch
  branch=$(jj log --no-graph -r @ -T 'description')
  if [ -z "$branch" ]; then
    branch="(no description set)"
  fi
  local repo_status
  if jj status | grep -q "Working copy changes"; then
    repo_status="%F{red}*%f"
  else
    repo_status=""
  fi

  echo "%F{yellow}${branch}${repo_status}%f"
}

PROMPT='%F{green}%2c%F{blue} [%f '
RPROMPT='$(jj_prompt_info) %F{blue}] %F{green}%D{%L:%M} %F{yellow}%D{%p}%f'
