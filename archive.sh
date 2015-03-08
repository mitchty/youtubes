#!/usr/bin/env sh
#-*-mode: Shell-script; coding: utf-8;-*-
export script=$(basename "$0")
export dir=$(cd "$(dirname "$0")"; pwd)
export iam=${dir}/${script}

for file in youtube-* vimeo-* channel9-*; do
  service=$(echo "${file}" | awk -F- '{print $1}' | sort | uniq)
  user=$(echo "${file}" | awk -F- '{print $3}')
  subdir="${service}/"$(echo ${user} | sort | uniq)
  [ ! -d "${subdir}" ] && mkdir -p "${subdir}"

  if [ -e "${file}" ]; then
      new_name=$(echo ${file} | sed -e "s|${service}-||" -e "s|${user}-||")
      echo mv "${file}" "${subdir}/${new_name}"
      mv "${file}" "${subdir}"
  fi
done
