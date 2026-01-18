{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    scanmem
    ghidra
    binutils # objdump, readelf, nm
    llvm # llvm-objdump
    gdb # gnu debugger
    lldb # llvm debugger
    strace # syscall tracin
    valgrind # memory debuggin
  ];

}
