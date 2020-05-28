FROM ubuntu

ARG pat_token
ARG service_url=<https://dev.azure.com/orgname>
ARG pool=Default
ARG agent

COPY ubuntu-agent /data/agent
ENV AGENT_ALLOW_RUNASROOT=1

# Download packets
RUN apt-get update && apt-get install -y openssh-client
RUN apt-get update && apt-get install -y openssh-server
RUN apt-get update && apt-get install -y vim
RUN apt-get update && apt-get install -y git

# Change root password to 'toor'
RUN echo 'root:toor' | chpasswd

# Allow to login as root via ssh
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Set up agent
WORKDIR /data/agent
RUN tar zxvf ./vsts-agent-linux-x64-2.168.2.tar.gz
RUN ./bin/installdependencies.sh; exit 0

RUN ./config.sh --auth PAT --token $pat_token --url $service_url --pool $pool --agent $agent --acceptTeeEula --replace --work _work

CMD ["/bin/bash"]
EXPOSE 8080
EXPOSE 443