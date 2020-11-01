#!/usr/bin/env bash
# Author: Marco Tijbout - CrossCloud.Guru
# License: GNU GPL v2.0
# Version: 1

SOURCE_DIR="${HOME}/.ssh"
ARR_FILES=( $(grep -d skip -l "BEGIN" ${SOURCE_DIR}/*) )
ARR_FILES+=( "Exit selection ..." )

fnAddSSH() {
    echo -e "Adding SSH Key $option"
    ssh-add $option
}

fnCreateMenu () {
    select option; do # in "$@" is the default
        if [ "$REPLY" -eq "$#" ];
        then
            echo -e "Exiting..."
            break;
        elif [ 1 -le "$REPLY" ] && [ "$REPLY" -le $(($#-1)) ];
        then
            echo -e "You selected $option which is option $REPLY"
            fnAddSSH
            break;
        else
            echo -e "Incorrect Input: Select a number 1-$#"
        fi
    done
}

fnCreateMenu "${ARR_FILES[@]}"
