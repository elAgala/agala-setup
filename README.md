## Installation

```bash
tmpdir="$(mktemp -d)" && trap 'rm -rf "$tmpdir"' EXIT && curl -fL https://github.com/elAgala/agala-setup/archive/refs/heads/master.tar.gz | tar -xz -C "$tmpdir" && bash "$tmpdir/agala-setup-master/src/setup.sh"
```
