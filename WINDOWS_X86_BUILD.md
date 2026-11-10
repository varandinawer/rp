# Windows x86 build

This fork publishes an explicit 32-bit Windows build for environments that
cannot run a 64-bit executable. The architecture of the `rp++` executable is
independent from the architecture of the PE files it analyzes.

## Local build

Requirements:

- Visual Studio 2022 with the Desktop development with C++ workload
- CMake 3.16 or newer

From a Developer Command Prompt, run:

```bat
src\build\build-release-win32.bat
```

The resulting executable is:

```text
buildx86\Release\rp-win.exe
```

The script configures CMake with the Visual Studio 2022 generator and
`-A Win32`. The GitHub Actions release workflow also reads the PE header and
fails unless its machine type is `0x014c` (`IMAGE_FILE_MACHINE_I386`).
The workflow pins GitHub's `windows-2022` image because `windows-latest` now
uses Visual Studio 2026 and no longer provides the Visual Studio 2022 generator.
The Release configuration uses the project's static MSVC runtime setting, so
the published executable does not require a separate Visual C++ runtime DLL.

## Published artifact

Tags matching `v*-win32` trigger the Windows x86 release workflow. The workflow
publishes both:

- `rp-win-x86-<version>.exe`
- `rp-win-x86-<version>.exe.sha256`

Verify a downloaded build in PowerShell:

```powershell
Get-FileHash .\rp-win-x86-v2.1.5.exe -Algorithm SHA256
```

The checksum must match the lowercase hexadecimal value in the accompanying
`.sha256` file.

## Historical build

The previous [`v2.1.3` Windows 32-bit release](https://github.com/varandinawer/rp/releases/tag/v2.1.3)
is retained for reference. Its release notes link to the original
[upstream Win32 compilation instructions](https://github.com/0vercl0k/rp/issues/50#issuecomment-1373025834),
which likewise use Visual Studio 2022 with `-A Win32`.
The new workflow makes the target architecture explicit, checks the PE machine
type automatically, and publishes a checksum alongside the executable.
