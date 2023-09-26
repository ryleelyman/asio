const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const asio = b.addStaticLibrary(.{
        .name = "asio",
        .target = target,
        .optimize = optimize,
    });

    asio.installHeader(b.pathJoin(&.{ "asio", "include", "asio.hpp" }), "asio.hpp");
    asio.installHeadersDirectory(b.pathJoin(&.{ "asio", "include", "asio" }), "asio");
    asio.defineCMacro("ASIO_STANDALONE", "1");
    asio.defineCMacro("ASIO_SEPARATE_COMPILATION", "1");
    asio.addCSourceFile(.{
        .file = .{ .path = b.pathJoin(&.{ "asio", "src", "asio.cpp" }) },
        .flags = &.{"-Wno-deprecated-declarations"},
    });
    asio.addIncludePath(.{ .path = b.pathJoin(&.{ "asio", "include" }) });
    asio.linkLibCpp();
    b.installArtifact(asio);
}
