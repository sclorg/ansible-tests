.PHONY: ocp4-tests

ocp4-tests:
	ansible-playbook deploy-and-test.yml
