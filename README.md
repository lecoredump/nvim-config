---
title: Boilerplate Neovim configuration
description: Relies heavily on Shougo’s work, among other awesome people
---

# Neovim configuration

This configuration has little chance working using Vim, prefer Neovim v0.5.0+.

## Install

The install process should be quite simple :

```console
git clone https://github.com/lecoredump/nvim-config ~/.config/nvim
nvim +PlugInstall!
```

with the following caveats :

- python\*_host_prog defauls to either
    - ~/.pyenv/neovim{2,3}/bin/python
    - first python{2,3} in path
- expects `curl` and `git` to be in PATH
- has not been tested (at all) on Darwin or Windows platforms

A dedicated python environment is recommended for Neovim, in which case, it
should be defined in `init.vim`, in the “Environment” category.

This allows you to have dedicated packages without interfering with your Python
package actual requirements.

The Python requirements are provided in `requirements.txt`, a PipFile should
follow soon.


