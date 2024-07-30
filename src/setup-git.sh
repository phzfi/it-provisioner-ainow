#!/bin/bash
#Setup Git improve compability and reduce developer setup overhead

#TODO please change your name and email
git config --global user.name "PHZ Developers"
git config --global user.email "phz@phz.fi"

#Set PHZ standard git configuration
git config --global pull.rebase false
git config --global color.ui "auto"
git config --global pack.threads "0"
git config --global core.whitespace cr-at-eol
git config --global http.postBuffer 524288000
git config --global push.default simple
git config --global pull.default simple
#this improves git status performance on large projects
git config --global core.preloadindex true
#git rerere is a cache to solve merge conflicts - it remembers your solution how you have solved conflicts.
git config --global rerere.enabled true
git config --global diff.wsErrorHighlight all
git config --global init.defaultBranch master
