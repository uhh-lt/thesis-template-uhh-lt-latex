#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Feb  4 14:30:05 2022

@author: rem
"""

import sys
import os
import re


item_key_regex= r'^\s*\\item\[(?P<key>.*)\].*$'


def sort_elements(fhin, fhout):
  lines_before = [ ]
  lines_after = [ ]
  items = [ ]
  item_set = set()


  # collect lines and items
  for line in fhin:
    if not len(line.strip()):
      continue
    if not '\\item[' in line.strip():
      if not len(items):
        lines_before.append(line)
      else:
        lines_after.append(line)
      continue
    # else an item was found
    matches= re.search(item_key_regex, line)
    if matches and 'key' in matches.groupdict():
      item_key = matches['key']
    if item_key in item_set:
      print(f'Found duplicate item key \'{item_key}\'.')
    items.append((item_key, line))
    item_set.add(item_key)

  for line in lines_before:
    print(line, file=fhout, end='')
  print('',file=fhout)
  for key, line in sorted(items, key=lambda x: x[0].lower()):
    print(line, file=fhout)
  for line in lines_after:
    print(line, file=fhout, end='')


def formatfile(filename, indent=2):
  '''
    sort elements in abbreviations file
  '''
  print(f'sorting entries in \'{filename}\'.', file=sys.stderr)
  os.rename(filename, filename + '.bak')
  with open(filename + '.bak', 'r') as fhin, open(filename, 'w') as  fhout:
    sort_elements(fhin, fhout)


if __name__ == '__main__':
  if len(sys.argv) < 2:
    print('Usage: python order_abbreviations.py <filename.tex>')
    exit -1
  formatfile(sys.argv[1])
