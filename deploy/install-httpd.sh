#! /usr/bin/env bash

this_dir=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)

dnf install --assumeyes httpd

sed -i 's/^Listen 80$/Listen 8080/' /etc/httpd/conf/httpd.conf
apachectl start

echo "Hello world from Kubevirt!" > /var/www/html/index.html
