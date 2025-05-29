"Public API for calling awk"

load("@bazel_skylib//lib:partial.bzl", "partial")
load("@bazel_skylib//rules:write_file.bzl", "write_file")
load("//awk/private:awk.bzl", _awk_lib = "awk_lib")

_awk_rule = rule(
    attrs = _awk_lib.attrs,
    implementation = _awk_lib.implementation,
    # toolchains = ["@awk.bzl//awk/toolchain:type"],
)

def awk(name, src, program = None, progfile = None, out = None, **kwargs):
    """Invoke awk

    Args:
        name: name of resulting target
        program: an AWK program
        progfile: label of a file containing the AWK program
        src: label of input file that AWK processes, or a partial function that creates such a file
        out: stdout of AWK
        **kwargs: additional named parameters to the awk rule
    """
    if src and partial.is_instance(src):
        src_target = name + ".src"
        partial.call(src, name = src_target, out = name + ".in")
        src = src_target

    if not out:
        out = name + ".txt"

    if (int(bool(program))) + int(bool(progfile)) != 1:
        fail("Exactly one of program or progfile should be set")
    if program:
        progfile = name + ".write_progfile"
        write_file(
            name = progfile,
            out = name + ".progfile",
            content = [program],
        )

    _awk_rule(name = name, src = src, out = out, progfile = progfile, **kwargs)
