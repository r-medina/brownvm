# brownvm

`brownvm` enables you to work on your files on brown's servers in totally new ways.
- the `/home/USERNAME` and `/course` directories on brown's servers appear to be on your
  computer. that is, on your local machine, you now have `./home/USERNAME` and `./course`
  and you can treat those files as any local files.
- you also have a linux virtual machine with those files in the same place they would be
  on brown computers. essentially you have a machine with the same operating system and
  architecture as brown's servers that you can work on (just like you would normally, via
  ssh)

### Why?

these features are useful because now you can work locally without worrying about syncing,
but also bcause now you can install any compilers/state you need to work on those file
(and target the same os/arch).

## Installation

not gonna lie, this requires a whole lot of setup. some of these things components were
already on my computer, so i can't guage how hard it is.

### Requirements

sshfs: ie `brew install sshfs` | `sudo apt-get install sshfs`

vagrant: https://www.vagrantup.com/

you must be able to ssh into brown by doing `ssh brown`. add

    Host brown
         Hostname ssh.cs.brown.edu
         User USERNAME

line to your `~/.ssh/config` file (on your local machine).

### Running

run

    ./bin/brown init USERNAME

to do some setup. then

    ./bin/brown up

puts the files on your machine and boots the vm. ssh in with

    ./bin/brown ssh

finally, shutdown with

    ./bin/brown shutdown
