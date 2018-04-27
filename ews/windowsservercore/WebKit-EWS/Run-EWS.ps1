Write-Host 'EWS information';
Write-Host ('Queue: {0}' -f $env:EWS_QUEUE_NAME);
Write-Host ('Name: {0}' -f $env:EWS_SERVER_NAME);
Write-Host ('Iterations: {0}' -f $env:EWS_ITERATIONS)

# Print the host information
$cs = Get-WMIObject -Class Win32_ComputerSystem;
Write-Host ('Host system');
Write-Host ('Processors: {0}' -f $cs.NumberOfProcessors);
Write-Host ('Logical processors: {0}' -f $cs.NumberOfLogicalProcessors);
Write-Host ('Total Physical Memory: {0:f2}gb' -f ($cs.TotalPhysicalMemory /1Gb));

# Sanity check the configuration to make sure it is setup properly
$minProcessors = 4;

if ($cs.NumberOfLogicalProcessors -lt $minProcessors) {
  Write-Error ('WebKit builds need to have at least {0} processors available.
Make sure the number of processors is specified when starting the container
  docker run --cpu-count={0}' -f $minProcessors);
}

$minPhysicalMemory = 12;

if ($cs.TotalPhysicalMemory -lt ($minPhysicalMemory * 1Gb)) {
  Write-Error ('WebKit builds need to have at least {0}Gbs of memory available.
Make sure the amount of memory is specified when starting the container
  docker run --memory={0}g' -f $minPhysicalMemory);
}

# Initialize the Visual Studio environment
Write-Host 'Initializing Visual Studio environment';

Select-VSEnvironment;

# Clone WebKit repository
$gitUrl = Get-WebKitGitUrl;
Write-Host ('git clone {0} WebKit' -f $gitUrl);
git clone $gitUrl WebKit

# Run any additional startup scripts
$scriptPath = Join-Path $PSScriptRoot 'Scripts';

Write-Host ('Looking in {0} for additional startup scripts' -f $scriptPath);

$scripts = @();

if (Test-Path $scriptPath) {
  $scripts = Get-ChildItem -Path $scriptPath -Filter '*.ps1';
}

Write-Host ('{0} scripts found' -f $scripts.Count);

foreach ($script in $scripts) {
  $invocation = '& {0}' -f $script.FullName;
  Write-Host $invocation;
  Invoke-Expression $invocation;
}

# Setup credentials
Set-Location WebKit;

Write-Host ('git config core.autocrlf false');
git config core.autocrlf false;
Write-Host ('git config bugzilla.username {0}' -f $env:BUGZILLA_USERNAME);
git config bugzilla.username $env:BUGZILLA_USERNAME;
Write-Host 'git config bugzilla.password ********'
git config bugzilla.password $env:BUGZILLA_PASSWORD;

# Start the script
Write-Host 'Starting EWS bot';

& Tools/EWSTools/Start-Queue.ps1 -Queue $env:EWS_QUEUE_NAME -Name $env:EWS_SERVER_NAME -Iterations $env:EWS_ITERATIONS;
