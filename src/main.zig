const print = @import("std").debug.print;
const glfw3 = @import("glfw3.zig");

pub fn main() !void {
    var major: c_int = undefined;
    var minor: c_int = undefined;
    var patch: c_int = undefined;

    glfw3.glfwGetVersion(&major, &minor, &patch);

    print("major -> {d}, minor -> {d}, patch -> {d}\n", .{ major, minor, patch });

    const glfw_err: c_int = glfw3.glfwInit();
    print("{}\n", .{glfw_err});

    const window: ?*glfw3.GLFWwindow = glfw3.glfwCreateWindow(400, 400, "test", null, null);
    if (window == null) {
        print("Error\n", .{});
    } else {
        print("{?}\n", .{window});
    }
}
