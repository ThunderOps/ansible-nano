SHELL := /bin/bash
IMAGE := $(notdir $(CURDIR))
THIS_FILE := $(lastword $(MAKEFILE_LIST))

.PHONY: all clean build run config test ssh

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: build run config test

mrproper:  ## Kills and removes container for this module
	@echo "Killing and removing Container"
	bash -c "docker kill $(IMAGE) || docker rm -f $(IMAGE) || docker rmi $(IMAGE)"

clean:  ## Kills container and leaves image for this module
	@echo "Killing Container"
	bash -c "docker kill $(IMAGE) && docker rm -f $(IMAGE)"

build:
	@echo "Building Image"
	bash -c "CWD=$${PWD##*/} docker build -t $(IMAGE) ."

run:
	@echo "Running Container"
	bash -c "docker run --privileged -d -e container=docker --stop-signal SIGRTMIN+3 \
	--name $(IMAGE) \
	--hostname $(IMAGE) \
	--volume /sys/fs/cgroup:/sys/fs/cgroup \
	-p 7075:7075/udp -p 7075:7075 -p 7076:7076 \
	$(IMAGE) /usr/sbin/init"

config:
	@echo "Running Ansible"
	@bash -c "docker exec $(IMAGE) mkdir -p /root/.ssh /tmp/roles/$(IMAGE)"
	@bash -c "docker cp $(CURDIR)/playbook.yaml  $(IMAGE):/tmp/playbook.yaml"
	@bash -c "docker cp $(CURDIR)/roles  $(IMAGE):/tmp/roles/$(IMAGE)"
	@bash -c "docker cp $(CURDIR)/test  $(IMAGE):/tmp/"

	bash -c "docker exec -ti $(IMAGE) ansible-playbook -i inventory --connection=local --become /tmp/playbook.yaml"

test:  ## Execs into the container, and runs inspec tests
	@echo "Running Tests"
	@bash -c "docker exec -ti $(IMAGE) rm -rf /tmp/test"
	@bash -c "docker cp $(CURDIR)/test  $(IMAGE):/tmp/"
	bash -c "docker exec -ti $(IMAGE) inspec exec /tmp/test/inspec"

status:  ## Lists the docker container for this module
	bash -c "docker ps --filter name=$(IMAGE)$(DOMAIN)"

ssh:  ## Execs into bash on the container for this module
	bash -c "docker exec -ti $(IMAGE)$(DOMAIN) /bin/bash"

.DEFAULT_GOAL := all
.PHONY: all clean build run config test status ssh help mrproper