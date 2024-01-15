# toolbox.nu
# Based on: https://www.nushell.sh/cookbook/jq_v_nushell.html#appendix-custom-commands
use std assert

# Like `describe` but dropping item types for collections.
export def describe-primitive []: any -> string {
  $in | describe | str replace --regex '<.*' ''
}


# A command for cherry-picking values from a record key recursively
export def "flatten record-paths" [
    --separator (-s): string = "."    # The separator to use when chaining paths
] {
    let input = $in

    if ($input | describe) !~ "record" {
        error make {msg: "The record-paths command expects a record"}
    }

    $input | flatten-record-paths $separator
}

def flatten-record-paths [separator: string, ctx?: string] {
    let input = $in

    match ($input | describe-primitive) {
        "record" => {
            $input
            | items { |key, value|
                  let path = if $ctx == null { $key } else { [$ctx $key] | str join $separator }
                  {path: $path, value: $value}
              }
            | reduce -f [] { |row, acc|
                  $acc
                  | append ($row.value | flatten-record-paths $separator $row.path)
                  | flatten
              }
        },
        "list" => {
            $input
            | enumerate
            | each { |e|
                  {path: ([$ctx $e.index] | str join $separator), value: $e.item}
              }
        },
        "table" | "block" | "closure" => { error make {msg: "Unexpected type"} },
        _ => {
            {path: $ctx, value: $input}
        },
    }
}

#[test]
def test_record_path [] {
    assert equal ({a: 1} | flatten record-paths) [{path: "a", value: 1}]
    assert equal ({a: 1, b: [2 3]} | flatten record-paths) [[path value]; [a 1] ["b.0" 2] ["b.1" 3]]
    assert equal ({a: 1, b: {c: 2}} | flatten record-paths) [[path value]; [a 1] ["b.c" 2]]
    assert equal ({a: {b: {c: null}}} | flatten record-paths -s "->") [[path value]; ["a->b->c" null]]
}


