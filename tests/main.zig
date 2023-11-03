const std = @import("std");

pub fn main() !void {
    std.debug.print("Hello World\n", .{});

    const fileName = "day1.txt";
    const file = try std.fs.cwd().openFile(fileName, .{});
    defer file.close();

    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const read_buf = try file.readToEndAlloc(allocator, 1024 * 1024);
    defer allocator.free(read_buf);

    // try std.io.getStdOut().writeAll(read_buf);

    var it = std.mem.split(u8, read_buf, "\n");

    var elfArray = std.ArrayList(u32).init(allocator);
    defer elfArray.deinit();

    var elfCarryingAmount: u32 = 0;

    while (it.next()) |amount| {
        if (amount.len == 0) {
            try elfArray.append(elfCarryingAmount);
            elfCarryingAmount = 0;
        } else {
            const result: u32 = try std.fmt.parseInt(u32, amount, 10);
            elfCarryingAmount += result;
            // std.debug.print("{}\n", .{result});
        }
    }

    for (elfArray.items) |item| {
        std.debug.print("item: {}", .{item});
    }

    const max = std.mem.max(u32, elfArray.items);
    std.debug.print("Max: {}\n", .{max});
}
