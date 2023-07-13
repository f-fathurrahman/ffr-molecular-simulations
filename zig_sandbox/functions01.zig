const std = @import("std");

pub fn main() void {
    var a: f64 = 10.0;
    var b: f64 = 11.0;
    var c = my_func(a, b);
    std.debug.print("c = {}\n", .{c});
}

pub fn my_func(a: f64, b: f64) f64 {
    return (a*b)/(a + b);
}

