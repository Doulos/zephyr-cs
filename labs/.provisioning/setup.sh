#!/bin/bash

cd ..
west init -l labs
west update --narrow -o=--depth=1
west zephyr-export
pip install -r deps/zephyr/scripts/requirements.txt
echo "alias ll='ls -lah'" >> $HOME/.bashrc
west config build.dir-fmt /zephyr-training/build
west completion bash > $HOME/west-completion.bash
history -c
cat >> $HOME/.bashrc << 'EOF'
# enable completion for west command
source $HOME/west-completion.bash

# tune history saving
HISTSIZE=5000
HISTCONTROL=ignoredups:erasedups
shopt -s histappend
PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"
if [[ "$TERM_PROGRAM" == "vscode" ]]; then
    echo "==============================================================="
    echo "!!!!!          TEST SYSTEM FOR IT INFRASTRUCTURE          !!!!!"
    echo "==============================================================="
    echo ""
    echo "TEST System for Doulos Zephyr Essential training"
    echo "If you see this banner, your IT infrastructure should be fine"
    echo
    echo "Current date: $(date)"
    echo "==============================================================="
fi
EOF
