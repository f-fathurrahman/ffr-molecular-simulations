const std = @import("std");

const Vec3 = struct {
    x: f64,
    y: f64,
    z: f64
};

pub fn main() void {
    var v = Vec3{.x = 2.3, .y = 3.3, .z = 12.1};
    std.debug.print("v = {}\n", .{v});
}
