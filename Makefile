.PHONY: help backup check clean

.DEFAULT_GOAL := help

help: 
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

backup:
	./backup.sh

check: ## Verify the integrity of the latest backup archive
	@echo "Verifying the integrity of the latest archive..."
	@LATEST_BACKUP=$$(ls -t backups/backup_*.tar.gz 2>/dev/null | head -n 1); \
	if [ -z "$$LATEST_BACKUP" ]; then \
		echo "No backup found in the backups/ directory."; \
		exit 1; \
	fi; \
	echo "Archive inspected : $$LATEST_BACKUP"; \
	tar -tzf "$$LATEST_BACKUP" > /dev/null && echo "The archive is valid, readable and not corrupted." || (echo "ERROR : The archive is corrupted!" && exit 1)

clean: ## Delete all backup archives and log files
	rm -f backups/*.tar.gz
	rm -f logs/*.log
	@echo "Folders 'backups/' and 'logs/' have been cleaned."