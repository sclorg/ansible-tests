# Testing RHSCL containers on OpenShift 4.X

## Prerequisities

before running playbook you have to do the following:
1. export KUBEKONFIG like `export KUBECONFIG=<path_to_directory>/kubeconfig`

## How to create a test for a new container
In order to create a new test go through these steps.
1. Go to directory `vars`
1. Copy file `template-container.yml` to the new one, like `foobar.yml`
1. Fill all variables in the file like, `deployment`, `pod_name`, `test_command`,
`expected_results`, `test_command_2`, `expected_results_2`.
1. Add the newest test info `deploy-and-test.yaml` file, task `Clone and test upstream container repositories`
1. For more examples, see already existing tests

## Test RHSCL containers under OpenShift 4.X

Testing run by a command:
ansible-playbook deploy-and-test.yml

or simply by make command:
```bash
make ocp4-tests
```