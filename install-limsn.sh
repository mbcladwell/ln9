#!/bin/sh

# We require Bash but for portability we'd rather not use /bin/bash or
# /usr/bin/env in the shebang, hence this hack.
if [ "x$BASH_VERSION" = "x" ]
then
    exec bash "$0" "$@"
fi

set -e

[ "$UID" -eq 0 ] || { echo "This script must be run as root."; exit 1; }


PAS=$'[ \033[32;1mPASS\033[0m ] '
ERR=$'[ \033[31;1mFAIL\033[0m ] '
WAR=$'[ \033[33;1mWARN\033[0m ] '
INF="[ INFO ] "
# ------------------------------------------------------------------------------
#+UTILITIES

_err()
{ # All errors go to stderr.
    printf "[%s]: %s\n" "$(date +%s.%3N)" "$1"
}

_msg()
{ # Default message to stdout.
    printf "[%s]: %s\n" "$(date +%s.%3N)" "$1"
}

_debug()
{
    if [ "${DEBUG}" = '1' ]; then
        printf "[%s]: %s\n" "$(date +%s.%3N)" "$1"
    fi
}

# Return true if user answered yes, false otherwise.
# $1: The prompt question.
prompt_yes_no() {
    while true; do
        read -rp "$1" yn
        case $yn in
            [Yy]*) return 0;;
            [Nn]*) return 1;;
            *) _msg "Please answer yes or no."
        esac
    done
}

welcome()
{
    cat<<"EOF"

 _______________________  |  _ |_  _  _ _ _|_ _  _         
|O O O O O O O O O O O O| |_(_||_)(_)| (_| | (_)| \/       
|O O O O O O 1 O O O O O|                         /        
|O O O O O O O O O O O O|  /\    _|_ _  _ _  _ _|_. _  _   
|O O O O O O O O O O O O| /~~\|_| | (_)| | |(_| | |(_)| |  
|O O 1 O O O O O 1 O 1 O|  _                               
|O O O O O O O O O O O O| (  _ |   _|_. _  _  _            
|O O O 1 O O O O O O O O| _)(_)||_| | |(_)| |_)    
|O O O O O O O O O O O O|
 -----------------------  info@labsolns.com

This script installs LIMS*Nucleus on your system

http://www.labsolns.com

EOF
    echo -n "Press return to continue..."
    read -r
}


updatesys()
{
    sed -i '$ a\\ndeb http://deb.debian.org/debian/ sid main contrib non-free\ndeb-src http://deb.debian.org/debian/ sid main contrib non-free' /etc/apt/sources.list
    apt-get update
    apt-get upgrade
    apt-get install texinfo ca-certificates postgresql postgresql-client postgresql-contrib libpq-dev automake git autoconf libtool nano zlib1g-dev libnss3 libnss3-dev build-essential lzip libunistring-dev libgmp-dev libgc-dev libffi-dev libltdl-dev libintl-perl libiconv-hook-dev pkg-config guile-3.0 guile-3.0-dev guile-library nettle-dev gnuplot
  
}

buildstuff()
{
 git clone --depth 1 git://github.com/opencog/guile-dbi.git \
        cd guile-dbi/guile-dbi && ./autogen.sh && ./configure && make -j \
        && make install && ldconfig && cd .. \
        \
        && cd guile-dbd-postgresql \
        && ./autogen.sh && ./configure && make -j \
        && make install && ldconfig && cd ../../ && rm -fr guile-dbi


git clone --depth 1 git://github.com/mbcladwell/artanis.git 

        cd artanis ./autogen.sh && ./configure && make -j \
        && make install && ldconfig && cd .. \

					  
	mkdir projects
	cd ./projects
git clone --depth 1 git://github.com/mbcladwell/limsn.git 

    
}

initdb()
{


    
}


configure()
{
    export PATH "$PATH:/usr/local/bin"   ## for art
    export GUILE_LOAD_PATH="/usr/share/guile/site/3.0:/limsn:/usr/local/share/guile/site/2.2${GUILE_LOAD_PATH:+:}$GUILE_LOAD_PATH"
    export GUILE_LOAD_COMPILED_PATH="/usr/lib/x86_64-linux-gnu/guile/3.0/site-ccache:/usr/lib/guile/3.0/site-ccache:/usr/lib/x86_64-linux-gnu/guile/2.2/site-ccache${GUILE_LOAD_COMPILED_PATH:+:}$GUILE_LOAD_COMPILED_PATH"
}


main()
{
    local tmp_path
    welcome
    
    _msg "Starting installation ($(date))"

    updatesys
    buildstuff
    
    _msg "${INF}cleaning up ${tmp_path}"
    rm -r "${tmp_path}"

    _msg "${PAS}Guix has successfully been installed!"

    # Required to source /etc/profile in desktop environments.
    _msg "${INF}Please log out and back in to complete the installation."
 }

main "$@"
