const std = @import("std");

pub fn main() void {
    const one_plus_one: i32 = 1 + 1;
    std.debug.print("1 + 1 = {}\n", .{one_plus_one});
}
