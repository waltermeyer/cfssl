FROM ubuntu:trusty
MAINTAINER wgmeyer@gmail.com

RUN apt-get update -y && apt-get install gcc wget libltdl-dev git -y

RUN wget https://storage.googleapis.com/golang/go1.4.2.linux-amd64.tar.gz && \
    tar -C /usr/local -xzvf go1.4.2.linux-amd64.tar.gz && \
    mkdir $HOME/go

ENV GOPATH /root/go
ENV PATH /usr/local/go/bin:/root/go/bin:$PATH

RUN cd $GOPATH && go get -u github.com/cloudflare/cfssl/cmd/...

ENTRYPOINT ["/root/go/bin/cfssl"]
CMD ["serve", "-address=0.0.0.0"]
EXPOSE 8888
