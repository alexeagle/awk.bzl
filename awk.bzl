"Re-export for syntax sugar load"

load("//awk:awk.bzl", _awk = "awk", _awk_toolchain = "awk_toolchain", _current_awk_toolchain = "current_awk_toolchain")

awk = _awk
awk_toolchain = _awk_toolchain
current_awk_toolchain = _current_awk_toolchain
