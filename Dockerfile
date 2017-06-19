FROM ubuntu:zesty
MAINTAINER Jan Hermes <jan@hermes-technology.de>

# Set DEBIAN_FRONTEND to nontinteractive during build
# ARG DEBIAN_FRONTEND=noninteractive

#ENV http_proxy http://proxy-ka.iosb.fraunhofer.de:80
#ENV https_proxy http://proxy-ka.iosb.fraunhofer.de:80

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
RUN apt-get upgrade -y
RUN apt-get install -y texlive-full
RUN apt-get install -y xzdec

RUN apt-get install -y wget
#COPY wgetrc /etc/wgetrc

RUN tlmgr init-usertree

RUN tlmgr install tracklang collection-fontsrecommended collection-fontsextra libertine mweights fontaxes marvosym inconsolata newtx kastrup mathalfa was fnpct superiors translations cnltx pgfopts trimspaces csquotes pgfplots multirow tabulary rotfloat ntheorem glossaries mfirstuc xfor datatool substr tracklang cleveref mathdots marginnote biblatex logreq xstring xpatch german

RUN apt-get install -y biber

RUN apt-get install -y texlive-generic-extra

RUN apt-get install -y software-properties-common

#ENV HTTP_PROXY='http://proxy-ka.iosb.fraunhofer.de:80'
#ENV HTTPS_PROXY='http://proxy-ka.iosb.fraunhofer.de:80'



#RUN apt-key adv --keyserver-options http-proxy='http://ka-proxy.iosb.fraunhofer.de:80' --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys BA3CBA3FFE22B574
#RUN add-apt-repository -y ppa:hvr/ghc
#RUN apt-get update
#RUN apt-get install -y cabal-install-1.22 ghc-7.10.3

#RUN apt-get install -y pandoc

RUN apt-get install -y haskell-platform


RUN cabal update
RUN cabal install pandoc-crossref
RUN cabal install pandoc-citeproc
RUN cabal install pandoc --enable-tests

COPY sdqthesis.cls /texmf/tex/latex/commonstuff/

ENV PATH="/root/.cabal/bin:/opt/cabal/1.22/bin:/opt/ghc/7.10.3/bin:${PATH}"
WORKDIR /data
VOLUME ["/data"]
