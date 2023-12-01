const std = @import("std");
const ascii = std.ascii;

pub fn main() !void {
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
