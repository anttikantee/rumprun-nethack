### What?

[NetHack](http://nethack.org/) is probably the first game in the world to
run entirely as a [unikernel](https://en.wikipedia.org/wiki/Unikernel)
(if you have information to the contrary, I'd love
to know).  The binary offered here is built against
[Rumprun](http://repo.rumpkernel.org/rumprun) and boots and runs directly
in QEMU.  Alternatively, you should be able to run it on any emulator
or hypervisor which supports a virtio blk backend.  Technically, block
storage is not required if you play from 0 to ascension in one sitting,
but at least I'm not that good, not yet anyway, so I prefer to save and
do something else.  Ergo, I've configured this setup to use block storage.


### Dependecies?

Just a regular `qemu-system-x86_64` is required, nothing else.  Notably,
you do *not* need to download Rumprun, build it, or anything like that.

You also need `xz` to decompress the images.  And I'll just go ahead
and assume you have `/bin/sh` (if not, you can run qemu manually).


### How?

Just run the script to run the game.  It will uncompress the images --
the file system image containing the NetHack data file and savegames is
on purpose a bit larger than necessary, so that you don't conveniently
run out of space when you try to save your game on the Astral Plane.

That was the easy part.  Then do a nopoly-atheist-nofood ascension.
That's that hard part.

Quitting the game via quit or save will automatically halt the
unikernel.  You can then safely kill QEMU (e.g. with ctrl-c).  If you
kill QEMU while the game is running, your game will be lost, obviously.
In that case, you can attempt to use `recover`, which you can get from the
NetHack sources.  Nevertheless, violence will also risk corrupting the
file system image.  IOW, it's just like with a regular OS.


### Why?

NetHack 3.6.0 came out, I was planning to play it during Christmas, and
this was a good way to combine atypical usage pattern testing of the
[rump kernel](http://rumpkernel.org/) components forming the basis of
the Rumprun unikernel.

Besides, it was a good way to non-seriously play around with some ideas
on how one might distribute and deploy Rumprun unikernels.  Not everything
has to always be end-of-the-world serious.


### Any other usage potential besides fun?

This sort of approach is unlikely to catch on for the cloud use
cases of the Rumprun unikernel.  However, for embedded devices
it's a different thing.  It seems completely feasible to deploy
e.g. various terminals running Rumprun unikernels instead of
fullblown operating systems.


### 4+MB?  Are you kidding me?  That is not a unikernel, it's bloatware.

All I can say is "eight extra KILOBYTES of worthless cursor positioning code".


### How can I edit .nethackrc?

Edit `/root/.nethackrc` within the file system image.  It's a normal
ext2fs image, so you can access it with anything you can access ext2
with, e.g. [fs-utils](http://repo.rumpkernel.org/fs-utils) or `rump_ext2fs`
or `fuseext2`.  (Reminder: for the love of security, do *not* mount any
file system image you do not completely trust with an in-kernel driver!
I generated the image, and I don't trust `genext2fs` enough to mount the
resulting image with an in-my-laptop-kernel driver.)


### Dude, where's the source?

You can get NetHack sources from http://nethack.org/
(the NetHack compiled into the binary is 100% unmodified over
upstream sources -- up to the point where, since NO_SIGNAL didn't compile,
I just didn't use it for the build)

You can get the Rumprun unikernel sources from
http://repo.rumpkernel.org/rumprun/.

You will also need libterminfo and libcurses.  They are not distributed
as part of http://repo.rumpkernel.org/src-netbsd/, so you need to get
them separately from http://www.NetBSD.org/

The build procedure is convoluted -- just check out the NetHack cross build
procedure alone -- and has not yet been automated.  Eventually, the goal
is to offer NetHack for Rumprun with an automated build procedure from
http://repo.rumpkernel.org/rumprun-packages/.

But for now, I just want to play some NetHack.


### Hjaelp, the keyboard doesn't work

Don't touch the keyboard before the game is up and running.  Surely you
can manage half a second of patience.  For now, we'll call it a feature
(see above about wanting to play).


### Did you ascend already?

Yes.  [YAAP](http://www.cs.hut.fi/~pooka/yaap-unikernel-20160101/) is
available as screenshots.
