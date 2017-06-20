FROM debian:stretch-slim
MAINTAINER Jan Hermes <jan@hermes-technology.de>

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
RUN apt-get upgrade -y
RUN apt-get install -y --no-install-recommends texlive texlive-lang-german texlive-latex-extra 
RUN apt-get install -y xzdec

RUN apt-get install -y wget

RUN tlmgr init-usertree

RUN tlmgr install tracklang collection-fontsrecommended collection-fontsextra libertine mweights fontaxes marvosym inconsolata newtx kastrup mathalfa was fnpct superiors translations cnltx pgfopts trimspaces csquotes pgfplots multirow tabulary rotfloat ntheorem glossaries mfirstuc xfor datatool substr tracklang cleveref mathdots marginnote biblatex logreq xstring xpatch german

RUN apt-get install -y biber

RUN apt-get install -y texlive-generic-extra

RUN apt-get install -y software-properties-common

RUN apt-get install -y haskell-platform

RUN cabal update
RUN cabal install pandoc-crossref
RUN cabal install pandoc-citeproc
RUN cabal install pandoc --enable-tests

RUN apt-get install -y --no-install-recommends texlive-xetex

ENV PATH="/root/.cabal/bin:/opt/cabal/1.22/bin:/opt/ghc/7.10.3/bin:${PATH}"
WORKDIR /data
VOLUME ["/data"]
