# General
alias fd='fdfind'
alias ag='ag --path-to-ignore ~/.ignore'
# https://stackoverflow.com/questions/17998978/removing-colors-from-output
alias rcolor='sed -i -r "s///g; s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g"'

# gLinux
alias tmux=tmx2
alias copybara='/google/bin/releases/copybara/public/copybara/copybara'

# Chromium
alias dut-console='~/projects/chromiumos/src/platform/dev/contrib/dut-console'
alias gen_uprev_msg='~/projects/chromiumos/src/platform/dev/contrib/gen_uprev_msg.py'
alias up='repo upload . --cbr'
alias upc='cros_sdk --working-dir . -- repo upload . --cbr'
alias md_browser='python2 ~/projects/chromiumos/src/chromium/src/tools/md_browser/md_browser.py'
alias shivas='/usr/local/google/home/yupingso/projects/shivas/shivas'
