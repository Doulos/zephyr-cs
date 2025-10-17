#!/bin/bash

cd ..
west init -l labs
west update --narrow -o=--depth=1
west zephyr-export
pip install -r deps/zephyr/scripts/requirements.txt
pip install rich
west config build.dir-fmt /zephyr-training/build
west completion bash > $HOME/west-completion.bash

cat >> $HOME/.bashrc << 'EOF'
# overwrite prompt
PS1="\u@doulos:\w$"

# aliases to make student's life easier
alias ll='ls -lah'
alias cdlab='cd /zephyr-training/labs'
alias glcdsim='python /zephyr-training/labs/zdoulos/glcdsim'
alias arm-zephyr-eabi-addr2line='/opt/toolchains/zephyr-sdk-0.16.8/arm-zephyr-eabi/bin/arm-zephyr-eabi-addr2line'

# enable completion for west command
source $HOME/west-completion.bash

# tune history saving
HISTSIZE=5000
HISTCONTROL=ignoredups:erasedups
shopt -s histappend
PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"
EOF
cat /dev/null > ~/.bash_history && history -c
