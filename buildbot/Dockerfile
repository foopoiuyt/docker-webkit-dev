# escape=`

ARG IMAGE_TAG
FROM webkitdev/msbuild:$IMAGE_TAG

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

#--------------------------------------------------------------------
# Install twisted
#--------------------------------------------------------------------

ENV TWISTED_VERSION 19.7.0

RUN Write-Host 'Installing twisted ...'; `
    pip install -q ('Twisted=={0}' -f $env:TWISTED_VERSION); `
    pip show Twisted;

#--------------------------------------------------------------------
# Install buildbot
#--------------------------------------------------------------------

ENV BUILDBOT_VERSION 0.8.14

RUN Write-Host 'Installing buildbot ...'; `
    pip install -q ('buildbot=={0}' -f $env:BUILDBOT_VERSION); `
    pip show buildbot; `
    buildbot --version; `
    `
    pip install -q ('buildbot-slave=={0}' -f $env:BUILDBOT_VERSION); `
    pip show buildbot-slave; `
    buildslave --version;

#--------------------------------------------------------------------
# Copy files
#--------------------------------------------------------------------

COPY WebKit-BuildWorker C:/WebKit-BuildWorker

#--------------------------------------------------------------------
# Entrypoint
#--------------------------------------------------------------------

WORKDIR C:\\WebKit-BuildWorker
CMD powershell .\\Run-BuildbotWorker.ps1
