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

## WORKSPACE support

Bazel 9 no longer supports WORKSPACE so I haven't bothered with it for this ruleset.

You can get a hermetic awk with this `http_archive` rule:

```
    # from https://github.com/bazelbuild/bazel-central-registry/tree/main/modules/gawk/5.3.2.bcr.1
    http_archive(
        name = "gawk",
        remote_file_urls = {
            "BUILD.bazel": ["https://raw.githubusercontent.com/bazelbuild/bazel-central-registry/refs/heads/main/modules/gawk/5.3.2.bcr.1/overlay/BUILD.bazel"],
            "MODULE.bazel": ["https://raw.githubusercontent.com/bazelbuild/bazel-central-registry/refs/heads/main/modules/gawk/5.3.2.bcr.1/MODULE.bazel"],
            "posix/config_darwin.h": ["https://raw.githubusercontent.com/bazelbuild/bazel-central-registry/refs/heads/main/modules/gawk/5.3.2.bcr.1/overlay/posix/config_darwin.h"],
            "posix/config_linux.h": ["https://raw.githubusercontent.com/bazelbuild/bazel-central-registry/refs/heads/main/modules/gawk/5.3.2.bcr.1/overlay/posix/config_linux.h"],
            "test/BUILD.bazel": ["https://raw.githubusercontent.com/bazelbuild/bazel-central-registry/refs/heads/main/modules/gawk/5.3.2.bcr.1/overlay/test/BUILD.bazel"],
        },
        remote_file_integrity = {
            "BUILD.bazel": "sha256-dt89+9IJ3UzQvoKzyXOiBoF6ok/4u4G0cb0Ja+plFy0=",
            "MODULE.bazel": "sha256-zfjL5e51DbBLeIeMljPMdugNz0QWy+mCrDqSIvgHE8g=",
            "posix/config_darwin.h": "sha256-gPVRlvtdXPw4Ikwd5S89wPPw5AaiB2HTHa1KOtj40mU=",
            "posix/config_linux.h": "sha256-iEaeXYBUCvprsIEEi5ipwqt0JV8d73+rLgoBYTegC6Q=",
            "test/BUILD.bazel": "sha256-NktOb/GQZ8AimXwLEfGFMJB3TtgAFhobM5f9aWsHwLQ=",
        },
        url = "https://ftpmirror.gnu.org/gnu/gawk/gawk-5.3.2.tar.xz",
        strip_prefix = "gawk-5.3.2",
        integrity = "sha256-+MNIZQnecFGSE4sA7ywAu73Q6Eww1cB9I/xzqdxMycw=",
    )
```
