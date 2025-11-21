-- nyan.lua
local M = {}

M.opts = {
    width = 30,
    cat = { ":>" },
    trail = "━",
    
    colors = {"Red", "Orange", "Yellow", "Green", "Blue", "Purple"},
}

function M.setup(opts)
    M.opts = vim.tbl_deep_extend("force", M.opts, opts or {})
end

function M.render()
    local total = vim.fn.line("$")
    local current = vim.fn.line(".")
    local width = M.opts.width
    local pos = math.ceil(current / total * width)
    local percentage = (total > 0) and math.floor(100 * current / total) or 0
    if pos < 1 then pos = 1 end
    if pos > width then pos = width end

    local segments = {}
    table.insert(segments, ("L%s "):format(current))
    for i = 1, width do
        if i == pos then
            local frame = (current % #M.opts.cat) + 1
            table.insert(segments, M.opts.cat[frame])
        elseif i <= pos then
            local color = M.opts.colors[(i-1) % #M.opts.colors + 1]
            table.insert(segments, ("%s"):format(M.opts.trail))
        else
          table.insert(segments, (" "))
        end
    end
    table.insert(segments, (" %s"):format(percentage))
    table.insert(segments, ("%% "))


    return table.concat(segments)
end

return M
