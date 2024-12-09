#!/bin/bash

cd ..
west init -l labs
west update --narrow -o=--depth=1
west zephyr-export
pip install -r deps/zephyr/scripts/requirements.txt
pip install rich
echo "alias ll='ls -lah'" >> $HOME/.bashrc
west config build.dir-fmt /zephyr-training/build
west completion bash > $HOME/west-completion.bash
cat >> $HOME/.bashrc << 'EOF'
# enable completion for west command
source $HOME/west-completion.bash

# tune history saving
HISTSIZE=5000
HISTCONTROL=ignoredups:erasedups
shopt -s histappend
PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"
export PATH="$PATH:/opt/toolchains/zephyr-sdk-0.16.8/arm-zephyr-eabi/bin/"
EOF
history -c
