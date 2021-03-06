# escape=`

ARG IMAGE_TAG
FROM webkitdev/scm:$IMAGE_TAG

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

#--------------------------------------------------------------------
# Install Strawberry Perl x64
#
# ActivePerl is recommended in the WebKit documentation but won't
# install into a docker container. Also its not free so can't
# technically use it for a build-bot.
#--------------------------------------------------------------------

ENV PERL_VERSION 5.30.0.1

RUN Install-Perl -Version $env:PERL_VERSION -InstallationPath C:\tools\perl;

#--------------------------------------------------------------------
# Install Python
#--------------------------------------------------------------------

ENV PYTHON_VERSION 2.7.16
ENV PYTHONIOENCODING utf-8
ENV PYTHON_PIP_VERSION 19.2.2

RUN Install-Python `
    -Version $env:PYTHON_VERSION `
    -PipVersion $env:PYTHON_PIP_VERSION `
    -InstallationPath C:\tools\python;

#--------------------------------------------------------------------
# Install pywin32
#--------------------------------------------------------------------

ENV PYWIN32_VERSION 224

RUN Write-Host Write-Host 'Installing pywin32 ...'; `
    pip install -q ('pywin32=={0}' -f $env:PYWIN32_VERSION); `
    pip show pywin32;

#--------------------------------------------------------------------
# Install Ruby
#--------------------------------------------------------------------

ENV RUBY_VERSION 2.6.3-1

RUN Install-Ruby -Version $env:RUBY_VERSION -InstallationPath C:\tools\ruby;

#--------------------------------------------------------------------
# Install CMake
#--------------------------------------------------------------------

ENV CMAKE_VERSION 3.15.2

RUN Install-CMake -Version $env:CMAKE_VERSION -InstallationPath C:\tools\cmake;

#--------------------------------------------------------------------
# Install Ninja build system
#--------------------------------------------------------------------

ENV NINJA_VERSION 1.9.0

RUN Register-SystemPath -Path C:\tools\ninja; `
    Install-Ninja -Version $env:NINJA_VERSION -InstallationPath C:\tools\ninja;

#--------------------------------------------------------------------
# Install XAMPP
#--------------------------------------------------------------------

ENV XAMPP_VERSION 7.3.8

RUN Install-Xampp -Version $env:XAMPP_VERSION; `
    Update-XamppPerlLocation -perlPath C:\tools\perl;

#--------------------------------------------------------------------
# Install Fonts
#--------------------------------------------------------------------

RUN Install-AhemFont;

#--------------------------------------------------------------------
# Install GNU tools
#--------------------------------------------------------------------

ENV GPERF_VERSION 3.0.1

RUN Register-SystemPath -Path C:\tools\gperf\bin; `
    Install-Gperf -Version $env:GPERF_VERSION -InstallationPath C:\tools\gperf;

ENV FLEX_VERSION 2.5.4a-1

RUN Register-SystemPath -Path C:\tools\flex\bin; `
    Install-Flex -Version $env:FLEX_VERSION -InstallationPath C:\tools\flex;

ENV BISON_VERSION 2.4.1

RUN Register-SystemPath -Path C:\tools\bison\bin; `
    Install-Bison -Version $env:BISON_VERSION -InstallationPath C:\tools\bison;

ENV DIFFUTILS_VERSION 2.8.7.1

RUN Register-SystemPath -Path C:\tools\diffutils\bin; `
    Install-DiffUtils -Version $env:DIFFUTILS_VERSION -InstallationPath C:\tools\diffutils;

ENV MAKE_VERSION 3.81

RUN Register-SystemPath -Path C:\tools\make\bin; `
    Install-Make -Version $env:MAKE_VERSION -InstallationPath C:\tools\make;

ENV PATCH_VERSION 2.5.9

RUN Register-SystemPath -Path C:\tools\patch\bin; `
    Install-Patch -Version $env:PATCH_VERSION -InstallationPath C:\tools\patch;
