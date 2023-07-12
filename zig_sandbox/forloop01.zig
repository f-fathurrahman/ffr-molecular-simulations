const std = @import("std");

pub fn main() void {
    const string = [_]u8 {'a', 'b', 'c'};

    // This is not working for 0.10.1
    for (string, 0..) |character, index| {
        std.debug.print("index = {}, character = {}\n", .{index, character});
    }

    for (string) |c| {
        std.debug.print("character = {}\n", .{c});
    }

    // XXX Using while ?
    // XXX range object ?
    const indices = [_]i32 {1, 2, 3};
    for (indices) |_| {
        std.debug.print("Hello!\n", .{});
    }

}