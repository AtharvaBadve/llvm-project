; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=arm-- -mcpu=cortex-a8 | FileCheck %s

; Check that the peepholer removes dead instructions:
;
;   vmov s0, r0
;   vmov r0, s0

define void @t(float %x) nounwind ssp {
; CHECK-LABEL: t:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    movw r1, #65534
; CHECK-NEXT:    movt r1, #32639
; CHECK-NEXT:    cmp r0, r1
; CHECK-NEXT:    bxhi lr
; CHECK-NEXT:  .LBB0_1: @ %if.then
; CHECK-NEXT:    b doSomething
entry:
  %0 = bitcast float %x to i32
  %cmp = icmp ult i32 %0, 2139095039
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  tail call void @doSomething(float %x) nounwind
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}

declare void @doSomething(float)
