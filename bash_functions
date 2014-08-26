#!/bin/bash

ix() {
    if [ -t 0 ]; then
        local filename="$1"
        shift
        if [ "$filename" == '--' ]; then
            curl -n $* paste.rupa.co
        else
            curl -n -F "f:1=@$filename" $* paste.rupa.co
        fi
    else
        curl -n -F 'f:1=<-' $* paste.rupa.co
    fi
}
function tailapache {
    tail -f /var/log/apache2/error.log | sed '/.*PHP Notice.*/d;s/$/\n/'
}

function tailmysql {
    tail -f /var/log/mysql/mysql.log
}

function phpinfo {
    echo "<?php phpinfo(); ?>" > info.php
}

function gitignore {
    echo -e ".idea
*.un~
lib/CKFinder
lib/CKEditor
lib/Zend
lib/byte
lib/cms
local/byte-shared-assets
local/js/yui
local/css/yui
local/icons/silk
local/upload
local/cache
local/writable" > .gitignore
}

function html {
  echo -e "
<!DOCTYPE html>
<html class="no-js">
    <head>
        <meta charset="utf-8">
        <title></title>
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/normalize/2.1.3/normalize.css">
        <link rel="stylesheet" href="main.css">
        <script src="//cdnjs.cloudflare.com/ajax/libs/modernizr/2.7.1/modernizr.js"></script>
    </head>
    <body>

        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
        <script>window.jQuery || document.write('<script src="js/vendor/jquery-1.10.2.min.js"><\/script>')</script>
        <script src="main.js"></script>
    </body>
</html>" > $1
  touch main.css
  touch main.js
}

function rtvs {
    ack -l --php $1 | ack -l -x $2 | ack -x -C 5 $1
}

function stock {
    curl -s "http://download.finance.yahoo.com/d/quotes.csv?s=$1&f=l1c1"
}

function cursive {
    coffee /home/jared/bin/cursive_unicode.coffee "$@" | xclip -selection clipboard
}

doing() {
  echo $(date "+%Y-%m-%d %H:%M:%S") - "$@" >> $HOME/.plan
}

function inkpot {
  cd /home/jared/code/inkpot
  cp /home/jared/.vim/bundle/inkpot/colors/inkpot.vim /home/jared/code/inkpot/colors/inkpot.vim
  git add .
  git commit
}

gvim () { command gvim --remote-silent "$@" || command gvim "$@"; }

