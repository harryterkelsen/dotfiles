# Warns the user if they have not logged their activity recently.
# This check is performed before every prompt.

_check_recent_log() {
  # Run the check. If the command fails (exit code 1), show a warning.
  # We redirect stdout and stderr to /dev/null as we only need the exit code.
  if ! log _check_recency >/dev/null 2>&1; then
    # Using printf for better control over newlines and colors
    printf '
\033[0;33m%s\033[0m
' "Warning: You have not logged your activity recently."
  fi
}

# Add the function to the precmd_functions array.
# This ensures it runs before each prompt is displayed.
precmd_functions+=(_check_recent_log)
