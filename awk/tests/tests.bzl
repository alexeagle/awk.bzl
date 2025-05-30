"Unit tests for starlark code"

load("@rules_testing//lib:analysis_test.bzl", "analysis_test", "test_suite")
load("@rules_testing//lib:util.bzl", "util")
load("//awk:awk.bzl", "awk")

def _test_hello(name):
    util.helper_target(
        awk,
        name = name + "_subject",
        src = "//awk/tests:input1.txt",
        program = "{print $2}",
    )
    analysis_test(
        name = name,
        impl = _test_hello_impl,
        target = name + "_subject",
    )

def _test_hello_impl(env, target):
    env.expect.that_target(target).default_outputs().contains(
        "awk/tests/test_hello_subject.txt",
    )

def awk_test_suite(name):
    test_suite(
        name = name,
        tests = [
            _test_hello,
        ],
    )
