# packer-freebsd
My Packer template for FreeBSD.

## contains
iso image
 * FreeBSD-10.1-RELEASE-amd64-disc1.iso

bsdinstall distributions
 * base
 * kernel

filesystem
 * ufs (20480MB)


## build

git clone this repository.

```sh
$ git clone https://github.com/kunst1080/packer-freebsd
$ cd packer-freebsd
```

download iso image. (if you don't have iso image.)

```sh
$ cat iso-url.txt | xargs curl -O
```

packer build

```sh
$ packer build FreeBSD-10.1-RELEASE-amd64.json
```
