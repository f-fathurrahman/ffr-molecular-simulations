const std = @import("std");

pub fn main() void {
    var sum: u8 = 0;
    var i: u8 = 0;
    while( i <= 5 ) : (i += 1) {
        if( i == 2 ) continue;
        std.debug.print("i = {}\n", .{i});
        sum += i;
    }
    std.debug.print("sum = {}\n", .{sum});
}