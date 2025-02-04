# CyanUI

A Fusion UI library

## Installation

Installing with Wally is preferred:

```toml
# wally.toml
[dependencies]
Fusion = "elttob/fusion@0.3.0"
CyanUI = "gcaptn/cyan-ui@0.1.7"
```

If you're using the standalone module, you'll have to use the Fusion package inside of it.

## Developing

CyanUI uses the `tomlrun` NodeJS script runner.

```sh
npm install # Install script runner

wally install
npm tomlrun fix-package-types # Always run after installing

# Generate a sourcemap for Luau LSP-friendly development in an IDE
npm tomlrun lsp-sourcemap 
```

More scripts can be found in the `scripts.toml` file.