load("@aspect_bazel_lib//:bzl_library.bzl", "bzl_library")

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
