@echo off
echo Installing AWS CLI v2...

REM Download the AWS CLI v2 MSI installer
curl -o AWSCLIV2.msi https://awscli.amazonaws.com/AWSCLIV2.msi

REM Install AWS CLI v2 silently
msiexec.exe /i AWSCLIV2.msi /qn

REM Clean up the downloaded installer
del AWSCLIV2.msi

echo AWS CLI v2 installation complete.
