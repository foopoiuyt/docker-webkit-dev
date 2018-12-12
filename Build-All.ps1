Param(
  [Parameter(Mandatory)]
  [ValidateSet('1709','1803','1809')]
  [string] $tag
)

$ErrorActionPreference = 'Stop';

Function Build-WebKitDockerImage {
  Param(
    [Parameter(Mandatory)]
    [string] $image,
    [Parameter(Mandatory)]
    [string] $tag
  )

  $path = Join-Path $PSScriptRoot $image;
  $file = Join-Path $path ('Dockerfile.{0}' -f $tag);
  $cmd = 'docker build -t webkitdev/{0}:{1} -f {2} {3}' -f $image, $tag, $file, $path;

  Write-Host ('Starting build at {0}' -f (Get-Date))
  Write-Host $cmd;
  Invoke-Expression $cmd;
}

Build-WebKitDockerImage -Image scripts -Tag $tag;
Build-WebKitDockerImage -Image scm -Tag $tag;
Build-WebKitDockerImage -Image tools -Tag $tag;
Build-WebKitDockerImage -Image msbuild -Tag $tag;
Build-WebKitDockerImage -Image buildbot -Tag $tag;
Build-WebKitDockerImage -Image ews -Tag $tag;
