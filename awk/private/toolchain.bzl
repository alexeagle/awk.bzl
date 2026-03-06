"Toolchain definitions for awk"

AwkInfo = provider(
    doc = "Information about an awk executable",
    fields = {
        "awk": "A FilesToRunProvider for the awk binary",
    },
)

def _awk_toolchain_impl(ctx):
    return [platform_common.ToolchainInfo(
        awk_info = AwkInfo(awk = ctx.attr.awk[DefaultInfo].files_to_run),
    )]

awk_toolchain = rule(
    implementation = _awk_toolchain_impl,
    attrs = {
        "awk": attr.label(
            mandatory = True,
            executable = True,
            cfg = "exec",
        ),
    },
)

def _current_awk_toolchain_impl(ctx):
    toolchain = ctx.toolchains["//awk/toolchains:toolchain_type"]
    awk = toolchain.awk_info.awk

    default_info = DefaultInfo(
        files = depset([awk.executable]),
        runfiles = ctx.runfiles(files = [awk.executable]),
    )

    template_variable_info = platform_common.TemplateVariableInfo({
        "AWK": awk.executable.path,
    })

    return [default_info, template_variable_info]

current_awk_toolchain = rule(
    implementation = _current_awk_toolchain_impl,
    toolchains = ["//awk/toolchains:toolchain_type"],
)
