load("@bazel_lib//:bzl_library.bzl", "bzl_library")

package(default_visibility = ["//awk:__subpackages__"])

exports_files([
    "awk.bzl",
    "toolchain.bzl",
])

bzl_library(
    name = "awk",
    srcs = ["awk.bzl"],
)

bzl_library(
    name = "toolchain",
    srcs = ["toolchain.bzl"],
)
