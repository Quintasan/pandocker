FROM debian:jessie
MAINTAINER Michał Zając <pandocker@quintasan.pl>

ENV DEBIAN_FRONTEND noninteractive

ENV LTSHASKELL 7.2

RUN echo "deb http://download.fpcomplete.com/debian jessie main" >> /etc/apt/sources.list && \
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 575159689BEFB442 && \
	apt-get update && \
	apt-get install -y \
		stack \
		texlive \
		texlive-latex-extra \
		texlive-generic-extra \
		texlive-xetex \
		texlive-lang-polish \
		texlive-bibtex-extra \
		biber \
		rubber \
		latex-beamer && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN  stack update && stack install --resolver lts-${LTSHASKELL} pandoc

WORKDIR /source

ENTRYPOINT ["/root/.local/bin/pandoc"]

CMD ["--help"]
