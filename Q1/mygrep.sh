#!/bin/bash

if [[ "$1" == "--help" ]]; then
  echo "Usage: ./mygrep.sh [options] search_string filename"
  echo "Options:"
  echo "  -n    Show line numbers"
  echo "  -v    Invert match (show lines that don't match)"
  exit 0
fi



show_line_numbers=false
invert_match=false


while getopts "nv" opt; do
  case "$opt" in
    n) show_line_numbers=true ;;
    v) invert_match=true ;;
    \?)
    echo "Error: Not enough arguments."
    echo "Use --help to see usage."
      exit 1
      ;;
  esac
done

shift $((OPTIND - 1))


if [ $# -lt 2 ]; then
  echo "Error: Not enough arguments."
  exit 1
fi


search="$1"
file="$2"


if [ ! -f "$file" ]; then
  echo "Error: File not found: $file"
  exit 1
fi


search_lower=$(echo "$search" | tr 'A-Z' 'a-z')


line_number=0
while IFS= read -r line; do
  line_number=$((line_number + 1))


  line_lower=$(echo "$line" | tr 'A-Z' 'a-z')


  if [[ "$line_lower" == *"$search_lower"* ]]; then
    matched=true
  else
    matched=false
  fi

    if $invert_match; then
    if $matched; then
        matched=false
    else
        matched=true
    fi
    fi


  if $matched; then
    highlight_line=$(echo "$line" | sed "s/\($search\)/\x1b[31m\1\x1b[0m/Ig")
    if $show_line_numbers; then
      echo "${line_number}:$highlight_line"
    else
      echo "$highlight_line"
    fi
  fi
done < "$file"
