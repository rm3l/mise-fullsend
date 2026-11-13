--- Returns a list of available versions for the tool
--- Documentation: https://mise.jdx.dev/tool-plugin-development.html#available-hook
--- @param ctx {args: string[]} Context (args = user arguments)
--- @return table[] List of available versions
function PLUGIN:Available(ctx) -- luacheck: ignore ctx
    local http = require("http")
    local json = require("json")

    local result = {}
    local repo_url = "https://api.github.com/repos/fullsend-ai/fullsend/releases"

    while repo_url ~= nil do
        local resp, err = http.get({ url = repo_url })
        if err ~= nil then
            error("Failed to fetch versions: " .. err)
        end
        if resp.status_code ~= 200 then
            error("GitHub API returned status " .. resp.status_code .. ": " .. resp.body)
        end

        for _, release in ipairs(json.decode(resp.body)) do
            if not release.prerelease then
                local version = release.tag_name:gsub("^v", "")
                table.insert(result, { version = version })
            end
        end

        repo_url = resp.headers["link"] and resp.headers["link"]:match('<([^>]+)>;%s*rel="next"')
    end

    return result
end
