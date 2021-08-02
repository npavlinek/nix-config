============
 nix-config
============
------------------------------
 Personal NixOS configuration
------------------------------

Installation
============

Prerequisites
-------------

* `home-manager <https://github.com/nix-community/home-manager>`_

Initial
-------

::

  copy-user-config
  setup-home-manager

System config
-------------

This example uses ``sudo``, but you can also use ``doas``, or something similar.
All that's required is that the tool retains your environment, because the
*HOME* environment variable is used.

::

  sudo -E copy-system-config
  sudo nixos-rebuild switch  # or another sub-command

User config
-----------

::

  copy-user-config
  home-manager switch  # or another sub-command

License
=======

MIT
