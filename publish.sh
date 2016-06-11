#!/bin/bash

# Replace "sculpin generate" with "php sculpin.phar generate" if sculpin.phar
# was downloaded and placed in this directory instead of sculpin having been
# installed globally.

#sculpin generate --env=prod
#if [ $? -ne 0 ]; then echo "Could not generate the site"; exit 1; fi

# Add --delete right before "output_prod" to have rsync remove files that are
# deleted locally from the destination too. See README.md for an example.
#rsync -avze 'ssh -p 4668' output_prod/ akilahjackson@my-sculpin-site:public_html
if [ $? -ne 0 ]; then echo "Could not publish the site"; exit 1; fi

if [ $# -ne 1 ]; then
    echo "usage: ./publish.sh \"add a commit message\""
    exit 1;
fi

sculpin generate --env=prod

git stash
git checkout gh-pages

cp -R components/
cp -R output_prod/* .
rm -rf output_*

git add *
git commit -m "$1"
git push origin --all

git checkout master
git stash pop
