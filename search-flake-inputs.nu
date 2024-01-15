def get_rev [ metadata: record, node: string ] {
  $metadata
  | get locks.nodes
  | get $node
  | get locked.rev
  | str substring 0..8
}
export def path_with_rev [metadata: record, input: string ] {
  $metadata
  | flatten record-paths -s "->" # Returns a table with two columns: path and value
  | where { $in.path ends-with $input } # Filter paths ending with $input
  | update value { |row| $"(get_rev $metadata $row.value)" } # Replace node name with its rev
  | rename path rev # Rename columns
}

export def get_metadata_json [ flake: string ] {
  nix flake metadata --json $flake
  | from json
}


