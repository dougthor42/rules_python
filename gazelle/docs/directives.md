# Directives

You can configure the extension using directives, just like for other
languages. These are just comments in the `BUILD.bazel` file which
govern behavior of the extension when processing files under that
folder.

See https://github.com/bazelbuild/bazel-gazelle#directives
for some general directives that may be useful.
In particular, the `resolve` directive is language-specific
and can be used with Python.
Examples of these directives in use can be found in the
/gazelle/testdata folder in the rules_python repo.

Python-specific directives are as follows:

| **Directive**                                                                                                                                                                                                                                                                                   | **Default value** |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------|
| `# gazelle:python_extension`                                                                                                                                                                                                                                                                    |   `enabled`       |
| Controls whether the Python extension is enabled or not. Sub-packages inherit this value. Can be either "enabled" or "disabled".                                                                                                                                                                | |
| [`# gazelle:python_root`](#directive-python_root)                                                                                                                                                                                                                                               |    n/a            |
| Sets a Bazel package as a Python root. This is used on monorepos with multiple Python projects that don't share the top-level of the workspace as the root. See [Directive: `python_root`](#directive-python_root) below.                                                                       | |
| `# gazelle:python_manifest_file_name`                                                                                                                                                                                                                                                           | `gazelle_python.yaml` |
| Overrides the default manifest file name.                                                                                                                                                                                                                                                       | |
| `# gazelle:python_ignore_files`                                                                                                                                                                                                                                                                 |     n/a           |
| Controls the files which are ignored from the generated targets.                                                                                                                                                                                                                                | |
| `# gazelle:python_ignore_dependencies`                                                                                                                                                                                                                                                          |    n/a           |
| Controls the ignored dependencies from the generated targets.                                                                                                                                                                                                                                   | |
| `# gazelle:python_validate_import_statements`                                                                                                                                                                                                                                                   | `true` |
| Controls whether the Python import statements should be validated. Can be "true" or "false"                                                                                                                                                                                                     | |
| `# gazelle:python_generation_mode`                                                                                                                                                                                                                                                              | `package` |
| Controls the target generation mode. Can be "file", "package", or "project"                                                                                                                                                                                                                     | |
| `# gazelle:python_generation_mode_per_file_include_init`                                                                                                                                                                                                                                        | `false` |
| Controls whether `__init__.py` files are included as srcs in each generated target when target generation mode is "file". Can be "true", or "false"                                                                                                                                             | |
| [`# gazelle:python_generation_mode_per_package_require_test_entry_point`](#directive-python_generation_mode_per_package_require_test_entry_point)                                                                                                                                               | `true` |
| Controls whether a file called `__test__.py` or a target called `__test__` is required to generate one test target per package in package mode.                                                                                                                                                 ||
| `# gazelle:python_library_naming_convention`                                                                                                                                                                                                                                                    | `$package_name$` |
| Controls the `py_library` naming convention. It interpolates `$package_name$` with the Bazel package name. E.g. if the Bazel package name is `foo`, setting this to `$package_name$_my_lib` would result in a generated target named `foo_my_lib`.                                              | |
| `# gazelle:python_binary_naming_convention`                                                                                                                                                                                                                                                     | `$package_name$_bin` |
| Controls the `py_binary` naming convention. Follows the same interpolation rules as `python_library_naming_convention`.                                                                                                                                                                         | |
| `# gazelle:python_test_naming_convention`                                                                                                                                                                                                                                                       | `$package_name$_test` |
| Controls the `py_test` naming convention. Follows the same interpolation rules as `python_library_naming_convention`.                                                                                                                                                                           | |
| `# gazelle:resolve py ...`                                                                                                                                                                                                                                                                      | n/a |
| Instructs the plugin what target to add as a dependency to satisfy a given import statement. The syntax is `# gazelle:resolve py import-string label` where `import-string` is the symbol in the python `import` statement, and `label` is the Bazel label that Gazelle should write in `deps`. | |
| [`# gazelle:python_default_visibility labels`](#directive-python_default_visibility)                                                                                                                                                                                                            | |
| Instructs gazelle to use these visibility labels on all python targets. `labels` is a comma-separated list of labels (without spaces).                                                                                                                                                          | `//$python_root$:__subpackages__` |
| [`# gazelle:python_visibility label`](#directive-python_visibility)                                                                                                                                                                                                                             | |
| Appends additional visibility labels to each generated target. This directive can be set multiple times.                                                                                                                                                                                        | |
| [`# gazelle:python_test_file_pattern`](#directive-python_test_file_pattern)                                                                                                                                                                                                                     | `*_test.py,test_*.py` |
| Filenames matching these comma-separated `glob`s will be mapped to `py_test` targets.                                                                                                                                                                                                           |
| `# gazelle:python_label_convention`                                                                                                                                                                                                                                                             | `$distribution_name$` |
| Defines the format of the distribution name in labels to third-party deps. Useful for using Gazelle plugin with other rules with different repository conventions (e.g. `rules_pycross`). Full label is always prepended with (pip) repository name, e.g. `@pip//numpy`.                        |
| `# gazelle:python_label_normalization`                                                                                                                                                                                                                                                          | `snake_case` |
| Controls how distribution names in labels to third-party deps are normalized. Useful for using Gazelle plugin with other rules with different label conventions (e.g. `rules_pycross` uses PEP-503). Can be "snake_case", "none", or "pep503".                                                  |
| `# gazelle:experimental_allow_relative_imports`          | `false` |
| Controls whether Gazelle resolves dependencies for import statements that use paths relative to the current package. Can be "true" or "false".|
| `# gazelle:python_generate_pyi_deps`                                                                                                                                                                                                                                                            | `false` |
| Controls whether to generate a separate `pyi_deps` attribute for type-checking dependencies or merge them into the regular `deps` attribute. When `false` (default), type-checking dependencies are merged into `deps` for backward compatibility. When `true`, generates separate `pyi_deps`. Imports in blocks with the format `if typing.TYPE_CHECKING:`/`if TYPE_CHECKING:` and type-only stub packages (eg. boto3-stubs) are recognized as type-checking dependencies. |

#### Directive: `python_root`:

Set this directive within the Bazel package that you want to use as the Python root.
For example, if using a `src` dir (as recommended by the [Python Packaging User
Guide][python-packaging-user-guide]), then set this directive in `src/BUILD.bazel`:

```starlark
# ./src/BUILD.bazel
# Tell gazelle that are python root is the same dir as this Bazel package.
# gazelle:python_root
```

Note that the directive does not have any arguments.

Gazelle will then add the necessary `imports` attribute to all targets that it
generates:

```starlark
# in ./src/foo/BUILD.bazel
py_libary(
    ...
    imports = [".."],  # Gazelle adds this
    ...
)

# in ./src/foo/bar/BUILD.bazel
py_libary(
    ...
    imports = ["../.."],  # Gazelle adds this
    ...
)
```

[python-packaging-user-guide]: https://github.com/pypa/packaging.python.org/blob/4c86169a/source/tutorials/packaging-projects.rst


#### Directive: `python_default_visibility`:

Instructs gazelle to use these visibility labels on all _python_ targets
(typically `py_*`, but can be modified via the `map_kind` directive). The arg
to this directive is a a comma-separated list (without spaces) of labels.

For example:

```starlark
# gazelle:python_default_visibility //:__subpackages__,//tests:__subpackages__
```

produces the following visibility attribute:

```starlark
py_library(
    ...,
    visibility = [
        "//:__subpackages__",
        "//tests:__subpackages__",
    ],
    ...,
)
```

You can also inject the `python_root` value by using the exact string
`$python_root$`. All instances of this string will be replaced by the `python_root`
value.

```starlark
# gazelle:python_default_visibility //$python_root$:__pkg__,//foo/$python_root$/tests:__subpackages__

# Assuming the "# gazelle:python_root" directive is set in ./py/src/BUILD.bazel,
# the results will be:
py_library(
    ...,
    visibility = [
        "//foo/py/src/tests:__subpackages__",  # sorted alphabetically
        "//py/src:__pkg__",
    ],
    ...,
)
```

Two special values are also accepted as an argument to the directive:

+   `NONE`: This removes all default visibility. Labels added by the
    `python_visibility` directive are still included.
+   `DEFAULT`: This resets the default visibility.

For example:

```starlark
# gazelle:python_default_visibility NONE

py_library(
    name = "...",
    srcs = [...],
)
```

```starlark
# gazelle:python_default_visibility //foo:bar
# gazelle:python_default_visibility DEFAULT

py_library(
    ...,
    visibility = ["//:__subpackages__"],
    ...,
)
```

These special values can be useful for sub-packages.


#### Directive: `python_visibility`:

Appends additional `visibility` labels to each generated target.

This directive can be set multiple times. The generated `visibility` attribute
will include the default visibility and all labels defined by this directive.
All labels will be ordered alphabetically.

```starlark
# ./BUILD.bazel
# gazelle:python_visibility //tests:__pkg__
# gazelle:python_visibility //bar:baz

py_library(
   ...
   visibility = [
       "//:__subpackages__",  # default visibility
       "//bar:baz",
       "//tests:__pkg__",
   ],
   ...
)
```

Child Bazel packages inherit values from parents:

```starlark
# ./bar/BUILD.bazel
# gazelle:python_visibility //tests:__subpackages__

py_library(
   ...
   visibility = [
       "//:__subpackages__",       # default visibility
       "//bar:baz",                # defined in ../BUILD.bazel
       "//tests:__pkg__",          # defined in ../BUILD.bazel
       "//tests:__subpackages__",  # defined in this ./BUILD.bazel
   ],
   ...
)

```

This directive also supports the `$python_root$` placeholder that
`# gazelle:python_default_visibility` supports.

```starlark
# gazlle:python_visibility //$python_root$/foo:bar

py_library(
    ...
    visibility = ["//this_is_my_python_root/foo:bar"],
    ...
)
```


#### Directive: `python_test_file_pattern`:

This directive adjusts which python files will be mapped to the `py_test` rule.

+ The default is `*_test.py,test_*.py`: both `test_*.py` and `*_test.py` files
  will generate `py_test` targets.
+ This directive must have a value. If no value is given, an error will be raised.
+ It is recommended, though not necessary, to include the `.py` extension in
  the `glob`s: `foo*.py,?at.py`.
+ Like most directives, it applies to the current Bazel package and all subpackages
  until the directive is set again.
+ This directive accepts multiple `glob` patterns, separated by commas without spaces:

```starlark
# gazelle:python_test_file_pattern foo*.py,?at

py_library(
    name = "mylib",
    srcs = ["mylib.py"],
)

py_test(
    name = "foo_bar",
    srcs = ["foo_bar.py"],
)

py_test(
    name = "cat",
    srcs = ["cat.py"],
)

py_test(
    name = "hat",
    srcs = ["hat.py"],
)
```


##### Notes

Resetting to the default value (such as in a subpackage) is manual. Set:

```starlark
# gazelle:python_test_file_pattern *_test.py,test_*.py
```

There currently is no way to tell gazelle that _no_ files in a package should
be mapped to `py_test` targets (see [Issue #1826][issue-1826]). The workaround
is to set this directive to a pattern that will never match a `.py` file, such
as `foo.bar`:

```starlark
# No files in this package should be mapped to py_test targets.
# gazelle:python_test_file_pattern foo.bar

py_library(
    name = "my_test",
    srcs = ["my_test.py"],
)
```

[issue-1826]: https://github.com/bazel-contrib/rules_python/issues/1826

#### Directive: `python_generation_mode_per_package_require_test_entry_point`:

When `# gazelle:python_generation_mode package`, whether a file called
`__test__.py` or a target called `__test__`, a.k.a., entry point, is required
to generate one test target per package. If this is set to true but no entry
point is found, Gazelle will fall back to file mode and generate one test target
per file. Setting this directive to false forces Gazelle to generate one test
target per package even without entry point. However, this means the `main`
attribute of the `py_test` will not be set and the target will not be runnable
unless either:

1.  there happen to be a file in the `srcs` with the same name as the `py_test`
    target, or
2.  a macro populating the `main` attribute of `py_test` is configured with
    `gazelle:map_kind` to replace `py_test` when Gazelle is generating Python
    test targets. For example, user can provide such a macro to Gazelle:

```starlark
load("@rules_python//python:defs.bzl", _py_test="py_test")
load("@aspect_rules_py//py:defs.bzl", "py_pytest_main")

def py_test(name, main=None, **kwargs):
    deps = kwargs.pop("deps", [])
    if not main:
        py_pytest_main(
            name = "__test__",
            deps = ["@pip_pytest//:pkg"],  # change this to the pytest target in your repo.
        )

        deps.append(":__test__")
        main = ":__test__.py"

    _py_test(
        name = name,
        main = main,
        deps = deps,
        **kwargs,
)
```


#### Directive: `experimental_allow_relative_imports`

Enables experimental support for resolving relative imports in
`python_generation_mode package`.

By default, when `# gazelle:python_generation_mode package` is enabled,
relative imports (e.g., from .library import foo) are not added to the
deps field of the generated target. This results in incomplete py_library
rules that lack required dependencies on sibling packages.

Example:
Given this Python file import:
```python
from .library import add as _add
from .library import subtract as _subtract
```

Expected BUILD file output:
```starlark
py_library(
    name = "py_default_library",
    srcs = ["__init__.py"],
    deps = [
        "//example/library:py_default_library",
    ],
    visibility = ["//visibility:public"],
)
```

Actual output without this annotation:
```starlark
py_library(
    name = "py_default_library",
    srcs = ["__init__.py"],
    visibility = ["//visibility:public"],
)
```
If the directive is set to `true`, gazelle will resolve imports
that are relative to the current package.
