-- I dislike italics in my code.
function DisableItalics()
    local hl_groups = vim.api.nvim_get_hl(0, {})

    for key, hl_group in pairs(hl_groups) do
        if hl_group.italic then
            vim.api.nvim_set_hl(0, key, vim.tbl_extend("force", hl_group, { italic = false }))
        end
    end
end

DisableItalics()

-- Workaround for deleting old SHADA files. [ref](https://github.com/neovim/neovim/issues/8587)
vim.api.nvim_create_user_command("ClearShada", function()
    local shada_path = vim.fn.expand(vim.fn.stdpath("data") .. "/shada")
    local files = vim.fn.glob(shada_path .. "/*", false, true)
    local all_success = 0
    for _, file in ipairs(files) do
        local file_name = vim.fn.fnamemodify(file, ":t")
        if file_name == "main.shada" then
            -- skip your main.shada file
            goto continue
        end
        local success = vim.fn.delete(file)
        all_success = all_success + success
        if success ~= 0 then
            vim.notify("Couldn't delete file '" .. file_name .. "'", vim.log.levels.WARN)
        end
        ::continue::
    end
    if all_success == 0 then
        vim.print("Successfully deleted all temporary shada files")
    end
end, { desc = "Clears all the .tmp shada files" })
