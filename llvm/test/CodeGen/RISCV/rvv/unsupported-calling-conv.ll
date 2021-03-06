; RUN: not --crash llc -mtriple=riscv64 -mattr=+experimental-v < %s 2>&1 | FileCheck %s

; A rather pathological test case in which we exhaust all vector registers and
; all scalar registers, forcing %z to go through the stack. This is not yet
; supported, so check that a reasonable error message is produced rather than
; hitting an assertion or producing incorrect code.
; CHECK: LLVM ERROR: Unable to pass scalable vector types on the stack
define <vscale x 16 x i32> @bar(i32 %0, i32 %1, i32 %2, i32 %3, i32 %4, i32 %5, i32 %6, i32 %7, <vscale x 16 x i32> %x, <vscale x 16 x i32> %y, <vscale x 16 x i32> %z) {
  %s = add <vscale x 16 x i32> %x, %z
  ret <vscale x 16 x i32> %s
}
