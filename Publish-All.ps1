Param(
  [Parameter(Mandatory)]
  [ValidateSet('1709','1803','1809','windows-1809')]
  [string] $tag
)

$ErrorActionPreference = 'Stop';

Function Publish-WebKitDockerImage {
  Param(
    [Parameter(Mandatory)]
    [string] $image,
    [Parameter(Mandatory)]
    [string] $tag
  )

  $cmd = 'docker push webkitdev/{0}:{1}' -f $image, $tag;

  Write-Host $cmd;
  Invoke-Expression $cmd;
}

Publish-WebKitDockerImage -Image base -Tag $tag;
Publish-WebKitDockerImage -Image scripts -Tag $tag;
Publish-WebKitDockerImage -Image scm -Tag $tag;
Publish-WebKitDockerImage -Image tools -Tag $tag;
Publish-WebKitDockerImage -Image msbuild -Tag $tag;
Publish-WebKitDockerImage -Image buildbot -Tag $tag;
Publish-WebKitDockerImage -Image ews -Tag $tag;
