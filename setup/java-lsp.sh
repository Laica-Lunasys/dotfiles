#!/bin/bash
set -e

cd "$(dirname "$0")"

mkdir -p ~/lsp/eclipse.jdt.ls
cd ~/lsp/eclipse.jdt.ls

curl -L http://download.eclipse.org/jdtls/milestones/0.52.0/jdt-language-server-0.52.0-202003042214.tar.gz | tar xzv

cd ~/lsp/
curl -L https://projectlombok.org/downloads/lombok.jar -O
