# kura

Minimal C23 development environment. The `kura` command prints `Hello world.`

## Requirements

- GCC 15+ or Clang 18+
- CMake 3.21+
- Ninja
- clang-tidy and Cppcheck (static analysis only)
- Sanitizer runtime (`libclang-rt-*-dev` on Debian/Ubuntu) when using
  `KURA_ENABLE_SANITIZERS`

## Build and test

```sh
cmake --preset dev-gcc        # or: cmake --preset dev-clang
cmake --build --preset dev-gcc
ctest --preset dev-gcc
```

The development presets build with `-Wall -Wextra -Wpedantic -Werror` and
enable AddressSanitizer and UndefinedBehaviorSanitizer.

## Static analysis

```sh
cmake --preset analyze
cmake --build --preset analyze
```

This runs clang-tidy and Cppcheck as part of the build.

## Release build

```sh
cmake --preset release
cmake --build --preset release
ctest --preset release
```

## CI

GitHub Actions uses the standard `ubuntu-latest` runner:

- GCC 15 (installed from the `ubuntu-toolchain-r/test` PPA)
- Clang 18
- clang-tidy and Cppcheck

Both compiler builds run the tests with ASan and UBSan enabled.
