@echo off
REM === CONFIG AUTORI ===
set DAVIDE_NAME=DavideOrienti
set DAVIDE_EMAIL=orientidavide@gmail.com
set MATTEO_NAME=matteo2911
set MATTEO_EMAIL=mat.romeo@stud.uniroma3.it

REM === RECUPERO DATA ULTIMO COMMIT ===
FOR /F "usebackq tokens=* delims=" %%i IN (`git log -1 --format=%%aI`) DO set LAST_DATE=%%i

echo Ultima data commit: %LAST_DATE%

REM === CREO SCRIPT PYTHON PER FILTRARE ===
(
echo import datetime
echo start_date = datetime.datetime.fromisoformat("%LAST_DATE%".replace("Z","+00:00"))
echo davide_name = b"%DAVIDE_NAME%"
echo davide_email = b"%DAVIDE_EMAIL%"
echo matteo_name = b"%MATTEO_NAME%"
echo matteo_email = b"%MATTEO_EMAIL%"
echo.
echo def commit_callback(commit, metadata):
echo.    idx = metadata.commit_count - metadata.current_commit
echo.    if idx %% 2 == 0:
echo.        commit.author_name = davide_name
echo.        commit.author_email = davide_email
echo.        commit.committer_name = davide_name
echo.        commit.committer_email = davide_email
echo.    else:
echo.        commit.author_name = matteo_name
echo.        commit.author_email = matteo_email
echo.        commit.committer_name = matteo_name
echo.        commit.committer_email = matteo_email
echo.
echo.    commit_date = start_date - datetime.timedelta(days=2 * idx)
echo.    date_str = commit_date.strftime("%%a, %%d %%b %%Y %%H:%%M:%%S +0200")
echo.    commit.author_date = date_str.encode()
echo.    commit.committer_date = date_str.encode()
) > rewrite_commits.py

REM === ESECUZIONE FILTER-REPO ===
git filter-repo --commit-callback "exec(open('rewrite_commits.py').read())"

echo === RISCRITTURA COMPLETATA ===
echo Ora esegui: git push --force
pause
