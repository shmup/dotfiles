#!/bin/bash

ix() {
    local opts
    local OPTIND
    [ -f "$HOME/.netrc" ] && opts='-n'
    while getopts ":hd:i:n:" x; do
        case $x in
            h) echo "ix [-d ID] [-i ID] [-n N] [opts]"; return;;
            d) $echo curl $opts -X DELETE ix.io/$OPTARG; return;;
            i) opts="$opts -X PUT"; local id="$OPTARG";;
            n) opts="$opts -F read:1=$OPTARG";;
        esac
    done
    shift $(($OPTIND - 1))
    [ -t 0 ] && {
        local filename="$1"
        shift
        [ "$filename" ] && {
            curl $opts -F f:1=@"$filename" $* ix.io/$id
            return
        }
        echo "^C to cancel, ^D to send."
    }
    curl $opts -F f:1='<-' $* ix.io/$id
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

function jshintrc {
    echo "{ \"esnext\": true }" > .jshintrc
}

function gitignore {
    echo -e ".idea
*.un~
lib/CKFinder
lib/CKEditor
lib/Zend
lib/byte
lib/cms
lib/cms.php
lib/byte.php
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
    ack -l --php "$1" | ack -l -x "$2" | ack -x -C 5 "$1"
}

function stock {
    curl -s "http://download.finance.yahoo.com/d/quotes.csv?s=$1&f=l1c1"
}

function cursive {
    coffee /home/jared/bin/cursive_unicode.coffee "$@" | xclip -selection clipboard
}

function cool {
    echo "😎 " | xclip -selection clipboard
}
function shrug {
    echo "¯\_(ツ)_/¯" | xclip -selection clipboard
}
function sadeyes {
    echo "ಠ_ಠ" | xclip -selection clipboard
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

