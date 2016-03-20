# vim-root

Basic syntax highlighting for the ROOT Data Analysis Framework
<http://root.cern.ch/>

Initially inspired by *Theo Christoudias'* plugin: [cern_root.vim][].

In contrast to [cern_root.vim][], this plugin is structured to work with
common Vim plugin managers. It attempts to be semantically correct,
which also allows seamless integration with both the PyROOT, as
well as the original C++ implementation.

[cern_root.vim]: http://www.vim.org/scripts/script.php?script_id=2387

## Usage

There are several methods for activating this plugin's syntax
highlighting (including shorthand commands):

+ Assuming you are using the C++ implementation:

        :setfiletype cpp.root
        :setf cpp.root

        :set filetype=cpp.root
        :se ft=cpp.root

+ Assuming you are using PyROOT:

        :setfiletype python.root
        :setf python.root

        :set filetype=python.root
        :se ft=python.root

However, the latter holds the most power, it is easier to chain the
syntax. Therefore **regardless** of whether you are using the C++
implementation or PyROOT, the following will include the syntax:

    :set filetype+=.root
    :se ft+=.root

So long as Vim had detected the use of `c`, `cpp` or `python` before,
which it almost certainly would if you have the following in your vimrc.

    filetype on
    syntax enable

## Installation

Install this plugin by *your* preferred method. A few examples are given
below.

### Vim Package Managers

You can install this using your favourite Vim package manager. If you
are not using a package manager, you may find it helpful.

There are many different package managers, and it is assumed you know
how to install the one of your choice and how to use them.

### Vundle

Place this in your `.vimrc`:

    Plugin 'parnmatt/vim-root'

Then run the following in Vim:

    :source %
    :PluginInstall

*For Vundle version < 0.10.2, replace `Plugin` with `Bundle` above.*

### NeoBundle

Place this in your `.vimrc`:

    NeoBundle 'parnmatt/vim-root'

Then run the following in Vim:

    :source %
    :NeoBundleInstall

### Pathogen

Run the following in a terminal:

    $ git clone https://github.com/parnmatt/vim-root ${VIMRUNTIME:-$HOME/.vim}/bundle/vim-root


### Manual Installation

1. Clone this repository

        $ git clone https://github.com/parnmatt/vim-root

2. Place syntax file in Vim runtime path `$VIMRUNTIME/syntax/root.vim`

        $ mkdir -p ${VIMRUNTIME:-$HOME/.vim}/syntax/
        $ mv vim-root/syntax/root.vim ${VIMRUNTIME:-$HOME/.vim}/syntax/

3. Remove repository

        $ rm -rf vim-root

The above presumes you do not wish to keep the repository. If you do,
It is suggested to either hard- or soft-link the files, rather than
move them and delete the repository. This gives the added advantage of
updating the file when new commits are pulled.

### Packages

#### Arch Linux

AUR package for the stable releases:
<https://aur.archlinux.org/packages/vim-root/>

AUR package for the `develop` branch:
<https://aur.archlinux.org/packages/vim-root-git/>

## Contributing

If you want to help improve vim-root, please refer to `CONTRIBUTING.md`.

## License

vim-root is published under the MIT license (see `LICENSE`).
