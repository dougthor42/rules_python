# Remove Invalid Targets

This asserts that any target where the source files are missing gets removed.
This is more comprehensive than the `remove_invalid_binary` and
`remove_invalid_library` test cases as this one covers the
`python_generation_mode file` case.
