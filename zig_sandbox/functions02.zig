const std = @import("std");

pub fn main() void {
    var a: f64 = 10.0;
    var b: f64 = 11.0;

    std.debug.print("Before\n", .{});
    std.debug.print("a = {}\n", .{a});
    std.debug.print("b = {}\n", .{b});    

    modify_values(&a, &b);

    std.debug.print("After\n", .{});
    std.debug.print("a = {}\n", .{a});
    std.debug.print("b = {}\n", .{b});
}

pub fn modify_values(a: *f64, b: *f64) void {
    // Use dereference by `.*`
    a.* = 1111.0;
    b.* = 9999.0;
    return;
}
