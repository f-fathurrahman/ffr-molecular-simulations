const std = @import("std");

pub fn main() void {
    var my_arr = [_]u32{12, 34, 45, 88, 11};

    var slice1 = my_arr[0..3];
    std.debug.print("slice1[0]: {}\n", .{slice1[0]});

    var slice2 = my_arr[1..3];
    std.debug.print("slice2[0]: {}\n", .{slice2[0]});

    slice2[1] = 999;
    std.debug.print("slice2 is modified ...\n", .{});

    std.debug.print("\nmy_arr = \n", .{});
    for( my_arr, 0..my_arr.len ) |v, idx| {
        std.debug.print("{}: {}\n", .{idx, v});
    }

    std.debug.print("\nslice1 = \n", .{});
    for( slice1, 0..slice1.len ) |v, idx| {
        std.debug.print("{}: {}\n", .{idx, v});
    }

    std.debug.print("\nslice2 = \n", .{});
    for( slice2, 0..slice2.len ) |v, idx| {
        std.debug.print("{}: {}\n", .{idx, v});
    }
}