# brownvm

`brownvm` enables you to work on your files on brown's servers in totally new ways.

- the `/home/USERNAME` and `/course` directories on brown's servers appear to be on your
  computer. that is, you get `./home/USERNAME` and `./course` on your local machine and
  you can treat them as you would any local file.
- you also have a linux server with the `/course` and home directories mounted at the same
  place as they are on brown's servers. essentially you have a machine with the same
  operating system as brown's servers, but now you have the liberty to install whatever
  you want.

### Why?

total freedom.

1. work locally: you now have all the same tools and programs you're comfortable with
   (running at native speed).
2. target linux: if you want to compile your code, you can use the same great linux tools
   on department machines.

## Running/Interface

`brownvm`'s interface is done entirely through `make`. here are the targets:

- `start` - mounts the brown files and starts the vm
- `stop` - unmounts the brown files and stops the vm
- `install`- os x only: installs everything (if you have `brew`)
- `init` - initializes the `.uname` file that tracks your username
- `mount` - mounts the brown files
- `umount` - unmounts the brown files
- `start_vm` - starts vm
- `stop_vm` - stops vm
- `ssh` - ssh into the vm
- `clean` - shuts down the vm, unmounts the brown files, and removes extra directories

### Workflow

![start](http://i.imgur.com/gTtx5fN.png)
intantly mount your files.

![emacs](http://i.imgur.com/fDAqgVL.png)
work locally, see changes reflected on server.

after `make install`, you run `make mount`: your home directory is now mounted in this one
at `./home/USERNAME`. now, you work on your homeowrk using your favorite text editor while
dragging and dropping stuff around. Once you've finished, you want to compile your code,
so you run `make start_vm ssh`. you install your favorite `clang` tools with `sudo apt-get
install -y llvm clang libblocksruntime-dev` then you compile your code and run it, but
that was just for fun. now you have to do some web apps hw, but the department's version
of nodejs doesn't really work. instead of running the code on the vm, however, you just
run it locally since your computer already has the latest and greatest version. finally,
you do an `ssh brown` and run the handin command for your class.

## Installation

first thing you have to do is:

    git clone https://github.com/r-medina/brownvm.git && cd brownvm

to get this code and move into that directory.

### Dependancies

- [osxfuse](https://osxfuse.github.io/) 
- [sshfs](http://fuse.sourceforge.net/sshfs.html)
- [virtualbox](https://www.virtualbox.org/)
- [vagrant](https://www.vagrantup.com/)

### Requirements

you must be able to ssh into brown by doing `ssh brown`. in order to do so, add

```ini
Host brown
     Hostname ssh.cs.brown.edu
     User USERNAME
```

line to your `~/.ssh/config` file (on your local machine).

### OS X Installation

provided you have [`brew`](http://brew.sh), you can run:

```sh
make install
```

to get all the dependancies (they're really big).
