GFLW = /opt/homebrew/Cellar/glfw/3.4/include/GLFW/glfw3.h
GLEW = /opt/homebrew/Cellar/glew/2.2.0_1/include/GL/glew.h

.DEFAULT_GOAL := translate

.PHONY:translate

translate:
	zig translate-c $(GLEW) -lc > src/glew.zig
	zig translate-c $(GFLW) -lc > src/glfw3.zig

clean:
	rm src/glew.zig
	rm src/glfw3.zig
