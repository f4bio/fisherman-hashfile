[![Build Status][travis-badge]][travis-link]
[![Slack Room][slack-badge]][slack-link]

# hashfile

EXAMPLE/TESTING PROJECT!
wrapper around:
```
$ cd (dirname FILENAME)
$ rhash -o FILENAME.md5 --md5 FILENAME
$ rhash -c FILENAME.md5
```

## Install

With [fisherman]

```
fisher f4bio/hashfile
```

## Usage

```fish
hashfile [md5|sha1|sha3] /path/to/file
```

[travis-link]: https://travis-ci.org/f4bio/hashfile
[travis-badge]: https://img.shields.io/travis/f4bio/hashfile.svg
[slack-link]: https://fisherman-wharf.herokuapp.com
[slack-badge]: https://fisherman-wharf.herokuapp.com/badge.svg
[fisherman]: https://github.com/fisherman/fisherman
