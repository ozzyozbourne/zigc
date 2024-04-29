const print = @import("std").debug.print;
const glwe = @import("glew.zig");
const glfw = @import("glfw.zig");

pub fn main() !void {
    var major: c_int = undefined;
    var minor: c_int = undefined;
    var patch: c_int = undefined;

    glfw.glfwGetVersion(&major, &minor, &patch);

    print("major -> {d}, minor -> {d}, patch -> {d}\n", .{ major, minor, patch });

    const glfw_err: c_int = glfw.glfwInit();
    print("{}\n", .{glfw_err});

    const err: glwe.GLenum = glwe.glewInit();
    print("{}\n", .{err});
}
