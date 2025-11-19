-- nyan.lua
local M = {}

M.config = {
    width = 30,
    cat = { "🐱" },
    trail = "━",
    colors = { "Red", "Orange", "Yellow", "Green", "Blue", "Purple" },
    rainbow = {
        "#BF1119", "#F52A02", "#FC7800", "#FBA500",
        "#F0D300", "#B4BF00", "#4D9801", "#1E7FF7",
    }
}

function M.render()
    local total = vim.fn.line("$")
    local current = vim.fn.line(".")
    local width = M.config.width
    local pos = math.ceil(current / total * width)
    local percentage = (total > 0) and math.floor(100 * current / total) or 0
    if pos < 1 then pos = 1 end
    if pos > width then pos = width end

    local segments = {}
    table.insert(segments, ("L%s "):format(current))
    for i = 1, width do
        if i == pos then
            local frame = (current % #M.config.cat) + 1
            table.insert(segments, M.config.cat[frame])
        elseif i <= pos then
            local color = M.config.colors[(i-1) % #M.config.colors + 1]
            table.insert(segments, ("%s"):format(M.config.trail))
        else
          table.insert(segments, (" "))
        end
    end
    table.insert(segments, (" %s"):format(percentage))
    table.insert(segments, ("%% "))


    return table.concat(segments)
end

return M
