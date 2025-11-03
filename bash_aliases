# General
alias fd='fdfind'
alias ag='ag --path-to-ignore ~/.ignore'
# https://stackoverflow.com/questions/17998978/removing-colors-from-output
alias rcolor='sed -i -r "s///g; s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g"'

# gLinux
alias vim=nvim
alias vimdiff='nvim -d'
alias tmux=tmx2
alias ta='tmux a'
alias copybara='/google/bin/releases/copybara/public/copybara/copybara'

# Function to activate a specific venv and run ipython
vipython() {
	VENV_PATH="${HOME}/.venvs/common"

	# Check if the venv path exists
	if [ ! -d "${VENV_PATH}" ]; then
		echo "Error: Virtual environment path not found: ${VENV_PATH}"
	fi

	# shellcheck source=/dev/null
	source "${VENV_PATH}/bin/activate"

	# Check if ipython is available in the venv
	if command -v ipython &> /dev/null; then
		echo "Starting IPython in ${VENV_PATH} ..."
		ipython "$@"
	else
		echo "IPython not found in this virtual environment: ${VENV_PATH}"
	fi

	echo "Deactivating virtual environment..."
	deactivate
}

# Google
alias gemini='/google/bin/releases/gemini-cli/tools/gemini'

# Chromium
alias dut-console='~/projects/chromiumos/src/platform/dev/contrib/dut-console'
alias gen_uprev_msg='~/projects/chromiumos/src/platform/dev/contrib/gen_uprev_msg.py'
alias up='repo upload . --cbr'
alias upc='cros_sdk --working-dir . -- repo upload . --cbr'
alias get-commit-kernel-ref="git log -1 --pretty=format:'commit %h ("%s")' --abbrev=12"
alias md_browser='python2 ~/projects/chromiumos/src/chromium/src/tools/md_browser/md_browser.py'
alias shivas='/usr/local/google/home/yupingso/projects/shivas/shivas'

# Android
alias rs='repo sync -c --optimized-fetch'
alias rsn='repo sync -c --optimized-fetch --nmu'
alias al-smartsync='/google/src/head/depot/google3/wireless/android/aluminium/smartsync/sync.py --optimized-fetch'
