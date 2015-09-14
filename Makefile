#:
#	echo "$(/bin/grep -Eio "^[a-z0-9]+" Makefile)"
NAME := "docker fun"
VERSION := ".1"

help: .SILENT
	echo -e "targets:"
	for x in $$(/bin/grep -Eio "^[a-z0-9]+:" Makefile | tr -d ':'); do echo -e "- $$x";   done
#	for x in $$(/bin/grep -Eio "^[a-z0-9]+:" Makefile | tr -d ':'); do echo -e "- $$x";   done
#	for x in $$(/bin/grep -Eio "^[a-z0-9]+:" Makefile | tr -d ':'); do echo -e "- $$x\n -- $$(/bin/grep -Eio "^\s+printf.*#:$" Makefile | sed -r 's/^.*%s\\n" .|. .:$//g'|sed -r 's/\\"/"/g')";  done
#	for x in $$(/bin/grep -Eio "^[a-z0-9]+:" Makefile | tr -d ':'); do echo -e "- $$x"; echo -e $$(/bin/grep -Eio "^\s+printf.*#:$$" Makefile | sed -r 's/^.*%s\\n" .|. .://g'|sed -r 's/\\"/"/g');    done




# create symlink to this Makefile in each sub-folder ending with .d
sym:
	printf "%s\n" "Making symlink to each docker project (folders ending with \\ \".d\")" #:
	[[ -n $$(/bin/find . -maxdepth 1 -type l -name "Makefile") ]] && for x in $$(/bin/find . -mindepth 1 -type d -iname "*.d"); do ln -sf $$(echo $${x#*/}x| sed 's@[^/]*@\.\.@g')/$$(readlink Makefile) $${x}/; done || echo -n ""
	[[ -n $$(/bin/find . -maxdepth 1 -type f -name "Makefile") ]] && for x in $$(/bin/find . -mindepth 1 -type d -iname "*.d"); do ln -sf $$(echo $${x#*/}x| sed 's@[^/]*@\.\.@g')/Makefile $${x}/; done || echo -n ""
# for x in $$(/bin/find . -mindepth 1 -type d -iname "*.d"); do ln -sf $$(echo $${x#*/}x| sed 's@[^/]*@\.\.@g')/Makefile $${x}/; done
# for x in $$(/bin/find . -mindepth 1 -type d -iname "*.d"); do ln -sf $$(echo $${x#*/}x| sed 's@[^/]*@\.\.@g')/$$(readlink Makefile) $${x}/; done


build:
	printf "%s\n" "> docker build --no-cache --rm -t $$(basename $${PWD%/*})/$$(basename $${PWD%.d}) ." #:
	[[ -n  $$(/bin/find . -maxdepth 1 -name "Dockerfile") ]] && docker build --no-cache --rm -t $$(basename $${PWD%/*})/$$(basename $${PWD%.d}) . | tee build.log && exit 0 || echo "No Dockerfile!" && exit 1
#	[[ -n  $$(/bin/find . -maxdepth 1 -name "Dockerfile") ]] && docker build --no-cache --rm -t $$(basename $${PWD%.d})/$$(basename $${PWD%/*}) . | tee build.log || echo "No Dockerfile!" && exit 1


image: images
images:
	printf "%s\n" "> docker images -a"
	docker images -a

imageclean:
	for iid in $$(docker images -a | awk '/^<none>/ { print $$3}'); do docker rmi $$iid; done

run:
	printf "%s\n" "> docker run -t -i --rm <image> /bin/bash"
	[[ -n $$(docker images| grep -E $$(basename $${PWD%/*})/$$(basename $${PWD%.d})) ]] && printf "%s\n" "this: $$(basename $${PWD%/*})/$$(basename $${PWD%.d})"
	[[ -n $$(docker images| grep -E $$(basename $${PWD%/*})/$$(basename $${PWD%.d})) ]] && docker run -t -i --rm $$(basename $${PWD%/*})/$$(basename $${PWD%.d}) /bin/bash  && exit 0

ps:
	printf "%s\n" "> docker ps -a"
	docker ps -a
info:
	printf "%s\n" "> docker info"
	docker info
status: info ps images









pretty: 
	find . -type f -name "*~" -exec rm -f {} +;
	find . -type f -name "#*#" -exec rm -f {} +;


clear: clean
clean:  pretty


zapdockercontainers:
	docker 
zapdockervarliv:
	rm -rf /var/lib/docker/

.force: ;

.SILENT:
