
## How to fix warning about ECDSA host key [here](https://superuser.com/questions/421004/how-to-fix-warning-about-ecdsa-host-key)

```
Tia@DESKTOP-18RKIM8 MINGW64 ~
$ ssh tia@10.0.0.36
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle attack)!
It is also possible that a host key has just been changed.
The fingerprint for the ECDSA key sent by the remote host is
SHA256:iJ9W16xK/HKi+Xilixgt3Fv1MRPIRF7L4W7U+x2Z9EU.
Please contact your system administrator.
Add correct host key in /c/Users/Tia/.ssh/known_hosts to get rid of this message.
Offending ECDSA key in /c/Users/Tia/.ssh/known_hosts:11
ECDSA host key for 10.0.0.36 has changed and you have requested strict checking.
Host key verification failed.
```

```sh
#Remove the cached key for 10.0.0.36 on the local machine:

Tia@DESKTOP-18RKIM8 MINGW64 ~
$ ssh-keygen -R 10.0.0.36
# Host 10.0.0.36 found: line 11
/c/Users/Tia/.ssh/known_hosts updated.
Original contents retained as /c/Users/Tia/.ssh/known_hosts.old
```