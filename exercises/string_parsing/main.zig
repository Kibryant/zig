const std = @import("std");

const ElfRange = struct { low: u8, high: u8 };

fn parse_u8(character: []const u8) !u8 {
    const parse_character_to_int = try std.fmt.parseInt(u8, character, 10);
    return parse_character_to_int;
}

fn parse_range(range: []const u8) !ElfRange {
    const sep = std.mem.indexOfScalar(u8, range, '-').?;
    const low = try parse_u8(range[0..sep]);
    const high = try parse_u8(range[sep + 1 ..]);
    return .{ .low = low, .high = high };
}

fn is_contained(elf1: ElfRange, elf2: ElfRange) bool {
    const first_check = elf1.low <= elf2.low and elf1.high >= elf2.high;
    const second_check = elf2.low <= elf1.low and elf2.high >= elf1.high;
    return first_check or second_check;
}

pub fn main() !void {
    const fileName = "main.txt";
    const file = try std.fs.cwd().openFile(fileName, .{});
    defer file.close();

    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const read_buf = try file.readToEndAlloc(allocator, 1024 * 1024);
    defer allocator.free(read_buf);

    var count: u32 = 0;
    var it = std.mem.tokenizeAny(u8, read_buf, "\n");
    while (it.next()) |line| {
        // std.debug.print("{s}\n", .{line});
        const index_of_comma = std.mem.indexOfScalar(u8, line, ',').?; // Usign the ? because can be return a optional value
        // std.debug.print("{}\n", .{index_of_comma});
        const first_range = try parse_range(line[0..index_of_comma]);
        const second_range = try parse_range(line[index_of_comma + 1 ..]);
        // const first_range = line[0..index_of_comma];
        // const second_range = line[index_of_comma + 1 ..];
        // std.debug.print("{s}:{s}\n", .{ first_range, second_range });
        const contained = is_contained(first_range, second_range);
        if (contained) count += 1;

        std.debug.print("{}:{} is contained: {}\n", .{ first_range, second_range, contained });
    }
    std.debug.print("total: {}\n", .{count});
}
