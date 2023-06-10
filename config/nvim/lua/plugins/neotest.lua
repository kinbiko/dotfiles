return {
  { "marilari88/neotest-vitest" },
  { "nvim-neotest/neotest-jest" },
  {
    "nvim-neotest/neotest",
    opts = {
      adapters = {
        "neotest-jest",
        "neotest-vitest",
        ["neotest-go"] = {
          args = { "-v", "-count=1", "-timeout=30s" },
        },
      },
    },
  },
}
