! RUN: not %f18 -fparse-only %s 2>&1 | FileCheck %s

! Ensure that old-style PARAMETER statements are disabled by default.

!CHECK: error: expected '('
parameter x = 666
end
