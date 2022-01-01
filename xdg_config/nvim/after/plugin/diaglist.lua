if not pcall(require, "diaglist") then
  return
end

require("diaglist").init({
    -- optional settings
    -- below are defaults

    -- increase for noisy servers
    debounce_ms = 50,

    -- list in quickfix only diagnostics from clients
    -- attached to a current buffer
    -- if false, all buffers' clients diagnostics is collected
    buf_clients_only = true,
})
