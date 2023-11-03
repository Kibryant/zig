const std = @import("std");

pub fn main() !void {
    // const file_name = "test.txt";
    // const file = try std.fs.cwd().openFile(file_name, .{});
    // defer file.close();

    const file_name2 = "test2.txt";
    const file2 = try std.fs.cwd().openFile(file_name2, .{});
    defer file2.close();

    // var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    // defer arena.deinit();
    // const allocator = arena.allocator();

    var arena2 = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena2.deinit();
    const allocator = arena2.allocator();

    // const read_buff = try file.readToEndAlloc(allocator, 1024 * 1024);
    // defer allocator.free(read_buff);

    const read_buff2 = try file2.readToEndAlloc(allocator, 1024 * 1024);
    defer allocator.free(read_buff2);

    // try std.io.getStdOut().writeAll(read_buff);
    // var it = std.mem.split(u8, read_buff, "\n");
    // _ = it;
    var it2 = std.mem.split(u8, read_buff2, "\n");

    // while (it2.next()) |strings| {
    //     std.debug.print("{s}\n", .{strings});
    // }

    var elf_array = std.ArrayList(u32).init(allocator);
    defer elf_array.deinit();

    var elf_carring_amount: u32 = 0;

    while (it2.next()) |amount| {
        if (amount.len == 0) {
            try elf_array.append(elf_carring_amount);
            elf_carring_amount = 0;
        } else {
            const result = try std.fmt.parseInt(u32, amount, 10);
            elf_carring_amount += result;
            std.debug.print("{d}\n", .{result});
        }
    }

    for (elf_array.items) |item| {
        std.debug.print("item: {d}\n", .{item});
    }

    const max = std.mem.max(u32, elf_array.items);
    std.debug.print("Max: {}\n", .{max});
}
