# CyanUI

A UI component library for [Fusion](https://github.com/dphfox/Fusion).

## Examples
See [UI Utilities ↗️](https://devforum.roblox.com/t/3400451)


## Installing

Installing with Wally is preferred:

```toml
# wally.toml
[dependencies]
Fusion = "elttob/fusion@0.3.0"
CyanUI = "gcaptn/cyan-ui@0.1.7"
```

If you're using the standalone module, you'll also have to use the Fusion package inside of it.

## Developing

CyanUI uses the `tomlrun` NodeJS script runner.

To set up, run:

```sh
aftman install

npm install # Install the tomlrun script runner

wally install

# Always run after installing Wally packages
npm run tomlrun fix-package-types

# Generate a sourcemap file for development with the Luau LSP
npm run tomlrun lsp-sourcemap
```

To start a Rojo session:

```
npm run tomlrun dev
```

More scripts can be found in the `scripts.toml` file.