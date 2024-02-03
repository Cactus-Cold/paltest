
FOR /F "tokens=* USEBACKQ" %%F IN (`git branch --show-current`) DO (
SET currentbranch=%%F
)

FOR /F "tokens=* USEBACKQ" %%F IN (`git config user.name`) DO (
SET gitName=%%F
)
set YYYYMMDD=%DATE:~10,4%%DATE:~4,2%%DATE:~7,2%

if not %currentbranch%==main (
call git add .
call git commit -m "Saved game"
call git push
call git checkout main
call git pull origin main
) else (
call git checkout .
call git clean -fd
)

call git branch %gitName%%YYYYMMDD%
call git checkout %gitName%%YYYYMMDD%
call git push --set-upstream origin %gitName%%YYYYMMDD%

start steam://rungameid/1623730
pause

call git add .
call git commit -m "Saved game"
call git push
call git checkout main
call git pull origin main
call git merge -Xtheirs %gitName%%YYYYMMDD% && call git branch -d %gitName%%YYYYMMDD%
call git push