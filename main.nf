#!/usr/bin/env nextflow

logFiles = Channel.fromPath('logs/**.log')

(toArchive, toFilter) = logFiles.into(2)

process gzipToArchive {
  publishDir 'archive', mode: 'copy'

  input:
    file f from toArchive
  output:
    file "${f}.gz"

  """
  gzip -c $f > ${f}.gz
  """
}

process grepErrors {
  input:
    file f from toFilter
  output:
    file "${f}.errors" into errors

  """
  grep ERROR $f > ${f}.errors
  """
}

process gzipToErrors {
  publishDir 'errors', mode: 'copy'

  input:
    file f from errors
  output:
    file "${f}.gz"

  """
  gzip -c $f > ${f}.gz
  """
}
