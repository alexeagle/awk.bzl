load("@aspect_bazel_lib//lib:diff_test.bzl", "diff_test")
load("@awk.bzl", "awk")
load("@bazel_skylib//lib:partial.bzl", "partial")
load("@bazel_skylib//rules:write_file.bzl", "write_file")

# Print lines longer than 72 characters.
awk(
    name = "long_lines",
    src = partial.make(
        write_file,
        content = [
            "a short line",
            "long" * 20,
        ],
    ),
    program = "length($0) > 72",
)

diff_test(
    name = "long_lines_test",
    file1 = "long_lines.txt",
    file2 = [
        "long" * 20,
        "",
    ],
)

# Print first two fields in opposite order.
awk(
    name = "opposite_order",
    src = partial.make(
        write_file,
        content = ["first second"],
    ),
    program = "{ print $2, $1 }",
)

diff_test(
    name = "opposite_order_test",
    file1 = "opposite_order.txt",
    file2 = [
        "second first",
        "",
    ],
)

awk(
    name = "line_numbers",
    src = partial.make(
        write_file,
        content = [
            "first",
            "second",
            "third",
        ],
    ),
    program = "{ print NR, $0 }",
)

diff_test(
    name = "line_numbers_test",
    file1 = "line_numbers.txt",
    file2 = [
        "1 first",
        "2 second",
        "3 third",
        "",
    ],
)

write_file(
    name = "sample",
    out = "sample.csv",
    content = [
        "name,age,gender",
        "Alice,30,F",
        "Bob,25,M",
        "Charlie,30,M",
    ],
)

awk(
    name = "csv",
    src = "sample.csv",
    out = "changed.txt",
    field_separator = ",",
    program = "NR > 1 { print $1, $3 }",
)

diff_test(
    name = "csv_test",
    file1 = "changed.txt",
    file2 = [
        "Alice F",
        "Bob M",
        "Charlie M",
        "",
    ],
)

write_file(
    name = "write_sumprogram",
    out = "sumprogram",
    content = ["{ sum += $1 }; END { print sum }"],
)

awk(
    name = "sum",
    src = partial.make(
        write_file,
        content = [
            "1",
            "2",
            "3",
        ],
    ),
    progfile = "sumprogram",
)

diff_test(
    name = "sum_test",
    file1 = "sum.txt",
    file2 = [
        "6",
        "",
    ],
)

awk(
    name = "use_vars",
    src = "sample.csv",
    assign = {
        "target_age": "25",
    },
    field_separator = ",",
    program = "$2 == target_age { print $1 }",
)

diff_test(
    name = "use_vars_test",
    file1 = "use_vars.txt",
    file2 = [
        "Bob",
        "",
    ],
)
