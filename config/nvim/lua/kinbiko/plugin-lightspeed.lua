require('lightspeed').setup({
  ignore_case = true,
  exit_after_idle_msecs = { -- Keep waiting for my slow fingers.
    labeled = nil,
    unlabeled = nil,
  },
  jump_to_unique_chars = false,
})
