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

### Running minnebar15-workflow

To run on a clone of this repository, with test data in `logs`, use `nextflow run main.nf`
```
$ nextflow run main.nf
N E X T F L O W  ~  version 20.07.1
Launching `main.nf` [curious_pasteur] - revision: 38d3e76045
executor >  local (16)
[63/d96483] process > gzipToArchive (2) [100%] 4 of 4 ✔
[30/0f4552] process > grepErrors (3)    [100%] 4 of 4 ✔
[a1/6b9a89] process > gzipToErrors (4)  [100%] 4 of 4 ✔
[90/38ed3f] process > errorReport (4)   [100%] 4 of 4 ✔
```

To run on your own directory of log files, provide the `--logs` param argument
```
$ nextflow run heuermh/minnebar15-workflow --logs logs/
N E X T F L O W  ~  version 20.07.1
Launching `heuermh/minnebar15-workflow` [nostalgic_shockley] - revision: a486e52009 [main]
executor >  local (4)
[5b/d37f9d] process > gzipToArchive (1) [100%] 1 of 1 ✔
[a9/e350b5] process > grepErrors (1)    [100%] 1 of 1 ✔
[0b/a6e991] process > gzipToErrors (1)  [100%] 1 of 1 ✔
[89/a3bc20] process > errorReport (1)   [100%] 1 of 1 ✔
```

To run on Docker, provide a container image via `-with-docker`
```
$ nextflow run heuermh/minnebar15-workflow --logs logs/ -with-docker ubuntu:18.04
N E X T F L O W  ~  version 20.07.1
Launching `heuermh/minnebar15-workflow` [gigantic_bell] - revision: a486e52009 [main]
executor >  local (4)
[ca/9dab2e] process > gzipToArchive (1) [100%] 1 of 1 ✔
[97/17a0f2] process > grepErrors (1)    [100%] 1 of 1 ✔
[b3/cb39ff] process > gzipToErrors (1)  [100%] 1 of 1 ✔
[3f/b297c3] process > errorReport (1)   [100%] 1 of 1 ✔
```
