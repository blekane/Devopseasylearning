## Python Modules and working with platform module
- A module is a file containing Python definition and statements. 
- It contain Python functions, classes and variables
- To import a module into another script, you don't need to put `.py`
- It is like variables is terraform
- We also have default modules that we can import it and just used it `os, time, etc.`

### How to list all python modules?
```
help("modules") 
```
```py
import os
dir(os)
help(os)


import subprocess as sp
dir(subprocess) #list all function and variables in subprocess module
help(subprocess) # to get help
```

## How to get all build in modules
```py
help("modules") 
```
```
Please wait a moment while I gather a list of all available modules...

__future__          _threading_local    getpass             sched
_abc                _tkinter            gettext             secrets
_aix_support        _tracemalloc        glob                select
_ast                _uuid               graphlib            selectors
_asyncio            _warnings           gzip                setuptools
_bisect             _weakref            hashlib             shelve
_blake2             _weakrefset         heapq               shlex
_bootsubprocess     _winapi             hmac                shutil
_bz2                _xxsubinterpreters  html                signal
_codecs             _zoneinfo           http                site
_codecs_cn          abc                 idlelib             smtpd
_codecs_hk          aifc                imaplib             smtplib
_codecs_iso2022     antigravity         imghdr              sndhdr
_codecs_jp          argparse            imp                 socket
_codecs_kr          array               importlib           socketserver
_codecs_tw          ast                 inspect             sqlite3
_collections        asynchat            io                  sre_compile
_collections_abc    asyncio             ipaddress           sre_constants
_compat_pickle      asyncore            itertools           sre_parse
_compression        atexit              json                ssl
_contextvars        audioop             keyword             stat
_csv                autopep8            lib2to3             statistics
_ctypes             base64              linecache           string
_ctypes_test        bdb                 locale              stringprep
_datetime           binascii            logging             struct
_decimal            binhex              lzma                subprocess
_distutils_hack     bisect              mailbox             sunau
_elementtree        builtins            mailcap             symtable
_functools          bz2                 marshal             sys
_hashlib            cProfile            math                sysconfig
_heapq              calendar            mimetypes           tabnanny
_imp                cgi                 mmap                tarfile
_io                 cgitb               modulefinder        telnetlib
_json               chunk               msilib              tempfile
_locale             cmath               msvcrt              test
_lsprof             cmd                 multiprocessing     textwrap
_lzma               code                netrc               this
_markupbase         codecs              nntplib             threading
_md5                codeop              nt                  time
_msi                collections         ntpath              timeit
_multibytecodec     colorsys            nturl2path          tkinter
_multiprocessing    compileall          numbers             token
_opcode             concurrent          opcode              tokenize
_operator           configparser        operator            toml
_osx_support        contextlib          optparse            trace
_overlapped         contextvars         os                  traceback
_pickle             copy                pathlib             tracemalloc
_py_abc             copyreg             pdb                 tty
_pydecimal          crypt               pickle              turtle
_pyio               csv                 pickletools         turtledemo
_queue              ctypes              pip                 types
_random             curses              pipes               typing
_sha1               dataclasses         pkg_resources       unicodedata
_sha256             datetime            pkgutil             unittest
_sha3               dbm                 platform            urllib
_sha512             decimal             plistlib            uu
_signal             difflib             poplib              uuid
_sitebuiltins       dis                 posixpath           venv
_socket             distutils           pprint              warnings
_sqlite3            doctest             profile             wave
_sre                email               pstats              weakref
_ssl                encodings           pty                 webbrowser
_stat               ensurepip           py_compile          winreg
_statistics         enum                pyclbr              winsound
_string             errno               pycodestyle         wsgiref
_strptime           faulthandler        pydoc               xdrlib
_struct             filecmp             pydoc_data          xml
_symtable           fileinput           pyexpat             xmlrpc
_testbuffer         fnmatch             queue               xxsubtype
_testcapi           fractions           quopri              zipapp
_testconsole        ftplib              random              zipfile
_testimportmultiple functools           re                  zipimport
_testinternalcapi   gc                  reprlib             zlib
_testmultiphase     genericpath         rlcompleter         zoneinfo
_thread             getopt              runpy
```


















