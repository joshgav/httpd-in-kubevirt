#! /usr/bin/env bash

this_dir=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)

dnf update --assumeyes
dnf install --assumeyes httpd

# modify /etc/httpd/conf/httpd.conf with port 8080
# add content to /var/www/html/index.html (or leave empty for default page)
apachectl start
# use password fedora