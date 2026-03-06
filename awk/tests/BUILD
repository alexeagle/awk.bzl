load("@bazel_skylib//rules:diff_test.bzl", "diff_test")
load("@bazel_skylib//rules:write_file.bzl", "write_file")
load(":tests.bzl", "awk_test_suite")

awk_test_suite(name = "tests")

# Test that $(AWK) is usable from a genrule via current_awk_toolchain.
write_file(
    name = "genrule_input",
    out = "genrule_input.txt",
    content = [
        "hello world",
        "foo bar",
    ],
)

genrule(
    name = "genrule_awk",
    srcs = ["genrule_input.txt"],
    outs = ["genrule_awk.txt"],
    cmd = "$(AWK) '{print $$2}' $< > $@",
    toolchains = ["//awk:current_awk_toolchain"],
)

write_file(
    name = "genrule_expected",
    out = "genrule_expected.txt",
    content = [
        "world",
        "bar",
        "",
    ],
)

diff_test(
    name = "genrule_awk_test",
    file1 = "genrule_awk.txt",
    file2 = "genrule_expected.txt",
)
