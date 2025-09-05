# Toggles the GEMINI_API_KEY between personal and corporate contexts.

# To use this, set the following two variables in your secrets.zsh file:
# export GEMINI_API_KEY_PERSONAL="your_personal_key"
# export GEMINI_API_KEY_CORPORATE="your_corporate_key"

GEMINI_CONTEXT_FILE="$HOME/.gemini_context"

# Set a default context if not already set
if [ ! -f "$GEMINI_CONTEXT_FILE" ]; then
  echo "personal" > "$GEMINI_CONTEXT_FILE"
fi

export GEMINI_CONTEXT=$(cat "$GEMINI_CONTEXT_FILE")

# Set the initial API key based on the context
if [ "$GEMINI_CONTEXT" = "personal" ]; then
  export GEMINI_API_KEY="$GEMINI_API_KEY_PERSONAL"
else
  export GEMINI_API_KEY="$GEMINI_API_KEY_CORPORATE"
fi

toggle_gemini_context() {
  if [ "$GEMINI_CONTEXT" = "personal" ]; then
    export GEMINI_CONTEXT="corporate"
    echo "corporate" > "$GEMINI_CONTEXT_FILE"
    export GEMINI_API_KEY="$GEMINI_API_KEY_CORPORATE"
    echo "Switched to corporate Gemini context."
  else
    export GEMINI_CONTEXT="personal"
    echo "personal" > "$GEMINI_CONTEXT_FILE"
    export GEMINI_API_KEY="$GEMINI_API_KEY_PERSONAL"
    echo "Switched to personal Gemini context."
  fi
}

alias tgg="toggle_gemini_context"