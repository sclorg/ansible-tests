.PHONY: ocp4-tests check-latest-ex

ocp4-tests:
	ansible-playbook deploy-and-test.yml


check-latest-ex:
	ansible-playbook check-latest-ex.yml
