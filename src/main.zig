const print = @import("std").debug.print;
const glfw3 = @import("glfw3.zig");
const glew = @import("glew.zig");

pub fn main() !void {
    var major: c_int = undefined;
    var minor: c_int = undefined;
    var patch: c_int = undefined;

    glfw3.glfwGetVersion(&major, &minor, &patch);

    print("major -> {d}, minor -> {d}, patch -> {d}\n", .{ major, minor, patch });

    const glfw_err: c_int = glfw3.glfwInit();
    print("{}\n", .{glfw_err});

    if (glfw_err != glfw3.GLFW_TRUE) {
        print("glwf init error is not zero {d}\n", .{glfw_err});
        return;
    }

    glfw3.glfwWindowHint(glfw3.GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfw3.glfwWindowHint(glfw3.GLFW_CONTEXT_VERSION_MINOR, 3);
    glfw3.glfwWindowHint(glfw3.GLFW_OPENGL_PROFILE, glfw3.GLFW_OPENGL_CORE_PROFILE);

    const window: ?*glfw3.GLFWwindow = glfw3.glfwCreateWindow(400, 400, "test", null, null);
    defer glfw3.glfwDestroyWindow(window);

    if (window == null) {
        print("Error -> {?}\n", .{window});
    } else {
        print("{?}\n", .{window});
    }

    glfw3.glfwMakeContextCurrent(window);
    glew.glewExperimental = glew.GL_TRUE;

    const glew_err: glew.GLenum = glew.glewInit();

    if (glew_err == glew.GLEW_OK) {
        print("All good\n", .{});
    }

    const version: [*c]const glew.GLubyte = glew.glGetString(glew.GL_VERSION);

    print("{s}\n", .{version});

    while (glfw3.glfwWindowShouldClose(window) != 1) {
        glfw3.glfwSwapBuffers(window);
        glfw3.glfwPollEvents();
    }
}
