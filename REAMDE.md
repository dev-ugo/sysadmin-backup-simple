# Automated Simple Linux Backup System

> **About**: This project was created as part of my learning journey into System Administration and DevOps practices.

## Tech Stack

- **Scripting**: Bash
- **Automation**: Cron (System Scheduler)
- **Orchestration & Testing**: GNU Make
- **Archiving**: Tar / Gzip

## Features

- **Automated Archiving**: Compresses designated target directories.
- **Log Management**: Records every success and failure with timestamps.
- **Retention Policy**: Automatically deletes backups older than 7 days to free up disk space.
- **Integrity Checking**: Verifies that the compressed archives are not corrupted.

## How to use this project?

This project uses a `Makefile` to simplify administration tasks. In your terminal, type:

```bash
make help
```

### 1. Manual Backup
To trigger the backup script manually:
```bash
make backup
```
*The archive will be stored in the `backups/` directory, and logs will be written in `logs/`.*

### 2. Integrity Check (Crucial)
A backup is only good if it can be restored. To test the integrity of the most recent archive without extracting it:
```bash
make check
```

### 3. Clean Test Environment
To remove all generated archives and logs:
```bash
make clean
```

## Cron Automation

In a real-world scenario, this script is executed daily via a cron job. To configure it, run `crontab -e` and add the following line to execute the backup every day at 2:00 AM:

```text
00 02 * * * /absolute/path/to/sysadmin-backup-simple/backup.sh
```