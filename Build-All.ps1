Param(
  [Parameter(Mandatory)]
  [ValidateSet('1803','1809','1903','windows-1809','windows-1903')]
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
  if ($image -eq 'base') {
    $file = Join-Path $path ('Dockerfile.{0}' -f $tag);
    $buildArgs = '';
  } else {
    $file = Join-Path $path 'Dockerfile';
    $buildArgs = ('--build-arg IMAGE_TAG={0}' -f $tag);
  }

  $cmd = 'docker build -t webkitdev/{0}:{1} {2} -f {3} {4}' -f $image, $tag, $buildArgs, $file, $path;

  Write-Host ('Starting build at {0}' -f (Get-Date))
  Write-Host $cmd;
  Invoke-Expression $cmd;
}

Build-WebKitDockerImage -Image base -Tag $tag;
Build-WebKitDockerImage -Image scripts -Tag $tag;
Build-WebKitDockerImage -Image scm -Tag $tag;
Build-WebKitDockerImage -Image tools -Tag $tag;
Build-WebKitDockerImage -Image msbuild -Tag $tag;
Build-WebKitDockerImage -Image buildbot -Tag $tag;
Build-WebKitDockerImage -Image ews -Tag $tag;
