# nix-config

## Installation

### Prerequisites

* [home-manager][1]

If installing for the first time or upgrading [home-manager][1] to the latest
version:

```
./install.sh setup
```

After setting up [home-manager][1], if you want to install the user
configuration -- i.e. everything under `user`:

```
./install.sh user
```

If you want to install the system configuration -- i.e. everything under
`system`:

```
./install.sh system
```

You can do both the system and the user installation in one step as well:

```
./install.sh all
```

[1]: https://github.com/nix-community/home-manager

## License

MIT
