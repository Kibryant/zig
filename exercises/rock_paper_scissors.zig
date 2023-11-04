const std = @import("std");

const Move = enum { rock, paper, scissors };

// MY MOVES: ROCK(X), PAPER(Y), SCISSORS(Z)
// MY OPPONENTMOVES: ROCK(A), PAPER(B), SCISSORS(C)

const Result = enum { win, draw, loss };

const EncryptionError = error{UnrecognizedInput}; //My own error

fn decrypt_my_move(input: u8) EncryptionError!Move {
    const result: EncryptionError!Move = switch (input) {
        'X' => .rock,
        'Y' => .paper,
        'Z' => .scissors,
        else => EncryptionError.UnrecognizedInput,
    };
    return result;
}

fn decrypt_my_opponent_move(input: u8) EncryptionError!Move {
    const result: EncryptionError!Move = switch (input) {
        'A' => .rock,
        'B' => .paper,
        'C' => .scissors,
        else => EncryptionError.UnrecognizedInput,
    };
    return result;
}

fn handle_result(myMove: Move, opponentMove: Move) Result {
    const result: Result = switch (myMove) {
        .rock => switch (opponentMove) {
            .rock => Result.draw,
            .paper => Result.loss,
            .scissors => Result.win,
        },
        .paper => switch (opponentMove) {
            .rock => Result.win,
            .paper => Result.draw,
            .scissors => Result.loss,
        },
        .scissors => switch (opponentMove) {
            .rock => Result.loss,
            .paper => Result.win,
            .scissors => Result.draw,
        },
    };
    return result;
}

fn getMoveScore(move: Move) i32 {
    const result: i32 = switch (move) {
        .rock => 1,
        .paper => 2,
        .scissors => 3,
    };
    return result;
}

fn getResultScore(result: Result) i32 {
    const score: i32 = switch (result) {
        .win => 6,
        .draw => 3,
        .loss => 0,
    };
    return score;
}

fn get_round_score(move: Move, result: Result) i32 {
    const move_score: i32 = getMoveScore(move);
    const result_score: i32 = getResultScore(result);
    return move_score + result_score;
}

pub fn main() !void {
    const file_name = "rock_paper_scissors.txt";
    const file = try std.fs.cwd().openFile(file_name, .{});
    defer file.close();

    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const read_buf = try file.readToEndAlloc(allocator, 1024 * 1024);
    defer allocator.free(read_buf);

    // try std.io.getStdOut().writeAll(read_buf);

    var total_score: i32 = 0;

    var it = std.mem.tokenizeAny(u8, read_buf, "\n"); //Encrypt
    while (it.next()) |item| {
        // const mymove = item[2];
        // std.debug.print("{c}\n", .{mymove});

        const myMove: Move = try decrypt_my_move(item[2]);
        const opponentMove: Move = try decrypt_my_opponent_move(item[0]);
        std.debug.print("{}: {}\n", .{ myMove, opponentMove });
        const result: Result = handle_result(myMove, opponentMove);
        std.debug.print("Result for the round: {}\n", .{result});
        const score: i32 = get_round_score(myMove, result);
        std.debug.print("Score for the round: {}\n", .{score});
        total_score += score;
    }
    std.debug.print("Final score: {}\n", .{total_score});
}
