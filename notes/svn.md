SVN Notes
======
http://www.linuxfromscratch.org/blfs/edguide/chapter03.htmlcopy


Diff
  svn diff -r BASE:HEAD <file>

svn copy trunk/ tags/TAG_NAME
svn info

Adding New Project to SVN

svn add --force .
svn mkdir subdir2

svn diff --summarize -r 16077:HEAD url1

Make A Branch
svn copy url1 url2

Ignore Files or Directories
svn propedit svn:ignore .

Commit to server
svn commit -m "changes you made"

Change SVN Servers:
svn cleanup
svn switch --relocate url1 url2
