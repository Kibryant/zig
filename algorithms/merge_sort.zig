// TODO: Fix this code

// const std = @import("std");
// const print = @import("std").debug.print;

// pub fn main() void {
//     const arr = [_]i32{ 38, 27, 43, 3, 9, 82, 10 };
//     merge_sort(arr);

//     for (arr) |elem| {
//         print("{}, ", .{elem});
//     }
// }

// fn merge_sort(comptime arr: anytype) void {
//     if (arr.len <= 1) {
//         return arr;
//     }

//     const mid = arr.len / 2;
//     const left = arr[0..mid];
//     const right = arr[mid..];

//     merge(merge_sort(left), merge_sort(right));
// }

// fn merge(comptime left: i32, comptime right: i32) []i32 {
//     const result = [_]i32{0} * (left.len + right.len);
//     var i = 0;
//     var j = 0;
//     var k = 0;

//     while (i < left.len and j < right.len) {
//         if (left[i] < right[j]) {
//             result[k] = left[i];
//             i += 1;
//         } else {
//             result[k] = right[j];
//             j += 1;
//         }
//         k += 1;
//     }

//     while (i < left.len) {
//         result[k] = left[i];
//         i += 1;
//         k += 1;
//     }

//     while (j < right.len) {
//         result[k] = right[j];
//         j += 1;
//         k += 1;
//     }

//     return result;
// }
