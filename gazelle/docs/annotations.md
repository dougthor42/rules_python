# Annotations

*Annotations* refer to comments found _within Python files_ that configure how
Gazelle acts for that particular file.

Annotations have the form:

```python
# gazelle:annotation_name value
```

and can reside anywhere within a Python file where comments are valid. For example:

```python
import foo
# gazelle:annotation_name value

def bar():  # gazelle:annotation_name value
    pass
```

The annotations are:

* [{code}`# gazelle:ignore imports`](#ignore)
  * Default: {code}`N/A`
  * Allowed Values: A comma-separted string of python package names
  * Tells Gazelle to ignore import statements. {obj}`imports` is a comma-separated
    list of imports to ignore.
* [{code}`# gazelle:include_dep targets`](#include-dep)
  * Default: {code}`N/A`
  * Allowed Values: A string
  * Tells Gazelle to include a set of dependencies, even if they are not imported
    in a Python module. {code}`targets` is a comma-separated list of target names
    to include as dependencies.
* [{code}`# gazelle:include_pytest_conftest bool`](#include-pytest-conftest)
  * Default: {code}`N/A`
  * Allowed Values: {code}`true`, {code}`false`
  * Whether or not to include a sibling {code}`:conftest` target in the {code}`deps`
    of a {bzl:obj}`py_test` target. The default behaviour is to include {code}`:conftest`
    (i.e.: {code}`# gazelle:include_pytest_conftest true`).


## {code}`ignore`

This annotation accepts a comma-separated string of values. Values are names of
Python imports that Gazelle should _not_ include in target dependencies.

The annotation can be added multiple times, and all values are combined and
de-duplicated.

For {code}`python_generation_mode = "package"`, the {code}`ignore` annotations
found across all files included in the generated target are removed from
{code}`deps`.

### Example:

```python
import numpy  # a pypi package

# gazelle:ignore bar.baz.hello,foo
import bar.baz.hello
import foo

# Ignore this import because _reasons_
import baz  # gazelle:ignore baz
```

will cause Gazelle to generate:

```starlark
deps = ["@pypi//numpy"],
```


## {code}`include_dep`

This annotation accepts a comma-separated string of values. Values _must_
be Python targets, but _no validation is done_. If a value is not a Python
target, building will result in an error saying:

```
<target> does not have mandatory providers: 'PyInfo' or 'CcInfo' or 'PyInfo'.
```

Adding non-Python targets to the generated target is a feature request being
tracked in {gh-issue}`1865`.

The annotation can be added multiple times, and all values are combined
and de-duplicated.

For {code}`python_generation_mode = "package"`, the {code}`include_dep` annotations
found across all files included in the generated target are included in
{code}`deps`.

### Example:

```python
# gazelle:include_dep //foo:bar,:hello_world,//:abc
# gazelle:include_dep //:def,//foo:bar
import numpy  # a pypi package
```

will cause Gazelle to generate:

```starlark
deps = [
    ":hello_world",
    "//:abc",
    "//:def",
    "//foo:bar",
    "@pypi//numpy",
]
```


## {code}`include_pytest_conftest`

Added in {gh-pr}`3080`.

This annotation accepts any string that can be parsed by go's
[{code}`strconv.ParseBool`][ParseBool]. If an unparsable string is passed, the
annotation is ignored.

[ParseBool]: https://pkg.go.dev/strconv#ParseBool

Starting with [{code}`rules_python` 0.14.0][rules-python-0.14.0] (specifically
{gh-pr}`879`), Gazelle will include a {code}`:conftest` dependency to a
{bzl:obj}`py_test` target that is in the same directory as {code}`conftest.py`.

[rules-python-0.14.0]: https://github.com/bazel-contrib/rules_python/releases/tag/0.14.0

This annotation allows users to adjust that behavior. To disable the behavior,
set the annotation value to {code}`false`:

```
# some_file_test.py
# gazelle:include_pytest_conftest false
```

### Example:

Given a directory tree like:

```
.
├── BUILD.bazel
├── conftest.py
└── some_file_test.py
```

The default Gazelle behavior would create:

```starlark
py_library(
    name = "conftest",
    testonly = True,
    srcs = ["conftest.py"],
    visibility = ["//:__subpackages__"],
)

py_test(
    name = "some_file_test",
    srcs = ["some_file_test.py"],
    deps = [":conftest"],
)
```

When {code}`# gazelle:include_pytest_conftest false` is found in
{code}`some_file_test.py`

```python
# some_file_test.py
# gazelle:include_pytest_conftest false
```

Gazelle will generate:

```starlark
py_library(
    name = "conftest",
    testonly = True,
    srcs = ["conftest.py"],
    visibility = ["//:__subpackages__"],
)

py_test(
    name = "some_file_test",
    srcs = ["some_file_test.py"],
)
```

See {gh-issue}`3076` for more information.
