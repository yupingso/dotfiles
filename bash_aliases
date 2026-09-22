# General
alias fd='fdfind'
alias ag='rg'
# https://stackoverflow.com/questions/17998978/removing-colors-from-output
alias rcolor='sed -i -r "s///g; s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g"'
alias reboot='echo "Are you sure? (y/n)" && read -r confirm && [[ "$confirm" == "y" ]] && /sbin/reboot'

# Editor
alias vim=nvim
alias vimdiff='nvim -d'

# Python
alias ipython='ipython3'

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
