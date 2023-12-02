const std = @import("std");
const ascii = std.ascii;

pub fn main() !void {
    const part: []const u8 = if (std.os.argv.len < 2) "part1" else std.mem.span(std.os.argv[1]);
    if (std.mem.eql(u8, part, "part1")) {
        try part1();
    } else if (std.mem.eql(u8, part, "part2")) {
        try part2();
    } else {
        std.debug.print("unknown part {s}\n", .{part});
    }
}

pub fn part1() !void {
    const in = std.io.getStdIn();
    var buf = std.io.bufferedReader(in.reader());
    var r = buf.reader();
    var msg_buf: [4096]u8 = undefined;
    var sum: i32 = 0;
    while (true) {
        var msg = try r.readUntilDelimiterOrEof(&msg_buf, '\n');
        if (msg) |m| {
            var val: [2]u8 = undefined;
            for (m) |ch| {
                if (ascii.isDigit(ch)) {
                    val[0] = ch;
                    break;
                }
            }
            var i = m.len - 1;
            while (i >= 0) : (i -= 1) {
                if (ascii.isDigit(m[i])) {
                    val[1] = m[i];
                    break;
                }
            }
            sum += try std.fmt.parseInt(i32, val[0..], 10);
        } else {
            break;
        }
    }
    std.debug.print("{d}\n", .{sum});
}

pub fn part2() !void {
    const in = std.io.getStdIn();
    var buf = std.io.bufferedReader(in.reader());
    var r = buf.reader();
    var msg_buf: [4096]u8 = undefined;
    var sum: i32 = 0;
    const number_words = [_][]const u8{
        "one", "two", "three", "four", "five", "six", "seven", "eight", "nine",
    };
    while (true) {
        var msg = try r.readUntilDelimiterOrEof(&msg_buf, '\n');
        if (msg) |m| {
            var val: [2]u8 = undefined;
            var i: i32 = 0;
            while (i < m.len) : (i += 1) {
                const ch = m[@intCast(i)];
                if (ascii.isDigit(ch)) {
                    val[0] = ch;
                    break;
                } else {
                    var found = false;
                    for (number_words, 0..) |word, index| {
                        if (std.math.cast(usize, i).? + word.len < m.len and std.mem.eql(u8, word, m[@intCast(i) .. std.math.cast(usize, i).? + word.len])) {
                            val[0] = '0' + std.math.cast(u8, index).? + 1;
                            i += @intCast(word.len);
                            found = true;
                            break;
                        }
                    }
                    if (found) break;
                }
            }
            i = std.math.cast(i32, m.len).? - 1;
            while (i >= 0) : (i -= 1) {
                const ch = m[@intCast(i)];
                if (ascii.isDigit(ch)) {
                    val[1] = ch;
                    break;
                } else {
                    var found = false;
                    for (number_words, 0..) |word, index| {
                        const str_index = std.math.cast(usize, i).?;
                        if (str_index + word.len <= m.len and std.mem.eql(u8, word, m[@intCast(i) .. str_index + word.len])) {
                            val[1] = '0' + std.math.cast(u8, index).? + 1;
                            i += @intCast(word.len);
                            found = true;
                            break;
                        }
                    }
                    if (found) break;
                }
            }
            sum += try std.fmt.parseInt(i32, val[0..], 10);
        } else {
            break;
        }
    }
    std.debug.print("{d}\n", .{sum});
}
