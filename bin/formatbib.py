#!/usr/bin/env python3

"""
  format .bib files
"""

import sys
import os
import getopt
import string
import random

def bibformat(sin, sout, verbose=False, indent=2):
  """
    format the input and write to output
  """
  collected_lines = [ ]
  max_length_left = 0
  collected_new_booktitles = { }
  # collect lines and counts spaces, etc.
  for line in sin:
    collected_lines.append(line.strip())
    if not '=' in line or line.startswith('@'):
      continue
    left, right = [s.strip() for s in line.split(sep='=', maxsplit=1)]
    if left.lower() == 'booktitle' and (right.startswith('"') or right.startswith('{')):
      collected_new_booktitles[right] = ''.join(random.choice(string.ascii_letters) for x in range(10)).upper()+str(len(collected_new_booktitles)) # generate random string name    
    # 
    left_length = len(left)
    if left_length > max_length_left:
      max_length_left = left_length
  
  # write new string variables to the beginning of the document
  for i,(k,v) in enumerate(collected_new_booktitles.items()):
    print(f'@string{{{v} = {k.strip(",")}}}', file=sout)

  # write formated lines and replace new string variables
  for line in collected_lines:
    if not '=' in line or line.startswith('@'):
      print(line, file=sout)
      continue
    left, right = [s.strip() for s in line.split(sep='=', maxsplit=1)]
    num_spaces = max_length_left - len(left)
    if left.startswith('@'):
      indent = 0
    if left.lower() == 'booktitle' and (right.startswith('"') or right.startswith('{')) and right in collected_new_booktitles:
      right = collected_new_booktitles[right]+','
    print('%s%s%s = %s' % (' '*indent, left, ' '*num_spaces, right), file=sout)

def formatfile(filename, verbose=False, indent=2):
  """
    format a .bib file
  """
  if not filename.endswith('.bib'):
    if verbose:
      print('skipping \'%s\'.' % filename, file=sys.stderr)
    return
  if verbose:
    print('formatting \'%s\'.' % filename, file=sys.stderr)
  os.rename(filename, filename + '.bak')
  with open(filename + '.bak', 'r') as f_in, open(filename, 'w') as  f_out:
    bibformat(f_in, f_out, verbose=verbose, indent=indent)

def formatfiles(filenames, verbose=False, indent=2):
  """
    format .bib files
  """
  for filename in filenames:
    formatfile(filename, verbose=verbose, indent=indent)

def usage():
  """
    print a usage message
  """
  progname = os.path.basename(sys.argv[0])
  print('Usage: %s [OPTIONS] <BIB-file(s)>' % progname)
  print('')
  print('Formats BIB files.')
  print('')
  print('Options:')
  print('   -i indent.')
  print('   -v verbose.')
  print('   -h display this help message.')

def main():
  """
   The main entrypoint
  """
  try:
    opt_pairs, filenames = getopt.gnu_getopt(sys.argv[1:], "h?i:v", ["help"])
  except getopt.GetoptError as err:
    print(str(err), file=sys.stderr)
    usage()
    sys.exit(1)
  if opt_pairs:
    opts = dict(opt_pairs)
  else:
    opts = {}
  if ('-h' in opts) or ('--help' in opts) or ('-?' in opts):
    usage()
    sys.exit()
  verbose = '-v' in opts
  if verbose:
    print('options:  \'%s\'.' % repr(opts), file=sys.stderr)
  indent = int(opts['-i']) if '-i' in opts else 2

  if filenames:
    formatfiles(filenames, verbose=verbose, indent=indent)
  else:
    bibformat(sys.stdin, sys.stdout, verbose=verbose, indent=indent)

if __name__ == "__main__":
  try:
    main()
  except (KeyboardInterrupt, SystemExit):
    print(file=sys.stderr) # print a newline
