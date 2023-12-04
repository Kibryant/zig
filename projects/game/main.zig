const std = @import("std");
const print = std.debug.print;

// @tODO: figure out how to get the index of the array

pub fn main() void {
    var items: [3]u8 = undefined;

    for (items, 0..) |item, index| {
        print("{d}\n", .{item});
        // items[index] = item + 1;
        // print("{d}\n", .{item});
    }
    // display_board(board);
}

// var board = [3][3]u8{
//     [_]u8{ undefined, undefined, undefined },
//     [_]u8{ undefined, undefined, undefined },
//     [_]u8{ undefined, undefined, undefined },
// };

// fn display_board(boards: [3][3]u8) void {
//     for (boards, 0..) |row, row_index| {
//         _ = row_index;
//         for (row, 0..) |cell, column_index| {
//             _ = column_index;
//             print("{}", cell);
//         }
//         print("\n");
//     }
// }
