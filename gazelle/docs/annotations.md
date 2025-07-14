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

* [`# gazelle:ignore imports`](#annotation-ignore)
  * Default: N/A
  * Tells Gazelle to ignore import statements. `imports` is a comma-separated list
    of imports to ignore.
* [`# gazelle:include_dep targets`](#annotation-include-dep)
  * Default: N/A
  * Tells Gazelle to include a set of dependencies, even if they are not imported in
    a Python module. `targets` is a comma-separated list of target names to
    include as dependencies.


## Annotation: `ignore`

This annotation accepts a comma-separated string of values. Values are names of Python
imports that Gazelle should _not_ include in target dependencies.

The annotation can be added multiple times, and all values are combined and
de-duplicated.

For `python_generation_mode = "package"`, the `ignore` annotations
found across all files included in the generated target are removed from `deps`.

Example:

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


## Annotation: `include_dep`

This annotation accepts a comma-separated string of values. Values _must_
be Python targets, but _no validation is done_. If a value is not a Python
target, building will result in an error saying:

```
<target> does not have mandatory providers: 'PyInfo' or 'CcInfo' or 'PyInfo'.
```

Adding non-Python targets to the generated target is a feature request being
tracked in [Issue #1865](https://github.com/bazel-contrib/rules_python/issues/1865).

The annotation can be added multiple times, and all values are combined
and de-duplicated.

For `python_generation_mode = "package"`, the `include_dep` annotations
found across all files included in the generated target are included in `deps`.

Example:

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
