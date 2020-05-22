.PHONY: all ocp4-tests check-latest-imagestreams

ocp4-tests:
	ansible-playbook deploy-and-test.yml

check-latest-imagestreams:
	ansible-playbook check-imagestreams.yml

all: check-latest-imagestreams ocp4-tests
