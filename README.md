# search-flake-inputs

Recursively search for flake inputs

## Usage

```sh
nix run github:shivaraj-bh/search-flake-inputs -- --flake <flake-url> --input <flake-input>
```

## Examples

```sh
$ nix run . -- -f github:nammayatri/nammayatri/814e6fe389f93de81dcb125a97aed611bf52e8bd -i shared-kernel
╭───┬────────────────────────────────────────────────┬──────────╮
│ # │                      path                      │   rev    │
├───┼────────────────────────────────────────────────┼──────────┤
│ 0 │ locks->nodes->namma-dsl->inputs->shared-kernel │ b0049d7e │
│ 1 │ locks->nodes->root->inputs->shared-kernel      │ 81e4688d │
╰───┴────────────────────────────────────────────────┴──────────╯

```
```sh
$ nix run . -- -f github:nammayatri/nammayatri -i hedis
╭───┬───────────────────────────────────────┬──────────╮
│ # │                 path                  │   rev    │
├───┼───────────────────────────────────────┼──────────┤
│ 0 │ locks->nodes->euler-hs->inputs->hedis │ 92a3d5ab │
╰───┴───────────────────────────────────────┴──────────╯

```
```sh
$ git clone https://github.com/shivaraj-bh/search-flake-inputs
$ cd search-flake-inputs
$ nix run . -- -f . -i nixpkgs
╭───┬──────────────────────────────────────┬──────────╮
│ # │                 path                 │   rev    │
├───┼──────────────────────────────────────┼──────────┤
│ 0 │ locks->nodes->nuenv->inputs->nixpkgs │ 91050ea1 │
│ 1 │ locks->nodes->root->inputs->nixpkgs  │ ea780f3d │
╰───┴──────────────────────────────────────┴──────────╯

```

## Development
```sh
nix run nixpkgs#watchexec -- -e nix -e nu nix run . -- -f <flake-url> -i <flake-input>
```


