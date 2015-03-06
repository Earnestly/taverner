Taverner
========
.. image:: https://raw.github.com/Earnestly/taverner/master/screenshot.png

Taverner is a small collection of shell scripts *(read: 2)* designed to
generate and maintain a bunch of game launchers (or anything else really).
It uses a modified dmenu_ for creating list of entries along with a nice cover
image and an accompanying tool to make creating these entries a bit more
convenient.

Requires
--------
* bash 4.2+
* imagemagick
* dmenu-pango-imlib_

Install
-------
.. code-block:: sh

    # I keep my local binaries in ~/.local/bin
    make DESTDIR="$HOME"/.local install

    # Optionally you can add your launchers to PATH.
    PATH="$PATH":"${XDG_DATA_HOME:-$HOME/.local/share}"/taverner/bin

What & How
----------
Briefly, a typical session may look like this::

    % barkeep -h
    Usage: barkeep [-h] mk | ls | ed | rm
        Each mode has an -h flag which produces a summary of its help section.

    Create a new menu entry.

        mk <entry> -t <template> [-c <cover>] [-e <editor>]
            -t      Select a template to base the new entry on.
            -c      Path or url to a cover image (note: this is destructive).
            -e      Prefered editor, uses $EDITOR if not set.
            entry   The name for the new launcher script.

    List entries and templates.

        ls [-t]
            -t      List all available templates.

            If no arguments given this will list all entries.

    Edit the selected entry or template.

        ed [-t <template>] [-e <editor>] [-c <cover>] [entry]
            -t      Attempts to open the template with $EDITOR.
            -c      Replace the cover for entry, note that the entry is required
                    for this operation.
            -e      Prefered editor, uses $EDITOR if not set.
            entry   Edit the selected entry.

            Note: Only one operation is possible per innvocation.

    Remove selected entries and corresponding covers.

        rm [entry [entry]]
            If no argument given, attempt to remove all entires.

    Examples:
        # Creates an entry using the psx template called wipeout_3 using emacs
        # as the editor.
        barkeep mk -e emacs -t psx -c ~/wipeout.png wipeout_3

        # Removes both wipeout_3 and crash_bandicoot launchers along with any
        # cover images if found.
        barkeep rm wipeout_3 crash_bandicoot

::

    % barkeep ls -t
    Available templates:
        psx
        snes
        psp
        pc

::

    % barkeep mk wipeout_pulse -t psp -c ~/wipeout_pulse_cover.jpg
    ‘/home/earnest/wipeout_pulse_cover.jpg’ -> ‘/home/earnest/.local/share/taverner/covers/wipeout_pulse’
    ‘/home/earnest/.local/share/taverner/templates/psx’ -> ‘/home/earnest/.local/share/taverner/bin/wipeout_pulse’

At this point you'll get prompted with your ``$EDITOR`` to make any changes to
the template such as specifying what to execute, and where the data files are
located. Here is an example template with places left for you to fill in:

.. code-block:: sh

    #!/bin/bash
    # Title: "title" (PSP "year")

    executable=""
    prefix=""

    exec ppsspp --fullscreen "$prefix"/"$executable"

Here the title is read and passed to dmenu, if ``# Title:`` isn't present,
``taverner`` will fallback on the script's filename.

After editing the template all that remains is to run ``taverner``.

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
