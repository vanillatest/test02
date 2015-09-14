FROM test02/vbase


run pacman -S nginx --needed --noconfirm
run pacman -Sc --noconfirm && pacman-optimize

WORKDIR /etc/nginx
run echo -e "\ndaemon off;" >> nginx.conf
run sed -r -i '/^(\s*)location\s+\/\s*\{/a\\t autoindex on;'  nginx.conf

run sed -r -i 's@^(\s*root\s+)/usr/share/nginx/html;$@\1/srv/http;@g' /etc/nginx/nginx.conf

WORKDIR /srv/http
run echo -e "yay the world spins" > nospin.txt
run find . -type f -exec chmod 644 {} +;
run find . -type d -exec chmod 755 {} +;

#VOLUME [ "/srv"] # makes srv avail to other Dockers via --volumes-from 'run' command



#EXPOSE 80
#EXPOSE 443

CMD ["nginx"]
