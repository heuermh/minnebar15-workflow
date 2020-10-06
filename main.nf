#!/usr/bin/env nextflow

params.logs = "${baseDir}/logs"
params.archive = "${baseDir}/archive"
params.errors = "${baseDir}/errors"

logFiles = Channel.fromPath("${params.logs}/**.log")

(toArchive, toFilter) = logFiles.into(2)

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
  publishDir "${params.errors}", mode: 'copy'

  input:
    file f from errors
  output:
    file "${f}.gz"

  """
  gzip -c $f > ${f}.gz
  """
}
