const print = @import("std").debug.print;
const glfw3 = @import("glfw3.zig");
const glew = @import("glew.zig");

const WIDTH: glfw3.GLint = 800;
const HEIGHT: glfw3.GLint = 600;

pub fn main() !void {
    // initilise GLFW
    const init_error: c_int = glfw3.glfwInit();
    if (init_error == glfw3.GLFW_TRUE) {
        print("GLFW initilized successfully -> {d}\n", .{init_error});
    } else {
        print("unable to init GLFW\n", .{});
        glfw3.glfwTerminate();
        return;
    }

    // Setup GLFW window properties
    // Opengl version
    glfw3.glfwWindowHint(glfw3.GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfw3.glfwWindowHint(glfw3.GLFW_CONTEXT_VERSION_MINOR, 3);
    // Core profile = No backwards Compatibility
    glfw3.glfwWindowHint(glfw3.GLFW_OPENGL_PROFILE, glfw3.GLFW_OPENGL_CORE_PROFILE);
    // Allow forward compatibility
    glfw3.glfwWindowHint(glfw3.GLFW_OPENGL_FORWARD_COMPAT, glfw3.GLFW_TRUE);

    const window: ?*glfw3.GLFWwindow = glfw3.glfwCreateWindow(WIDTH, HEIGHT, "Test Window", null, null);
    if (window == null) {
        print("GLFW window creation failed", .{});
        glfw3.glfwTerminate();
        return;
    }

    //Get buffer size information
    var bufferWidth: c_int = undefined;
    var bufferHeight: c_int = undefined;
    glfw3.glfwGetFramebufferSize(window, &bufferWidth, &bufferHeight);

    //Set context for GLEW to use
    glfw3.glfwMakeContextCurrent(window);

    // Allow modern extensions features
    glew.glewExperimental = glew.GL_TRUE;

    const glew_error: glew.GLenum = glew.glewInit();
    if (glew_error == glew.GLEW_OK) {
        print("GLEW initilized successfully {d}\n", .{glew_error});
    } else {
        print("GLEW initilized failed {}\n", .{glew_error});
        glfw3.glfwDestroyWindow(window);
        glfw3.glfwTerminate();
        return;
    }

    //Setup Viewport size
    glew.glViewport(0, 0, bufferWidth, bufferHeight);

    //Loop until the window closed
    while (glfw3.glfwWindowShouldClose(window) != 1) {
        // Get + Handle user input events
        glfw3.glfwPollEvents();

        //clear window
        glfw3.glClearColor(@as(f32, 1.0), @as(f32, 0.0), @as(f32, 0.0), @as(f32, 1.0));
        glfw3.glClear(glfw3.GL_COLOR_BUFFER_BIT);

        glfw3.glfwSwapBuffers(window);
    }
}
