# Copyright 2023 The Bazel Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

_RULE_DEPS = [
    # START: maintained by 'bazel run //tools/private/update_deps:update_pip_deps'
    (
        "pypi__build",
        "https://files.pythonhosted.org/packages/58/91/17b00d5fac63d3dca605f1b8269ba3c65e98059e1fd99d00283e42a454f0/build-0.10.0-py3-none-any.whl",
        "af266720050a66c893a6096a2f410989eeac74ff9a68ba194b3f6473e8e26171",
    ),
    (
        "pypi__click",
        "https://files.pythonhosted.org/packages/00/2e/d53fa4befbf2cfa713304affc7ca780ce4fc1fd8710527771b58311a3229/click-8.1.7-py3-none-any.whl",
        "ae74fb96c20a0277a1d615f1e4d73c8414f5a98db8b799a7931d1582f3390c28",
    ),
    (
        "pypi__colorama",
        "https://files.pythonhosted.org/packages/d1/d6/3965ed04c63042e047cb6a3e6ed1a63a35087b6a609aa3a15ed8ac56c221/colorama-0.4.6-py2.py3-none-any.whl",
        "4f1d9991f5acc0ca119f9d443620b77f9d6b33703e51011c16baf57afb285fc6",
    ),
    (
        "pypi__importlib_metadata",
        "https://files.pythonhosted.org/packages/cc/37/db7ba97e676af155f5fcb1a35466f446eadc9104e25b83366e8088c9c926/importlib_metadata-6.8.0-py3-none-any.whl",
        "3ebb78df84a805d7698245025b975d9d67053cd94c79245ba4b3eb694abe68bb",
    ),
    (
        "pypi__installer",
        "https://files.pythonhosted.org/packages/e5/ca/1172b6638d52f2d6caa2dd262ec4c811ba59eee96d54a7701930726bce18/installer-0.7.0-py3-none-any.whl",
        "05d1933f0a5ba7d8d6296bb6d5018e7c94fa473ceb10cf198a92ccea19c27b53",
    ),
    (
        "pypi__more_itertools",
        "https://files.pythonhosted.org/packages/5a/cb/6dce742ea14e47d6f565589e859ad225f2a5de576d7696e0623b784e226b/more_itertools-10.1.0-py3-none-any.whl",
        "64e0735fcfdc6f3464ea133afe8ea4483b1c5fe3a3d69852e6503b43a0b222e6",
    ),
    (
        "pypi__packaging",
        "https://files.pythonhosted.org/packages/ab/c3/57f0601a2d4fe15de7a553c00adbc901425661bf048f2a22dfc500caf121/packaging-23.1-py3-none-any.whl",
        "994793af429502c4ea2ebf6bf664629d07c1a9fe974af92966e4b8d2df7edc61",
    ),
    (
        "pypi__pep517",
        "https://files.pythonhosted.org/packages/ee/2f/ef63e64e9429111e73d3d6cbee80591672d16f2725e648ebc52096f3d323/pep517-0.13.0-py3-none-any.whl",
        "4ba4446d80aed5b5eac6509ade100bff3e7943a8489de249654a5ae9b33ee35b",
    ),
    (
        "pypi__pip",
        "https://files.pythonhosted.org/packages/50/c2/e06851e8cc28dcad7c155f4753da8833ac06a5c704c109313b8d5a62968a/pip-23.2.1-py3-none-any.whl",
        "7ccf472345f20d35bdc9d1841ff5f313260c2c33fe417f48c30ac46cccabf5be",
    ),
    (
        "pypi__pip_tools",
        "https://files.pythonhosted.org/packages/e8/df/47e6267c6b5cdae867adbdd84b437393e6202ce4322de0a5e0b92960e1d6/pip_tools-7.3.0-py3-none-any.whl",
        "8717693288720a8c6ebd07149c93ab0be1fced0b5191df9e9decd3263e20d85e",
    ),
    (
        "pypi__pyproject_hooks",
        "https://files.pythonhosted.org/packages/d5/ea/9ae603de7fbb3df820b23a70f6aff92bf8c7770043254ad8d2dc9d6bcba4/pyproject_hooks-1.0.0-py3-none-any.whl",
        "283c11acd6b928d2f6a7c73fa0d01cb2bdc5f07c57a2eeb6e83d5e56b97976f8",
    ),
    (
        "pypi__setuptools",
        "https://files.pythonhosted.org/packages/4f/ab/0bcfebdfc3bfa8554b2b2c97a555569c4c1ebc74ea288741ea8326c51906/setuptools-68.1.2-py3-none-any.whl",
        "3d8083eed2d13afc9426f227b24fd1659489ec107c0e86cec2ffdde5c92e790b",
    ),
    (
        "pypi__tomli",
        "https://files.pythonhosted.org/packages/97/75/10a9ebee3fd790d20926a90a2547f0bf78f371b2f13aa822c759680ca7b9/tomli-2.0.1-py3-none-any.whl",
        "939de3e7a6161af0c887ef91b7d41a53e7c5a1ca976325f429cb46ea9bc30ecc",
    ),
    (
        "pypi__wheel",
        "https://files.pythonhosted.org/packages/b8/8b/31273bf66016be6ad22bb7345c37ff350276cfd46e389a0c2ac5da9d9073/wheel-0.41.2-py3-none-any.whl",
        "75909db2664838d015e3d9139004ee16711748a52c8f336b52882266540215d8",
    ),
    (
        "pypi__zipp",
        "https://files.pythonhosted.org/packages/8c/08/d3006317aefe25ea79d3b76c9650afabaf6d63d1c8443b236e7405447503/zipp-3.16.2-py3-none-any.whl",
        "679e51dd4403591b2d6838a48de3d283f3d188412a9782faadf845f298736ba0",
    ),
    # END: maintained by 'bazel run //tools/private/update_deps:update_pip_deps'
    # START: Patched
    # Requirements of `keyring`
    (
        "pypi__SecretStorage",
        "https://files.pythonhosted.org/packages/54/24/b4293291fa1dd830f353d2cb163295742fa87f179fcc8a20a306a81978b7/SecretStorage-3.3.3-py3-none-any.whl",
        "f356e6628222568e3af06f2eba8df495efa13b3b63081dafd4f7d9a7b7bc9f99",
    ),
    (
        "pypi__cffi",
        "https://files.pythonhosted.org/packages/9b/89/a31c81e36bbb793581d8bba4406a8aac4ba84b2559301c44eef81f4cf5df/cffi-1.16.0-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl",
        "7b78010e7b97fef4bee1e896df8a4bbb6712b7f05b7ef630f9d1da00f6444d2e",
    ),
    (
        "pypi__cryptography",
        "https://files.pythonhosted.org/packages/48/c8/c0962598c43d3cff2c9d6ac66d0c612bdfb1975be8d87b8889960cf8c81d/cryptography-42.0.5-cp39-abi3-manylinux_2_28_x86_64.whl",
        "cd2030f6650c089aeb304cf093f3244d34745ce0cfcc39f20c6fbfe030102e2a",
    ),
    (
        "pypi__jaraco_classes",
        "https://files.pythonhosted.org/packages/eb/57/d3590a153d7c1970f466f69fa2570e1a93a34d8f88f23c11411df73729bf/jaraco.classes-3.3.1-py3-none-any.whl",
        "86b534de565381f6b3c1c830d13f931d7be1a75f0081c57dff615578676e2206",
    ),
    (
        "pypi__jeepney",
        "https://files.pythonhosted.org/packages/ae/72/2a1e2290f1ab1e06f71f3d0f1646c9e4634e70e1d37491535e19266e8dc9/jeepney-0.8.0-py3-none-any.whl",
        "c0a454ad016ca575060802ee4d590dd912e35c122fa04e70306de3d076cce755",
    ),
    (
        "pypi__keyring",
        "https://files.pythonhosted.org/packages/7c/23/d557507915181687e4a613e1c8a01583fd6d7cb7590e1f039e357fe3b304/keyring-24.3.1-py3-none-any.whl",
        "df38a4d7419a6a60fea5cef1e45a948a3e8430dd12ad88b0f423c5c143906218",
    ),
    (
        "pypi__pycparser",
        "https://files.pythonhosted.org/packages/62/d5/5f610ebe421e85889f2e55e33b7f9a6795bd982198517d912eb1c76e1a53/pycparser-2.21-py2.py3-none-any.whl",
        "8ee45429555515e1f6b185e78100aea234072576aa43ab53aefcae078162fca9",
    ),
    # Requirements of `keyrings.google-artifactregistry-auth
    (
        "pypi__cachetools",
        "https://files.pythonhosted.org/packages/fb/2b/a64c2d25a37aeb921fddb929111413049fc5f8b9a4c1aefaffaafe768d54/cachetools-5.3.3-py3-none-any.whl",
        "0abad1021d3f8325b2fc1d2e9c8b9c9d57b04c3932657a72465447332c24d945",
    ),
    (
        "pypi__certifi",
        "https://files.pythonhosted.org/packages/ba/06/a07f096c664aeb9f01624f858c3add0a4e913d6c96257acb4fce61e7de14/certifi-2024.2.2-py3-none-any.whl",
        "dc383c07b76109f368f6106eee2b593b04a011ea4d55f652c6ca24a754d1cdd1",
    ),
    (
        "pypi__charset_normalizer",
        "https://files.pythonhosted.org/packages/40/26/f35951c45070edc957ba40a5b1db3cf60a9dbb1b350c2d5bef03e01e61de/charset_normalizer-3.3.2-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl",
        "753f10e867343b4511128c6ed8c82f7bec3bd026875576dfd88483c5c73b2fd8",
    ),
    (
        "pypi__google_auth",
        "https://files.pythonhosted.org/packages/92/94/35ba55b5011185ea1c995938e7851b25e6092f15658afa9263cd65a67dd4/google_auth-2.28.2-py2.py3-none-any.whl",
        "9fd67bbcd40f16d9d42f950228e9cf02a2ded4ae49198b27432d0cded5a74c38",
    ),
    (
        "pypi__idna",
        "https://files.pythonhosted.org/packages/c2/e7/a82b05cf63a603df6e68d59ae6a68bf5064484a0718ea5033660af4b54a9/idna-3.6-py3-none-any.whl",
        "c05567e9c24a6b9faaa835c4821bad0590fbb9d5779e7caa6e1cc4978e7eb24f",
    ),
    (
        "pypi__keyrings_google_artifactregistry_auth",
        "https://files.pythonhosted.org/packages/dc/a0/9698d906772b8c445f502e30c9408314998b29a0ee9fb22d849433a8146b/keyrings.google_artifactregistry_auth-1.1.2-py3-none-any.whl",
        "e3f18b50fa945c786593014dc225810d191671d4f5f8e12d9259e39bad3605a3",
    ),
    (
        "pypi__pluggy",
        "https://files.pythonhosted.org/packages/a5/5b/0cc789b59e8cc1bf288b38111d002d8c5917123194d45b29dcdac64723cc/pluggy-1.4.0-py3-none-any.whl",
        "7db9f7b503d67d1c5b95f59773ebb58a8c1c288129a88665838012cfb07b8981",
    ),
    (
        "pypi__pyasn1",
        "https://files.pythonhosted.org/packages/d1/75/4686d2872bf2fc0b37917cbc8bbf0dd3a5cdb0990799be1b9cbf1e1eb733/pyasn1-0.5.1-py2.py3-none-any.whl",
        "4439847c58d40b1d0a573d07e3856e95333f1976294494c325775aeca506eb58",
    ),
    (
        "pypi__pyasn1_modules",
        "https://files.pythonhosted.org/packages/cd/8e/bea464350e1b8c6ed0da3a312659cb648804a08af6cacc6435867f74f8bd/pyasn1_modules-0.3.0-py2.py3-none-any.whl",
        "d3ccd6ed470d9ffbc716be08bd90efbd44d0734bc9303818f7336070984a162d",
    ),
    (
        "pypi__requests",
        "https://files.pythonhosted.org/packages/70/8e/0e2d847013cb52cd35b38c009bb167a1a26b2ce6cd6965bf26b47bc0bf44/requests-2.31.0-py3-none-any.whl",
        "58cd2187c01e70e6e26505bca751777aa9f2ee0b7f4300988b709f44e013003f",
    ),
    (
        "pypi__rsa",
        "https://files.pythonhosted.org/packages/49/97/fa78e3d2f65c02c8e1268b9aba606569fe97f6c8f7c2d74394553347c145/rsa-4.9-py3-none-any.whl",
        "90260d9058e514786967344d0ef75fa8727eed8a7d2e43ce9f4bcf1b536174f7",
    ),
    (
        "pypi__urllib3",
        "https://files.pythonhosted.org/packages/a2/73/a68704750a7679d0b6d3ad7aa8d4da8e14e151ae82e6fee774e6e0d05ec8/urllib3-2.2.1-py3-none-any.whl",
        "450b20ec296a467077128bff42b73080516e71b56ff59a60a02bef2232c4fa9d",
    ),
    # END: Patched
]

_GENERIC_WHEEL = """\
package(default_visibility = ["//visibility:public"])

load("@rules_python//python:defs.bzl", "py_library")

py_library(
    name = "lib",
    srcs = glob(["**/*.py"]),
    data = glob(["**/*"], exclude=[
        # These entries include those put into user-installed dependencies by
        # data_exclude in /python/pip_install/tools/bazel.py
        # to avoid non-determinism following pip install's behavior.
        "**/*.py",
        "**/*.pyc",
        "**/*.pyc.*",  # During pyc creation, temp files named *.pyc.NNN are created
        "**/* *",
        "**/*.dist-info/RECORD",
        "BUILD",
        "WORKSPACE",
    ]),
    # This makes this directory a top-level in the python import
    # search path for anything that depends on this.
    imports = ["."],
)
"""

# Collate all the repository names so they can be easily consumed
all_requirements = [name for (name, _, _) in _RULE_DEPS]

def requirement(pkg):
    return Label("@pypi__" + pkg + "//:lib")

def pip_install_dependencies():
    """
    Fetch dependencies these rules depend on. Workspaces that use the pip_parse rule can call this.
    """
    print("Doug was here")
    for (name, url, sha256) in _RULE_DEPS:
        maybe(
            http_archive,
            name,
            url = url,
            sha256 = sha256,
            type = "zip",
            build_file_content = _GENERIC_WHEEL,
        )
