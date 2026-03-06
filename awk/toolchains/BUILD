load("//awk/private:toolchain.bzl", "awk_toolchain")

toolchain_type(
    name = "toolchain_type",
    visibility = ["//visibility:public"],
)

awk_toolchain(
    name = "gawk_toolchain_impl",
    awk = "@gawk",
    visibility = ["//visibility:public"],
)

toolchain(
    name = "gawk",
    toolchain = ":gawk_toolchain_impl",
    toolchain_type = "//awk/toolchains:toolchain_type",
    visibility = ["//visibility:public"],
)
