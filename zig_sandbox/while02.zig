const std = @import("std");

pub fn main() void {
    var sum: u8 = 0;
    var i: u8 = 1;
    while( i <= 10 ) : (i += 2) {
        std.debug.print("i = {}\n", .{i});
        sum += i;
    }
    std.debug.print("sum = {}\n", .{sum});
}