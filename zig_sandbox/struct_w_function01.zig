const std = @import("std");

const LikeAnObject = struct {
    value: i32,
    // A member function
    fn print(self: *LikeAnObject) void {
        std.debug.print("value: {}\n", .{self.value});
    }
    // Another member function (?)
    fn updateVal(self: *LikeAnObject, new_val: i32) void {
        self.value = new_val;
    }
};

pub fn main() void {
    var obj = LikeAnObject{.value = 47};
    obj.print();

    obj.updateVal(31);
    std.debug.print("obj = {}\n", .{obj});
}
