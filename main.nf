#!/usr/bin/env nextflow

//
// Provide default value for input parameters
//
params.logs = "logs"
params.archive = "archive"
params.errors = "errors"

//
// Find all log files in the log file directory
//
logFiles = Channel.fromPath("${params.logs}/**.log")

//
// Copy found log files to two channels (similar to `tee`)
//
(toArchive, toFilter) = logFiles.into(2)

//
// Gzip input files and publish them via file copy to the archive directory
//
process gzipToArchive {
  publishDir "${params.archive}", mode: 'copy'

  input:
    file f from toArchive
  output:
    file "${f}.gz"

  """
  gzip -c $f > ${f}.gz
  """
}

//
// Grep input files for lines containing ERROR into output files
//
process grepErrors {

  input:
    file f from toFilter
  output:
    file "${f}.errors" into errors

  """
  grep ERROR $f > ${f}.errors || true
  """
}

//
// Gzip input files and publish them via file copy to the errors directory
//
process gzipToErrors {
  publishDir "${params.errors}", mode: 'copy'

  input:
    file f from errors
  output:
    file "${f}.gz" into toReport

  """
  gzip -c $f > ${f}.gz
  """
}

//
// Send an error report via email/twitter/slack
//
process errorReport {
  input:
  file f from toReport

  // replace with actual script
  """
  [ -s $f ] || echo "Found errors in $f"
  """
}
