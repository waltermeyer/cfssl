FROM ubuntu:14.04
MAINTAINER wgmeyer@gmail.com

RUN apt-get update -y && apt-get install wget git -y && \
    wget https://storage.googleapis.com/golang/go1.4.2.linux-amd64.tar.gz && \
    tar -C /usr/local -xzvf go1.4.2.linux-amd64.tar.gz && \
    mkdir $HOME/go && \
    echo "export PATH=$PATH:/usr/local/go/bin" >> /etc/profile && \
    echo "export GOPATH=$HOME/go" >> /etc/profile && \
    echo "export PATH=$PATH:/root/go/bin" >> /etc/profile

ENV GOPATH /root/go
ENV PATH /usr/local/go/bin:/root/go/bin:$PATH

RUN go get -u github.com/cloudflare/cfssl/cmd/...

ENTRYPOINT ["/root/go/bin/cfssl"]
CMD ["serve", "-address=0.0.0.0"]
EXPOSE 8888
