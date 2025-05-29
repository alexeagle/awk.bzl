# Bazel rule for awk(1)

## Installation

Follow instructions from the release you wish to use:
<https://github.com/alexeagle/awk.bzl/releases>

## Usage

```
load("@awk.bzl", "awk")

awk(
    name = "csv",
    src = "sample.csv",
    out = "changed.txt",
    field_separator = ",",
    # Discard the header line; print columns 1 and 3 of other lines
    program = "NR > 1 { print $1, $3 }",
)
```

See many more examples in [examples](./examples/BUILD).
