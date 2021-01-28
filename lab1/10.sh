#!/bin/bash
man bash |
  tr -s '[:space:]' '\n' |
  grep -Eo '\w'\{4,} |
  sort |
  uniq -c |
  sort -rn -k 1 |
  head -n 3
