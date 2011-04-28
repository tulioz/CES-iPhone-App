Change Log
==========
Eventually we'll put some real changes here.

Bugs
====
I figured I'd start a list of bugs.

Without a valid phone number, address, name, type, etc. being present in the DB, the mobile client will crash when it attempts to parse the JSON feed. i.e. figure out a better way to handle NULLs from the whole MySQL => JSON API => Mobile app transition.

Other Notes
===========
