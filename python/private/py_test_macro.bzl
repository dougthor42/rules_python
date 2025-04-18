# Copyright 2022 The Bazel Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
"""Implementation of macro-half of py_test rule."""

load(":py_executable.bzl", "convert_legacy_create_init_to_int")
load(":py_test_rule.bzl", py_test_rule = "py_test")

def py_test(**kwargs):
    py_test_macro(py_test_rule, **kwargs)

def py_test_macro(py_rule, **kwargs):
    convert_legacy_create_init_to_int(kwargs)
    py_rule(**kwargs)
