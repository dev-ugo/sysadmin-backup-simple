#!/bin/bash

# --- Configuration ---
SOURCE_DIR="./data/important_files"
BACKUP_DIR="./backups"
LOG_FILE="./logs/backup.log"
RETENTION_DAYS=7
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_NAME="backup_$TIMESTAMP.tar.gz"

# Create log file if it doesn't exist
touch "$LOG_FILE"

# Function for logging messages to both terminal and file
log_message() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") : $1" | tee -a "$LOG_FILE"
}

log_message "Starting backup..."

# 1. VVerification if the source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    log_message "ERROR: The source directory $SOURCE_DIR does not exist."
    exit 1
fi

# 2. Creation of the compressed archive (tar -c: create, -z: gzip, -f: file)
if tar -czf "$BACKUP_DIR/$BACKUP_NAME" "$SOURCE_DIR"; then
    log_message "Backup successful : $BACKUP_NAME"
else
    log_message "ERROR : Compression failed."
    exit 1
fi

# 3. Rotation of backups (Delete files older than X days)
log_message "Cleaning up old backups (older than $RETENTION_DAYS days)..."
# find : search in the directory, -name : the backup files, -mtime : modified more than X days ago, -delete : delete them
find "$BACKUP_DIR" -name "backup_*" -type f -mtime +"$RETENTION_DAYS" -delete

log_message "Finished the procedure."