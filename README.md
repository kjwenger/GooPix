# GooPix
A Google Photos companion 

## Abstract

## Prerequisites

```bash
mvn org.apache.maven.plugins:maven-install-plugin:3.1.3:install-file \
    -D file=src/main/jar/jgaf-2.4.2.jar \
    -D groupId=pgdurand \
    -D artifactId=jGAF \
    -D version=2.4.2 \
    -D packaging=jar \
    -D generatePom=true
```