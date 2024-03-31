const std = @import("std");
const print = @import("std").debug.print;

pub fn main() void {
    recursive(10);
}

fn recursive(number: i32) void {
    print("{}\n", .{number});

    if (number == 0) {
        return;
    }

    recursive(number - 1);
}
