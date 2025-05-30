"Implementation details of awk rule"
_attrs = {
    "progfile": attr.label(allow_single_file = True),
    # FIXME: awk accepts a list
    "src": attr.label(allow_single_file = True),
    "out": attr.output(mandatory = True),
    "args": attr.string_list(),
    "field_separator": attr.string(),
    "assign": attr.string_dict(),
    # FIXME: use resolved toolchain
    "_awk": attr.label(
        default = "@gawk",
        executable = True,
        cfg = "exec",
    ),
}

def _awk_impl(ctx):
    args = ctx.actions.args()
    outs = [ctx.outputs.out]
    if ctx.attr.field_separator:
        args.add_joined(["--field-separator", ctx.attr.field_separator], join_with = "=")
    for (key, value) in ctx.attr.assign.items():
        args.add_joined(["--assign", key, value], join_with = "=")
    args.add_joined(["--file", ctx.file.progfile], join_with = "=")
    args.add_all(ctx.files.src)
    ctx.actions.run_shell(
        command = "{} $@ >{}".format(ctx.executable._awk.path, ctx.outputs.out.path),
        arguments = [args],
        inputs = ctx.files.src + [ctx.file.progfile],
        outputs = outs,
        tools = [ctx.executable._awk],
    )
    return [DefaultInfo(files = depset(outs))]

awk_lib = struct(
    attrs = _attrs,
    implementation = _awk_impl,
)
