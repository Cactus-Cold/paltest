
FOR /F "tokens=* USEBACKQ" %%F IN (`git branch --show-current`) DO (
SET currentbranch=%%F
)

FOR /F "tokens=* USEBACKQ" %%F IN (`git config user.name`) DO (
SET gitName=%%F
)

for /f %%i in (host.txt) do (
 set palid=%%i
)

set YYYYMMDD=%DATE:~10,4%%DATE:~4,2%%DATE:~7,2%

if %currentbranch%==main (
call git checkout .
call git clean -fd
call git branch %gitName%%YYYYMMDD%
call git checkout %gitName%%YYYYMMDD%
call git push --set-upstream origin %gitName%%YYYYMMDD%
) else (
copy Players\00000000000000000000000000000001.sav Players\%palid%.sav
call git add .
call git commit -m "Saved game"
call git push
call git checkout main
call git pull origin main
)
call git lfs lock *.sav

copy Players\%palid%.sav Players\00000000000000000000000000000001.sav

start steam://rungameid/1623730
pause

copy Players\00000000000000000000000000000001.sav Players\%palid%.sav

call git add .
call git commit -m "Saved game"
call git push
call git checkout main
call git pull origin main
call git merge -Xtheirs %gitName%%YYYYMMDD% && call git branch -d %gitName%%YYYYMMDD%
call git push && call git push origin --delete %gitName%%YYYYMMDD%
call git lfs unlock *.sav