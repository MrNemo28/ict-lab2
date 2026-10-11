# ICT Laboratory 2

Backup scripts for Bash and PowerShell.

## Bash: scripts/backup.sh
Archives ~/ict_lab2/docs into ~/ict_lab2/backup.
Writes results to logs/backup.log.
Deletes backup archives older than 7 days.
Stops with an error if the source directory is missing.

Run in Ubuntu:
bash scripts/backup.sh

## PowerShell: scripts/backup.ps1
Creates ZIP backups of $HOME/ict_lab2/docs.
Writes results to logs/backup.log.
Deletes backup archives older than 7 days.
Stops with an error if the source directory is missing.

Run in Windows PowerShell 7:
pwsh -NoProfile -ExecutionPolicy Bypass -File .\scripts\backup.ps1

## Scheduling
Bash: cron, daily at 22:00.
PowerShell: Windows Task Scheduler, daily at 22:00.

## Training data
The log data used in this laboratory is synthetic.
