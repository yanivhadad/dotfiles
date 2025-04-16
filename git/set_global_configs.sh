#!/bin/bash

git config --global column.ui auto
git config --global branch.sort -committerdate
git config --global tag.sort version:refname
git config --global init.defaultBranch master

git config --global diff.algorithm histogram
git config --global diff.colorMoved plain
git config --global diff.mnemonicPrefix true
git config --global diff.renames true

git config --global push.autoSetupRemote true
git config --global push.followTags true

git config --global help.autocorrect prompt

git config --global commit.verbose true