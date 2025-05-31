load("@bazel_skylib//:bzl_library.bzl", "bzl_library")

bzl_library(
    name = "awk",
    srcs = ["awk.bzl"],
    visibility = ["//awk:__subpackages__"],
    deps = [
        "//awk/private:awk.bzl",
        "@bazel_skylib//lib:partial",
        "@bazel_skylib//rules:write_file",
    ],
)
