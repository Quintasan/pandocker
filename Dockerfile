FROM debian:jessie
MAINTAINER Michał Zając <pandocker@quintasan.pl>

RUN echo "deb http://ppa.launchpad.net/hvr/ghc/ubuntu trusty main" >> /etc/apt/sources.list && \
	apt-key adv --keyserver keyserver.ubuntu.com --recv F6F88286

RUN apt-get update && apt-get install -y \
	cabal-install-1.22 \
	ghc-7.8.4 \
	happy-1.19.5 \
	alex-3.1.4 \
	zlib1g-dev \
	curl

ENV PATH $HOME/.cabal/bin:/opt/cabal/1.22/bin:/opt/ghc/7.8.4/bin:/opt/happy/1.19.5/bin:/opt/alex/3.1.4/bin:$PATH

RUN  cabal update && \
	cabal install pandoc

WORKDIR /source

ENTRYPOINT ["/root/.cabal/bin/pandoc"]

CMD ["--help"]
