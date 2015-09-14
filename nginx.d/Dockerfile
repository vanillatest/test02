FROM test02/vbase


ENV WWWHOME=/srv/http

run pacman -S nginx --needed --noconfirm
run pacman -Sc --noconfirm && pacman-optimize
run echo -e "\ndaemon off;" >> /etc/nginx/nginx.conf
run sed -r -i '/^(\s*)location\s+\/\s*\{/a\\t autoindex on;'  /etc/nginx/nginx.conf

run sed -r -i 's@^(\s*root\s+)/usr/share/nginx/html;$@\1/srv/http;@g' /etc/nginx/nginx.conf
add http://wallpapers.wallhaven.cc/wallpapers/full/wallhaven-14190.png /srv/http/14190.png
run find /srv/http -type f -exec chmod 644 {} +;
run find /srv/http -type d -exec chmod 755 {} +;

#add http://wallpapers.wallhaven.cc/wallpapers/full/wallhaven-14190.png /usr/share/nginx/html/14190.png
#run chmod 644 /usr/share/nginx/html/* -R

#run systemctl enable nginx
#run pacman -S

#VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]
#VOLUME [ "/srv"] # makes srv avail to other Dockers via --volumes-from 'run' command


WORKDIR /etc/nginx

#EXPOSE 80
#EXPOSE 443

CMD ["nginx"]
