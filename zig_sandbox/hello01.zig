const std = @import("std");

// shortcut
const info = std.log.info;

pub fn main() void {
    // Zig functions have a fixed number of arguments.
    info("Hello World from efefer: ", .{});
    // .{} is an empty anonymous tuple
}
