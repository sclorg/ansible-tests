# Testing containers by this repo on OpenShift 4.X

## RHSCL containers
We have several images in our GitHub namespace [https://github.com/sclorg/](https://github.com/sclorg/).
We want to easy test all these images under an OpenShift 4.X environment and execute the basic use cases there
whether those images running well in an OpenShift 4.X cluster (especially v4.3 and v4.4)

The playboook `deploy-and-test`.yml perform these actions:
- clone upstream image repository to `/tmp/rhscl_openshift_dir`
- check if `vars` directory contains `<upstream_name>.yml` file
- deploy an image specified in the `<upstream_name>.yml` file by variable `deployment`
- test an image by variable `check_curl_output`
- test and image by script defined in variable `test_exec_command` and check output defined by variable `expected_exec_result`

### Tested containers

Nowadays, we are able to test these containers:
- s2i-nodejs-container
- cakephp-ex
- s2i-ruby-container
- s2i-python-container
- s2i-perl-container
- httpd-container
- postgresql-container
- mysql-container
- nginx-container

### Prerequisities

#### Install Fedora ansible-playbook package

The tests are executed by `ansible-playbook` command. Install it by `dnf` command:
```bash
$ sudo dnf install -y ansible python3-lxml
```

#### Download and install OpenShift Client 4

To test RHSCL image under OpenShift 4.X environment you have to download
at least OpenShift Client v4.3. The steps below will install the latest OpenShift Client 4 version.

```bash
$ mkdir -p ~/ocp4-client
$ curl -o ~/ocp4-client/ocp4-client.tar.gz https://mirror.openshift.com/pub/openshift-v4/clients/ocp-dev-preview/latest-4.4/openshift-client-linux.tar.gz
$ tar -xzvf ~/ocp4-client.tar.gz
$ export PATH="${HOME}/ocp4-client:${PATH}"
```

#### Set KUBECONFIG

Before running playbook you have to export KUBECONFIG variable, by a command:

```bash
export KUBECONFIG=<path_to_directory>/kubeconfig
```

### Test RHSCL containers under OpenShift 4.X

Testing run by a command:
ansible-playbook deploy-and-test.yml

or simply by make command:
```bash
make ocp4-tests
```

To test only one container, run it by a command:
```bash
make ocp4-tests GITHUB_REPO=<upstream_github_repo_name>
```

## How to create a test for a new container
In order to create a new test go through these steps.
1. Go to directory `vars`
1. Copy file `template-container.yml` to the new one, like `foobar.yml`
1. Fill all variables in the file like, `deployment`, `pod_name`, `test_command`,
`expected_results`, `test_command_2`, `expected_results_2`.
1. Add the newest test info `deploy-and-test.yaml` file, task `Clone and test upstream container repositories`
1. For more examples, see already existing tests

## Test java container by ansible-tests in OpenShift

This repo can test Java containers under OpenShift 4 as well.

You can run all versions of Java or a specific one by setting one of the
values for `ext_test` variable:

* All Java versions: `ext_test=java`
* Java 8: `ext_test=java_8`
* Java 11: `ext_test=java_11`
* Java 17: `ext_test=java_17`

Testing run by a command:

ansible-playbook deploy-and-test.yml -e ext_test=java

or simply by make command:
```bash
make ocp4-tests EXT_TEST=java
```

## Test dotnet container by ansible-tests in OpenShift

This repo can test Dotnet containers under OpenShift 4 as well.

You can run all versions of Dotnet or a specific one by setting one of the
values for `ext_test` variable:

* All Dotnet versions: `ext_test=dotnet`
* Dotnet 31: `ext_test=dotnet_31`
* Dotnet 60: `ext_test=dotnet_60`

Testing run by a command:

ansible-playbook deploy-and-test.yml -e ext_test=dotnet

or simply by make command:
```bash
make ocp4-tests EXT_TEST=dotnet
```

