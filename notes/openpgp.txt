OpenPGP Email Security Notes
-------------------

MAC ============================================

Install Mozilla Thunderbird
	http://www.mozilla.org/en-US/thunderbird/
Install Enigmail Thunderbird Addon
	https://www.enigmail.net/home/index.php
Install GpGTools
	https://gpgtools.org/

Command line notes:
	http://coredump.io/blog/2013/04/29/gpg-for-people-that-dont-like-gpg/



Ubuntu ============================================

See all my keys:
```
gpg --list-keys dave@dav.ee
```

Decrypt message:
```
gpg --decrypt file.txt
```

Encrypt message:
```
gpg --armor --encrypt file.txt
```
