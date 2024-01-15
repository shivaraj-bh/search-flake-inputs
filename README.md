# search-flake-inputs

Recursively search for flake inputs

## Usage

```sh
nix run github:shivaraj-bh/search-flake-inputs -- --flake <flake-url> --input <flake-input>
```

## Examples

### multiple-instances
```sh
nix run github:shivaraj-bh/search-flake-inputs -- -f github:nammayatri/nammayatri/814e6fe389f93de81dcb125a97aed611bf52e8bd -i shared-kernel
```
```sh
# Output
╭───┬────────────────────────────────────────────────┬──────────╮
│ # │                      path                      │   rev    │
├───┼────────────────────────────────────────────────┼──────────┤
│ 0 │ locks->nodes->namma-dsl->inputs->shared-kernel │ b0049d7e │
│ 1 │ locks->nodes->root->inputs->shared-kernel      │ 81e4688d │
╰───┴────────────────────────────────────────────────┴──────────╯

```
### single-instance
```sh
nix run github:shivaraj-bh/search-flake-inputs -- -f github:nammayatri/nammayatri -i hedis
```
```sh
# Output
╭───┬───────────────────────────────────────┬──────────╮
│ # │                 path                  │   rev    │
├───┼───────────────────────────────────────┼──────────┤
│ 0 │ locks->nodes->euler-hs->inputs->hedis │ 92a3d5ab │
╰───┴───────────────────────────────────────┴──────────╯

```
### JSON output
```sh
nix run github:shivaraj-bh/search-flake-inputs -- -f github:nammayatri/nammayatri -i hedis --json
```
```sh
# Output
[
  {
    "path": "locks->nodes->euler-hs->inputs->hedis",
    "rev": "92a3d5ab"
  }
]
```
## Development
```sh
nix run nixpkgs#watchexec -- -e nix -e nu nix run . -- -f <flake-url> -i <flake-input>
```


