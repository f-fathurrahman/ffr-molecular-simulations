const std = @import("std");

const Vec3 = struct {
    x: f64 = 0.0, // default value
    y: f64,
    z: f64
};

pub fn main() void {
    
    // Vec3 struct name can be removed
    var v: Vec3 = .{
        .y = 1.2345678901,
        .z = 1.1
    };

    std.debug.print("v = {}\n", .{v});

    std.debug.print("v.y = {}\n", .{v.y});
}
