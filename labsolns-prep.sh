Debian t2.micro mysql guix

i-0c674c4c8c63e46d0 instance

Security group edit inbound to ALL



sudo apt-get update
sudo apt-get install gnupg git nscd emacs-nox
wget 'https://sv.gnu.org/people/viewgpg.php?user_id=15145' -qO - | sudo -i gpg --import -

cd /tmp
wget https://git.savannah.gnu.org/cgit/guix.git/plain/etc/guix-install.sh
chmod +x guix-install.sh
sudo ./guix-install.sh


## in .profile
    echo "export PATH=\"$PATH:/home/admin/.guix-profile/bin\"" >> ~/.profile   ## for art
echo "export GUIX_LOCPATH=\"$HOME/.guix-profile/lib/locale\"" >> ~/.profile

    echo "export GUILE_LOAD_PATH=\"/home/admin/.guix-profile/share/guile/site/3.0${GUILE_LOAD_PATH:+:}$GUILE_LOAD_PATH\"" >> ~/.profile  
    echo "export GUILE_LOAD_COMPILED_PATH=\"/home/admin/.guix-profile/lib/guile/3.0/site-ccache:/home/admin/.guix-profile/share/guile/site/3.0${GUILE_LOAD_COMPILED_PATH:+:}$GUILE_LOAD_COMPILED_PATH\"" >> ~/.profile

    echo "export GUIX_PROFILE=\"/home/admin/.guix-profile\"" >> ~/.profile
    echo "export LC_ALL=C" >> ~/.profile
. "/home/admin/.guix-profile/etc/profile"




guix install glibc-utf8-locales
sudo -i guix package -i glibc-utf8-locales

After setting `PATH', run `hash guix' to make sure your shell refers to `/home/admin/.config/guix/current/bin/guix'.

$ echo $PATH
/home/admin/.config/guix/current/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games

wget https://raw.githubusercontent.com/mbcladwell/artanis/main/guixmod.scm
guix package --install-from-file=guixmod.scm

    mkdir /home/admin/projects
    cd /home/admin/projects
    git clone --depth 1 git://github.com/mbcladwell/limsn.git 
