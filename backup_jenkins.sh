#!/usr/bin/env bash

# Thank you
# http://jenkins-ci.org/content/keeping-your-configuration-and-data-subversion
# for the inspiration.

source ./common.sh

echo_task "copying xmls"
cp -v $JENKINS_DIR/*.xml $BACKUP_DIR

echo_task "copying job configurations"
for DIR in `ls -p $JENKINS_DIR/jobs | grep "/" | xargs`
do
    mkdir -p $BACKUP_DIR/jobs/$DIR
    cp -v $JENKINS_DIR/jobs/$DIR/*.xml $BACKUP_DIR/jobs/$DIR
done

echo_task "copying job configurations"
for $DIR in `ls -p $JENKINS_DIR/jobs | grep "/" | xargs`
do
    mkdir -p $BACKUP_DIR/jobs/$DIR
    cp -v $JENKINS_DIR/jobs/$DIR/*.xml $BACKUP_DIR/jobs/$DIR
done

echo_task "copying users and user content"
cp -vr $JENKINS_DIR/users $BACKUP_DIR/
cp -vr $JENKINS_DIR/userContent $BACKUP_DIR/

echo_task "committing to git"
cd $BACKUP_DIR
git add .
git commit -m "automated commit of jenkins configuration on [$(date)]."
git push $GIT_REMOTE $GIT_BRANCH
