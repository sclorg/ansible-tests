# Containerized Testing
Dockerfile `dockerfiles/interop/Dockerfile` added to facilitate running tests in a container.  This was initially added to execute .Net tests in a framework that requires that setup and tests be performed from a container. PR https://github.com/openshift/release/pull/37713

## Use

1. Authenticate to registry.redhat.io (Will query for user and password)
   >podman login registry.redhat.io

2. Clone ansible-tests repo
   >git clone git@github.com:sclorg/ansible-tests.git

3. Copy Docker file to root of repo
   >cp ./dockerfiles/interop/Dockerfile .

4. Build image
   >podman build --tag ansible-runner -f ./Dockerfile

5. Run test
   ~/tmp-vol should contain the kubeconfig file of ocp4 system testing against.
   Besides KUBECONFIG add and set any other environment variable needed by test.

   >podman run -v ~/tmp-vol:/tmp/vol/ -e KUBECONFIG=/tmp/vol/kubeconfig -e EXT_TEST=dotnet_60 --name ansible-runner --rm ansible-runner ansible-runner run /tmp/tests/ansible-tests -p deploy-and-test.yml


