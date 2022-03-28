--[[This file handles exporting of Neorg files to Lua]]


local exporter = neorg.modules.get_module("core.export")

if not exporter then
    return
end

local dir = vim.loop.fs_opendir(".", nil, 20)

for _, table in pairs(vim.loop.fs_readdir(dir)) do
    -- print(entry)
    -- print(vim.inspect(table))
    if table.type == "directory" then
        local directory = "../markdown/" .. table.name
        vim.loop.fs_mkdir(directory, 511)
        -- vim.loop.fs_chmod(directory, 640)
        for _, nest_table in pairs(vim.loop.fs_readdir(vim.loop.fs_opendir(table.name, nil, 20))) do
            if string.sub(nest_table.name, -5) == ".norg" then
                vim.cmd("edit " .. table.name .. "/" .. nest_table.name)
                local exported_contents = exporter.export(vim.api.nvim_get_current_buf(), "markdown")
                local file = "../markdown/" .. table.name .. "/" .. string.sub(nest_table.name, 1, -6) .. ".md"
                vim.loop.fs_open(file, "w", 438, function(err, fd)
                    assert(
                        not err,
                        neorg.lib.lazy_string_concat("Failed to open file '", file, "' for export: ", err)
                    )

                    vim.loop.fs_write(fd, exported_contents, function(werr)
                        assert(
                            not werr,
                            neorg.lib.lazy_string_concat("Failed to write to file '", file, "' for export: ", err)
                        )
                    end)

                    vim.schedule(neorg.lib.wrap(vim.notify, "Successfully exported 1 file!"))
                end)
            end
        end
    elseif table.type == "file" and string.sub(table.name, -5) == ".norg" then
        vim.cmd("edit " .. table.name)
        local exported_contents = exporter.export(vim.api.nvim_get_current_buf(), "markdown")
        local file = "../markdown/" .. string.sub(table.name, 1, -6) .. ".md"
        vim.loop.fs_open(file, "w", 438, function(err, fd)
            assert(
                not err,
                neorg.lib.lazy_string_concat("Failed to open file '", file, "' for export: ", err)
            )

            vim.loop.fs_write(fd, exported_contents, function(werr)
                assert(
                    not werr,
                    neorg.lib.lazy_string_concat("Failed to write to file '", file, "' for export: ", err)
                )
            end)

            vim.schedule(neorg.lib.wrap(vim.notify, "Successfully exported 1 file!"))
        end)
    end
end

