load("@aspect_bazel_lib//lib:diff_test.bzl", "diff_test")
load("@awk.bzl", "awk")
load("@bazel_skylib//lib:partial.bzl", "partial")
load("@bazel_skylib//rules:write_file.bzl", "write_file")

# Run awk on a generated source file, producing bazel-bin/long_lines.txt
awk(
    name = "long_lines",
    # Shorthand to write a generated file with some content we can run through awk.
    # Typically your content would come from a source file, or the output of some other rule.
    src = partial.make(
        write_file,
        content = [
            "a short line",
            "long" * 20,
        ],
    ),
    # Print lines longer than 72 characters.
    program = "length($0) > 72",
)

# Verify the awk output doesn't include the first line: "a short line"
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

# Verify the words were reversed.
diff_test(
    name = "opposite_order_test",
    file1 = "opposite_order.txt",
    file2 = [
        "second first",
        "",
    ],
)

# Add line numbers on each line of a file
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

# Again, verify the output
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

# Create a CSV file as a test fixture.
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

# Demonstrate the --field-separator flag to awk.
awk(
    name = "csv",
    src = "sample.csv",
    out = "changed.txt",
    field_separator = ",",
    # Discard the header line; print columns 1 and 3 of other lines
    program = "NR > 1 { print $1, $3 }",
)

# Verify the CSV data was processed.
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

# The awk program itself may be generated. Here we just generate it with static content,
# but it could be written by any rule.
write_file(
    name = "write_sumprogram",
    out = "sumprogram",
    content = [
        "# Add up the numbers found in each line, then print the result.",
        "{ sum += $1 }; END { print sum }",
    ],
)

# Run awk with the --progfile argument
awk(
    name = "sum",
    src = partial.make(
        write_file,
        content = [str(i) for i in range(1, 6)],
    ),
    progfile = "sumprogram",
)

# Verify the sum of 1+2+3+4+5
diff_test(
    name = "sum_test",
    file1 = "sum.txt",
    file2 = [
        "15",
        "",
    ],
)

# Demonstrate the --assign=target_age=25 awk flag
awk(
    name = "use_vars",
    src = "sample.csv",
    assign = {
        "target_age": "25",
    },
    field_separator = ",",
    # Reference the assigned var, printing lines where column 2 contains that value
    program = "$2 == target_age { print $1 }",
)

# Verify we get names of people whose age is 25
diff_test(
    name = "use_vars_test",
    file1 = "use_vars.txt",
    file2 = [
        "Bob",
        "",
    ],
)
