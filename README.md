# Firecracker-Quick-Start

A simple working tree with Firecracker v0.24.5 binaries.

---

## First steps
- *Make sure you're running this in a x86_64 architecture*
- `git clone https://github.com/ttgkowalski/Firecracker-Quick-Start.git`
- `cd Firecracker-Quick-Start`

## #1 Running a MicroVM using a socket

You'll need 2 terminals to run a MicroVM using a socket.

At the **first terminal**, run the following command:
```shell
# ./socket.sh $NAME_OF_YOUR_MICROVM
./socket.sh teste
```

At the **second terminal**:

To set the guess kernel:
```shell
# ./run.sh $NAME_OF_YOUR_MICROVM
./run.sh teste
```

The default login and password is **root**.
To shutdown your instance, just run **reboot**.
