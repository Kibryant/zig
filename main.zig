const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    std.debug.print("Hello, world!\n", .{});
    try stdout.print("Hello, {s}!\n", .{"world"});
}
