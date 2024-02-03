
call git checkout main
call git clean -fd
call git pull

FOR /F "tokens=* USEBACKQ" %%F IN (`git config user.name`) DO (
SET gitName=%%F
)
set YYYYMMDD=%DATE:~10,4%%DATE:~4,2%%DATE:~7,2%
echo %gitName% + %YYYYMMDD%

call git checkout -b %gitName%%YYYYMMDD%
rem call git 

pause