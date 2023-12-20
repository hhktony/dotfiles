function get_password_from_keychain(name)
    -- 'name' should be saved in the login keychain
    local cmd="/usr/bin/security 2>&1 find-generic-password -gwl ".. name ..""
    local handle = io.popen(cmd)
    local result = handle:read("*a")
    handle:close()
    return (result:gsub("^%s*(.-)%s*$", "%1"))
end

hs.hotkey.bind(kb.window, 'y', function()
  local pass = get_password_from_keychain("KM-macpass")
  -- print(pass)
  -- hs.alert(pass)
  hs.eventtap.keyStrokes(pass)
  -- hs.eventtap.keyStrokes(("%06d"):format(pass))
end)

