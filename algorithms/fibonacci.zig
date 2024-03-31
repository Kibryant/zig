const std = @import("std");
const print = @import("std").debug.print;

pub fn main() void {
    print("bad_fibonacchi(10) = {}\n", .{bad_fibonacchi(10)});
    print("good_fibonacchi(10) = {}\n", .{good_fibonacchi(100)});
    print("good_fibonacchi_with_memory(10) = {}\n", .{good_fibonacci_with_memory(10)});
}

fn bad_fibonacchi(n: u32) u32 {
    if (n == 0) {
        return 0;
    } else if (n == 1) {
        return 1;
    } else {
        return bad_fibonacchi(n - 1) + bad_fibonacchi(n - 2);
    }
}

fn good_fibonacchi(n: u32) u128 {
    var a: u128 = 0;
    var b: u128 = 1;
    var i: u128 = 0;

    while (i < n) {
        const next = a + b;
        a = b;
        b = next;
        i += 1;
    }

    return a;
}

// TODO: Implement this

// var memory: [100000000]usize = undefined;

// fn good_fibonacchi_with_memory(n: usize) usize {
//     if (n == 0) {
//         return 0;
//     } else if (n == 1) {
//         return 1;
//     } else if (memory[n] == 0) {
//         memory[n] = good_fibonacchi_with_memory(n - 1) + good_fibonacchi_with_memory(n - 2);
//     }

//     return memory[n];
// }

var memory = [_]u128{undefined};

fn good_fibonacci_with_memory(n: u128) u128 {
    if (n == 0) {
        return 0;
    } else if (n == 1) {
        return 1;
    } else if (memory[n] == 0) {
        memory[n] = good_fibonacci_with_memory(n - 1) + good_fibonacci_with_memory(n - 2);
    }

    print("n = {}\n", .{memory[1]});

    return memory[0];
}
