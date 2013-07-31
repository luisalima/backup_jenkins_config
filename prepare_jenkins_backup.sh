#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/common.sh

# --------------------------------
if [ $USER != "jenkins" ]
then
    alert "please switch to jenkins user before running this script!"
    exit
fi

if [ -z "$(grep $REPO_HOSTNAME ~jenkins/.ssh/config)" ]
then
echo_task "adding identity to .ssh/config"
cat >> "$JENKINS_DIR/.ssh/config" <<EOF
Host $REPO_HOSTNAME
   Hostname          $REPO_URL
   User              git
   IdentityFile      $REPO_IDENTITYFILE
   IdentitiesOnly    yes
EOF
else
alert "identity already added to .ssh/config!"
fi

cat $JENKINS_DIR/.ssh/config

if [ -d $BACKUP_DIR ]
then
    echo_task "backup directory already exists and is $BACKUP_DIR"
else
    echo_task "creating backup directory $BACKUP_DIR"
    mkdir -v $BACKUP_DIR
fi

if [ -d $BACKUP_DIR/.git ]
then
    echo_task "backup directory is a git repository"
else
    echo_task "initializing git repository"
    cd $BACKUP_DIR
    git init
    cd $JENKINS_DIR
fi
