============
 nix-config
============

Personal NixOS configuration

Installation
============

Prerequisites
-------------

* `home-manager <https://github.com/nix-community/home-manager>`_

Initial
-------

.. code:: bash

  copy-user-config
  setup-home-manager

System config
-------------

This example uses ``sudo``, but you can also use ``doas``, or something similar.
All that's required is that the tool retains your environment, because the
*HOME* environment variable is used.

.. code:: bash

  sudo -E copy-system-config
  sudo nixos-rebuild switch  # or another sub-command

User config
-----------

.. code:: bash

  copy-user-config
  home-manager switch  # or another sub-command

License
=======

Unlicense, see ``LICENSE.rst`` for more information or visit
`<http://unlicense.org/>`_.
