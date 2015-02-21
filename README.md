# brownvm

`brownvm` enables you to work on your files on brown's servers in totally new ways.

- the `/home/USERNAME` and `/course` directories on brown's servers appear to be on your
  computer. that is, you get `./home/USERNAME` and `./course` on your local machine and
  you can treat them as you would any local file.
- you also have a linux server with the `/course` and home directories mounted at the same
  place as they are on brown's servers. essentially you have a machine with the same
  operating system as brown's servers, but now you have the liberty to install whatever
  you want.

most things in this document assume you're running os x, but there is also information on
linux.

### Why?

total freedom.

1. work locally: you now have all the same tools and programs you're comfortable with
   (running at native speed).
2. target linux: if you want to compile your code, you can use the same great linux tools
   on department machines.

## Usage

after [installing](#installation), instantly mount your files:
![start](http://i.imgur.com/gTtx5fN.png)

and work locally, see changes reflected on server:
![emacs](http://i.imgur.com/fDAqgVL.png)

### Interface

`brownvm`'s interface is done entirely through `make`. here are the targets:

- `start`       - mounts the brown files and starts the vm (only mounts if you're on linux)
- `stop`        - unmounts the brown files and stops the vm (only unmounts if you're on linux)
- `install`     - installs everything (you need `brew` if on os x)
- `install_fs`  - installs everything required to run sshfs (you need `brew` if on os x)
- `init`        - initializes the `.uname` file that tracks your username
- `update`      - pulls down the latest version of this repo
- `mount`       - mounts the brown files
- `umount`      - unmounts the brown files
- `start_vm`    - starts vm (not available on linux)
- `stop_vm`     - stops vm (not available on linux)
- `ssh`         - ssh into the vm (not available on linux)
- `clean`       - unmounts the brown files, and removes extra directories
- `clean_extra` - deletes `.uname`

the more likely use-case is that you just want the sshfs stuff. when this is the case,
only worry about `mount` and `unmount`.

### Workflow Example

after `make install`, you run `make mount`: your home directory is now mounted in this one
at `./home/USERNAME`. now, you work on your homeowrk using your favorite text editor while
dragging and dropping stuff around. once you've finished, you want to compile your code,
so you run `make start_vm ssh`. you install your favorite `clang` tools with `sudo apt-get
install -y llvm clang libblocksruntime-dev`; then you compile your code and run it, but
that was just for fun. now you have to do some web apps hw, but the department's version
of nodejs doesn't really work. instead of running the code on the vm, however, you just
run it locally since your computer already has the latest and greatest version. finally,
you do an `ssh brown` and run the handin command for your assignment.

## Installation

### Requirements

you must be able to ssh into brown by doing `ssh brown`. in order to do so, add

```ini
Host brown
     Hostname ssh.cs.brown.edu
     User USERNAME
```

line to your `~/.ssh/config` file (on your local machine).

#### OS X

you need to have [`brew`](http://brew.sh) installed.

### Installing

first thing you have to do is:

```sh
git clone https://github.com/r-medina/brownvm.git && cd brownvm
```

to get this code and move into that directory. now you can run

```sh
make install
```

#### OS X

you now have all the dependancies for running sshfs and vagrant. if, however, you wanted a
more light-weight installation without the vm, just do

```sh
make install_fs
```

and then be sure to only use the `mount` and `umount` targets to `make` (instead of
`start` and `stop`).

#### Linux

installing will only get sshfs (since you don't need a linux vm). the `start` and `stop`
`make` targets only mount and dismount the brown filesystems.


### Dependancies

- [sshfs](http://fuse.sourceforge.net/sshfs.html)

#### OS X

- [osxfuse](https://osxfuse.github.io/) 
- [virtualbox](https://www.virtualbox.org/)
- [vagrant](https://www.vagrantup.com/)

## FAQ
