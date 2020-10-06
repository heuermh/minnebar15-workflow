# minnebar15-workflow
Nextflow workflow for Minnebar15 presentation

### Example workflow

Find all the log files, gzip them to archive directory
```bash
find /my/logs -name "*.log" \
  -exec sh -c 'gzip -c {} > archive/{}.gz' \;
```

Find all the log files, grep for lines containing `ERROR`, and gzip them to the errors directory
```bash
find /my/logs -name "*.log" \
  -exec sh -c 'grep ERROR {} | gzip -c > errors/{}.gz' \;
```

Send an error report via email/twitter/slack
```bash
send_error_report.py errors/
```
