const std = @import("std");

pub fn main() void {
    var arr = [_]f64 {1.0, 2.0, 3.0, 4.4};
    modify_array(&arr);
    print_array(&arr);
}

pub fn modify_array(arr: []f64) void {
    arr[0] = 999.0;
    return;
}

pub fn print_array(arr: []f64,) void {
    for(0..arr.len) |idx| {
        std.debug.print("arr[{}] = {}\n", .{idx, arr[idx]});
    }
    return;
}

