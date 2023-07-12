const std = @import("std");

pub fn main() void {
    var i: u32 = 2;
    //var i: u8 = 2;
    while( i < 1000) {
        i *= 2;
        std.debug.print("i = {}\n", .{i});
    }
}