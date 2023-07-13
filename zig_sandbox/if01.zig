const std = @import("std");

pub fn main() void {

    const a = false;
    var x: u16 = 0;

    std.debug.print("Initial x = {}\n", .{x});

    if(a) {
        std.log.print("Add 1 to x\n", .{});
        x += 1;
    }
    else {
        std.debug.print("Add 2 to x\n", .{});
        x += 2;
    }

    std.debug.print("x = {}\n", .{x});
}