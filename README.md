# SX-Aurora Development with LLVM-VEC

This image includes the freely available development tools and libraries for SX-Aurora Tsubasa
including the `llvm-vec` vectorizer module from NEC and a patched LLVM 12.0.0.


Compiling C or C++ code with `clang` requires adding some options:
* `-target ve-linux` specifies that the compiled code is for the vectore engine VE,
* `-fnvec` enables the NEC VE IR vectorizer,
* `-fdiag-vector=2` outupts more details on the vectorization process.

There are tons of compiler options added for supporting 'llvm-vec', which can vectorize
LLVM-IR when called separately:
https://sxauroratsubasa.sakura.ne.jp/documents/llvm-vec/en/LLVMVecCommand.html

A large number of vectorization related pragmas are supported in exactly the same format
as used in the proprietary compiler `ncc/nc++` documented [here](https://sxauroratsubasa.sakura.ne.jp/documents/sdk/pdfs/g2af01e-C++UsersGuide-027.pdf).
The pragmas are written in the format`#pragma _NEC ...`. Supported pragmas are:
* [no]advance_gather
* [no]assume
* gather_reorder
* ivdep
* [no]list_vector
* [no]lstval
* move / move_unsafe / nomove
* nofma
* [no]packed_vector
* shortloop
* [no]sparse
* [no]vector
* [no]verror_check
* [no]vob
* [no]vovertake
* [no]vwork


## Usage

Run the docker image by invoking the included script:
```
./run-docker-llvm-vec.sh
```

It will mount the current user's home directory into the image, as well as
the /etc/passwd and /etc/group files (in order to provide the proper user IDs
for the mounted home file system). This might lead to UID mismatches inside
the container, but we're not expecting the user to run any system services
inside the container.



## Build

```
docker build --network host --tag efocht/llvm-vec:2.3.0 .

# tag as 'latest', if you want
docker image tag efocht/llvm-vec:2.3.0 efocht/llvm-vec:latest
```

## Upload to dockerhub
```
docker push efocht/llvm-vec:2.3.0
docker push efocht/llvm-vec:latest
```

