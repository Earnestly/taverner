Design
======
A basic design document for the redesign of taverner

A few ideas
-----------
* XDG Base Directory support and extended systemd-path::
    HOME/.local/share/data/taverner/{launchers,covers}/{foo,bar,baz}
    HOME/.local/bin/{taverner,barkeep}

* A more git-like CLI architecture::
    HOME/.local/lib/taverner/run,add,rm,ls,edit,cat,...}

  Where ``taverner run args`` launches ``HOME/.local/lib/taverner/run args``

* XDG Thumbnail Standard doesn't support more than 256x256, not suitable

* Wine support would be nice, automating the creation of prefixes and installation.
  However this might be quite rigid

* Use a different language?  I guess this doesn't matter if we're using a git
  architecture as each program is separate

Launchers
---------
Shell script? Much more expressive and flexible
