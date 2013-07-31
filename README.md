# Backup jenkins configuration to a git repository

TL;DR: This repository has useful scripts for backing up your jenkins configuration to a git repository.

Inspired by [this link](http://jenkins-ci.org/content/keeping-your-configuration-and-data-subversion), which shows how to keep the jenkins configuration and data in subversion. Well, we're in 2013, so I thought that keeping the configuration in git would be more useful :)

# Usage

## One-time configuration

1. Clone the repo:

```sh
git clone git@github.com:luisalima/backup_jenkins_config.git
```

2. Edit common.sh and change the environment variables to suit your own configuration. I added some examples to get you started. Don't forget to generate the keys that you are going to use using ssh-keygen, and to add them to your remote git repository.

3. Login with the jenkins user, and run:

```sh
source backup_jenkins_config/prepare_jenkins_backup.sh
```

What this script does is to prepare an ssh identity for your git repository, create a backup directory and initialize an empty git repository there.

4. Just for the sake of it, run your first backup to see whether everything is allright :)

```sh
source backup_jenkins_config/backup_jenkins.sh
```

## Recurrent backups

You can execute backup_jenkins.sh regularly using a cron task or just create a jenkins job to do it :) My jenkins job simply executes the script as follows:

```sh
bash /var/lib/jenkins/backup_jenkins_config/backup_jenkins.sh
```

And is set to run every day around midnight (depending on load):
```sh
H 00 * * *
```

## Disclaimer

I tested this in an Ubuntu Linux distribution, if you'd like to tweak for any other use just fork the repo at will, it's MIT License.
