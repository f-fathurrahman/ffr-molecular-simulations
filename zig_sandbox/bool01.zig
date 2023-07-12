const std = @import("std");

pub fn main() void {
    std.debug.print("{}\n", .{true and false});
    std.debug.print("{}\n", .{true or false});
    std.debug.print("{}\n", .{false and false});
}
