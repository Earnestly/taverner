Taverner
========
.. image:: https://raw.github.com/Earnestly/taverner/master/screenshot.png

Taverner is a small collection of shell scripts *(read: 3)* designed to
generate and maintain a bunch of game launchers (or anything else really).  
It uses a modified dmenu_ to create a list of items along with a nice cover
image and an accompanying tool to make creating these entries a bit more easily.

Requires
--------
* bash 4.2+
* imagemagick
* dmenu-pango-imlib_

Install
-------
.. code-block:: sh

    # Create necessary directories
    mkdir -p "$HOME"/games/{bin,share/{covers,cache,templates}}

    # Move the needed library to the correct location
    mv libtavern "$HOME"/.local/lib/libtavern

    # Move taverner and barkeep to somewhere in your PATH
    mv taverner barkeep "$HOME"/.local/bin

    # Add "$HOME"/games/bin to you path, I've appended it here rather than suffixed
    PATH="$PATH":"$HOME"/games/bin

What *&* How
------------
Briefly, a typical session may look like this::

    % barkeep -h
    Usage: barkeep -n <name> -t <template> [-c <cover>] [-e <editor>] [-l]
           barkeep -r [name [name [...]]]

        Operations:
            -l      List all available templates
            -n      Name of the new game launcher script
            -t      Select a template to base the new entry on
            -c      Path or url to a cover image (note: this is destructive)
            -e      Prefered editor, uses $EDITOR if not set

        Single Operations:
            -r      Remove launcher(s), cover(s) and reset database
                    If no argument given, attempt to remove all launchers

        Examples:
            # Creates an entry using the psx template called wipeout_3 using emacs
            # as the editor
            barkeep -e emacs -n wipeout_3 -t psx -c ~/wipeout.png
            
            # Removes both wipeout_3 and crash_bandicoot launchers along with any
            # cover images if found and resets the cache
            barkeep -r wipeout_3 crash_bandicoot

::

    % barkeep -l
        psx
        snes
        psp
        pc

::

    % barkeep -n wipeout_pulse -t psp -c ~/some_cover_you_downloaded.png
    ‘/home/earnest/games/share/templates/psp’ -> ‘/home/earnest/games/bin/wipeout_pulse’
    mode of ‘/home/earnest/games/bin/wipeout_pulse’ changed from 0644 (rw-r--r--) to 0755 (rwxr-xr-x)
    ‘/home/earnest/dev/shell/taverner/some_cover_you_downloaded.png’ -> ‘/home/earnest/games/share/covers/wipeout_pulse.cover’

At this point you'll get prompted with your ``$EDITOR`` to make any changes to
the template such as specifying what to execute, and where the data files are
located, an example might look like

.. code-block:: sh

    #!/bin/bash
    # Title: "title" (PSP "year")

    executable=""
    prefix=""

    exec ppsspp --fullscreen "$prefix"/"$executable"

Here the title is read and passed to dmenu, if ``# Title:`` isn't present,
``taverner`` will fallback on the script's filename.

After editing the template all that remains is to run ``taverner``.

Now for a bit more detail
~~~~~~~~~~~~~~~~~~~~~~~~~
``taverner`` expects a certain hierarchical directory structure which closely
mimics what we're used to on \*nix.  If you want to alter this, simply change
the prefix in both ``taverner`` and ``barkeep``
    
.. code-block:: sh

    prefix="$HOME"/games → prefix="$HOME"/.local/taverner

The structure itself by default uses the following with the prefix set to
``"$HOME"/games``::

    prefix
    ├── bin
    ├── data (optional*)
    └── share
        ├── cache
        ├── covers
        └── templates

..

    I use this ``data`` directory to dump all the games and game data, but there
    is no requirement on it and its not used by ``taverner``.

Each of the paths can also be altered via additional variables as desired too:

.. code-block:: sh

    # Alter in both taverner and barkeep scripts
    bindir="$prefix"/bin
    cachedir="$prefix"/share/cache
    coverdir="$prefix"/share/covers
    templatedir="$prefix"/share/templates

Consequently, the "library" I use, ``libtavern`` which simply contains a bunch
of useful functions, can also have the path changed and may be necessary to
suit your own environment.  I personally use ``$HOME/.local/lib`` for mine as it
reflects ``/usr/local``.

Make sure you set the desired location for both ``taverner`` and ``barkeep``

.. code-block:: sh

    source "$HOME"/.local/lib/libtavern

Why
---
I wanted to turn an old machine into a game box that could play various emulated
games on the SNES, PSX, PSP and some older ones via WINE while unifying the UI.
Many existing solutions were quite sophisticated, beautiful and complex
graphical frontends, usually existing to serve a specific set of emulators.

Since the machine I was planning to use is quite limited in terms of hardware I
wanted something simple (and not very clever) which did as little as possible
and with enough flexibility for anything I might conceivably throw at it.

As Cloudef_ has been working on providing extra functionality for dmenu which
allows me to embed images based on the entry selected, I decided that would be
perfect to list a bunch of games including any cover art.

Initially I simply wrote a few lines of shell that passed a handwritten list to
dmenu which launched a second script that contained all the logic necessary for
starting the program.  Eventually this manual insertion and deletion of list
entries became inconvenient which resulted in the creation of a cache-based
system, a rather dumb one, that simply uses a file structure and some metadata
in the scripts to dynamically build my list only when a new launcher is added
or removed.

Now that was reasonably well solved, I still had the issue of manually writing
the launcher scripts and setting up the cover image along with other potential
tweaks.  This is where ``barkeep`` comes in, it exists simply to aid me in
creating the launchers, copying over templates and letting me just add any
necessary tweaks.

I would like to more fully develop this using the ``m4`` macro language one day
and use a proper caching system which can detect metadata changes without
incurring the cost of reading said metadata in the first place.

.. _dmenu: https://github.com/Cloudef/dmenu-pango-imlib
.. _dmenu-pango-imlib: https://github.com/Earnestly/pkgbuilds/blob/master/dmenu-pango-imlib-git/PKGBUILD
.. _Cloudef: https://github.com/Cloudef
