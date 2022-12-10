[![CircleCI](https://dl.circleci.com/status-badge/img/gh/ansible-playbooks-mamono210/wordpress_install/tree/main.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/ansible-playbooks-mamono210/wordpress_install/tree/main)

# Ansible Playbook - Wordpress Install

## Introduction

This program installs [WordPress](https://wordpress.com) on CentOS Stream 8.

## How To install

1. Install ansible and git

```
sudo yum -y install epel-release git
sudo yum -y install ansible
```

2. Execute playbook as root

```
git clone https://github.com/ansible-playbooks-centos7/wordpress_install.git
cd wordpress_install
ansible-galaxy install -r roles/requirements.yml
ansible-playbook -i localhost, -c local install.yml
```
