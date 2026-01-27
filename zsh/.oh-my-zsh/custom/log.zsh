log() {
  if [[ -z "$1" ]]; then
    if [[ -f ~/.work_focus_log.txt ]]; then
      tail -n 10 ~/.work_focus_log.txt
    else
      echo "Log file not found: ~/.work_focus_log.txt"
    fi
  else
    echo "[$(date "+%Y-%m-%d %H:%M")] $*" >> ~/.work_focus_log.txt
  fi
}
