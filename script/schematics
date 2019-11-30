#!/bin/sh

# Schematics are saved in a separate git repository, which is cloned whenever Heroku starts
# from a fresh state. Only non-existing files are added to the repository.

git clone git@github.com:kaboomserver/schematics.git $HOME/plugins/FastAsyncWorldEdit/schematics/

while true; do
	cd $HOME/plugins/FastAsyncWorldEdit/schematics/
	if [ "$(git add $(git ls-files -o) -v)" ]; then
		git -c user.name='kaboom' -c user.email='kaboom.pw' commit -m "Add new schematics"
		git push
	fi
	sleep 1
done
