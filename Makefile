GFLW = /opt/homebrew/Cellar/glfw/3.4/include/GLFW/glfw3.h

.DEFAULT_GOAL := translate

.PHONY:translate

translate:
	zig translate-c $(GFLW) -lc > src/glfw3.zig

clean:
	rm src/glfw3.zig
