#!/usr/bin/env sh
#-*-mode: Shell-script; coding: utf-8;-*-
export script=$(basename "$0")
export dir=$(cd "$(dirname "$0")"; pwd)
export iam=${dir}/${script}

for file in youtube*; do
  subdir=$(echo "${file}" | awk -F- '{print $3}' | sort | uniq)
  [ ! -d "${subdir}" ] && mkdir "${subdir}"
  echo mv "${file}" "${subdir}"
  mv "${file}" "${subdir}"
done
