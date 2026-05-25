import { defineConfig } from "vitest/config";

export default defineConfig({
  test: {
    include: ["output/Test.Main/index.js"],
    globals: true,
    environment: "jsdom",
  },
});
