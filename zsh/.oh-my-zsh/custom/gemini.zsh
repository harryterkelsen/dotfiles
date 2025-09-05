# Toggles the GEMINI_API_KEY between personal and corporate contexts.

# To use this, set the following two variables in your secrets.zsh file:
# export GEMINI_API_KEY_PERSONAL="your_personal_key"
# export GEMINI_API_KEY_CORPORATE="your_corporate_key"

# Set a default context if not already set
if [ -z "$GEMINI_CONTEXT" ]; then
  export GEMINI_CONTEXT="personal"
fi

# Set the initial API key based on the context
if [ "$GEMINI_CONTEXT" = "personal" ]; then
  export GEMINI_API_KEY="$GEMINI_API_KEY_PERSONAL"
else
  export GEMINI_API_KEY="$GEMINI_API_KEY_CORPORATE"
fi

toggle_gemini_context() {
  if [ "$GEMINI_CONTEXT" = "personal" ]; then
    export GEMINI_CONTEXT="corporate"
    export GEMINI_API_KEY="$GEMINI_API_KEY_CORPORATE"
    echo "Switched to corporate Gemini context."
  else
    export GEMINI_CONTEXT="personal"
    export GEMINI_API_KEY="$GEMINI_API_KEY_PERSONAL"
    echo "Switched to personal Gemini context."
  fi
}

alias tgg="toggle_gemini_context"
