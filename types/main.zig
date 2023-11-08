const i: i32 = 42; // 32-bit signed integer
const f: f64 = 3.14159; // 64-bit floating-point number
const b: bool = true; // Boolean
const c: c_char = 'Z'; // Character
const size: usize = 100;
const ssize: isize = -42;
const u8val: u8 = 255; // 8-bit unsigned integer
const u16val: u16 = 65535; // 16-bit unsigned integer
const u32val: u32 = 4294967295; // 32-bit unsigned integer
const u64val: u64 = 18446744073709551615; // 64-bit unsigned integer

const ptr: *u8 = @as(*u8, @ptrCast(0x1234)); // Pointer to an 8-bit unsigned integer

var a = [4]u8{ 1, 2, 3, 4 }; // Array of 4 unsigned 8-bit integers
const str: []const u8 = "Hello, Zig!"; // Null-terminated string

pub fn main() !void {
    const result = i + 10;
    _ = result;
    const isTrue = b == true;
    _ = isTrue;
    const firstChar = str[0];
    _ = firstChar;
}
