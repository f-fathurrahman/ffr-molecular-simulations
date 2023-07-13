const std = @import("std");

pub fn main() void {
    var a: f32 = 5/2;
    std.debug.print("a = {}\n", .{a});

    a = 5.0/2.0;
    std.debug.print("a = {}\n", .{a});

    var b: f64 = 0.0;
    var c: f64 = 0.0;
    b = 1.0/3.2;
    c = 7.0/2.0;
    std.debug.print("b = {}\n", .{b});
    std.debug.print("c = {}\n", .{c});
    std.debug.print("b + c = {}\n", .{b + c});
}
