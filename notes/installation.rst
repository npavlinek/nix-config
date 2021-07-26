==================
NixOS Installation
==================

Steps
=====

* Partition and format disks.
* Mount all the partitions, *root* should be mounted on ``/mnt``. Enable *swap*
  if on a memory constrained system.
* Generate NixOS configuration using: ``nixos-generate-config --root /mnt``.
* Clone this configuration: ``git clone https://github.com/nkpvk/nix-config.git``.
* Copy files under ``system/`` from this configuration to ``/mnt/etc/nixos/``.
* If it doesn't already exist, create a machine-specific configuration file.
  Then create a symlink to that configuration named ``current.nix`` in
  ``/mnt/etc/nixos/``.
* Perform installation: ``nixos-install``.
* After rebooting into the new system, set the user's password.
* Clone this configuration (again) somewhere more permanent and run
  ``./install.sh setup``. This will bootstrap *home-manager* and install the
  configuration.
