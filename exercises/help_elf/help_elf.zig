const print = @import("std").debug.print;
const std = @import("std");

fn find_common(item: []const u8, allocator: std.mem.Allocator) !u8 {
    // std.debug.print("{c}\n", .{item});
    const half_length = item.len / 2;
    const first_compartment = item[0..half_length]; // 0, half_length
    const second_compartment = item[half_length..];
    // std.debug.print("{c}\n", .{first_compartment});
    // std.debug.print("{c}\n", .{second_compartment});
    var map = std.AutoHashMap(u8, void).init(allocator);
    defer map.deinit();

    for (first_compartment) |i| {
        var v = try map.getOrPut(i);
        if (!v.found_existing) {
            v.value_ptr.* = {};
        }
    }

    for (second_compartment) |j| {
        if (map.contains(j)) {
            // print("Found common: {c}\n", .{j});
            return j;
        }
    }

    return undefined;
}

fn get_priority(c: u8) u32 {
    // print("{any}\n", .{c});
    // print("{c}\n", .{c});
    if (c >= 'a') {
        // const diff: u8 = c - 'a' + 1;
        // _ = diff;
        // print("{c} {any}\n", .{ c, diff });
        return c - 'a' + 1;
    }

    return c - 'A' + 1;
}

pub fn main() !void {
    const fileName = "help_elf.txt";
    const file = try std.fs.cwd().openFile(fileName, .{});
    defer file.close();

    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const read_buf = try file.readToEndAlloc(allocator, 1024 * 1024);
    defer allocator.free(read_buf);

    var sum: u32 = 0;
    var it = std.mem.tokenizeAny(u8, read_buf, "\n");
    while (it.next()) |item| {
        // print("{c}", .{item});
        const common_character = try find_common(item, allocator);
        const priority = get_priority(common_character);
        sum += priority;
        print("Found common: {c} with priority: {}\n", .{ common_character, priority });
    }
    print("Total sum: {}\n", .{sum});
}
