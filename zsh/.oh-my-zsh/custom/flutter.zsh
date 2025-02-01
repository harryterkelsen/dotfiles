export PATH="$HOME/Projects/depot_tools:$HOME/Projects/flutter/bin:$PATH"

if [[ $(uname) == "Darwin" ]]; then
  export CHROME_EXECUTABLE="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
else
  export CHROME_EXECUTABLE="google-chrome-stable"
fi
