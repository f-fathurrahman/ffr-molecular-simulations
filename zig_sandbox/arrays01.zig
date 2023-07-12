const std = @import("std");

// shortcut
const info = std.log.info;

pub fn main() void {

    // example array literal
    const a = [5]i32 {0, 3, 1, 5, -1};

    // use _ to infer the size of the array
    const b = [_]f64 {0.1, 0.2, 0.4};

    info("a = {}", .{a[0]});
    info("b = {}", .{b[1]});
}
