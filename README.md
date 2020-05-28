# azure-pipelines-tasks-local-test
## Local test environment for Azure Pipelines Tasks

Docker container with an agent to run pipeline tasks locally.

Prerequisites:
    - Installed docker

How to run:
1. Build: set parameters in Dockerfile - and use command:

    `docker build --tag agent-ubuntu:1.0 ./`
       
   or by command:

	  docker build --build-arg pat_token=<pat token> --build-arg service_url=<service url> --build-arg pool=<pool> --build-arg agent=<agent> ./

2. Run:

	  `docker run --add-host remotehost.net:127.0.0.1 -it agent-ubuntu:1.0`
      `service ssh start`
	  `./run.sh`

