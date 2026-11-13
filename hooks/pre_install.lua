--- Returns download information for a specific version
--- Documentation: https://mise.jdx.dev/tool-plugin-development.html#preinstall-hook
--- @param ctx {version: string, runtimeVersion: string} Context
--- @return table Version and download information
function PLUGIN:PreInstall(ctx)
    local http = require("http")
    local version = ctx.version

    local os_name = RUNTIME.osType:lower()
    local arch = RUNTIME.archType

    local supported = {
        ["darwin"] = { ["amd64"] = true, ["arm64"] = true },
        ["linux"] = { ["amd64"] = true, ["arm64"] = true },
    }
    if not supported[os_name] or not supported[os_name][arch] then
        error("Unsupported platform: " .. RUNTIME.osType .. "/" .. arch)
    end

    local filename = "fullsend_" .. version .. "_" .. os_name .. "_" .. arch .. ".tar.gz"
    local base_url = "https://github.com/fullsend-ai/fullsend/releases/download/v" .. version
    local url = base_url .. "/" .. filename

    local sha256 = nil
    local checksum_url = base_url .. "/checksums.txt"
    local resp, err = http.get({ url = checksum_url })
    if err == nil and resp.status_code == 200 then
        for line in resp.body:gmatch("[^\r\n]+") do
            local sum, name = line:match("^(%S+)%s+(.+)$")
            if name == filename then
                sha256 = sum
                break
            end
        end
    end

    return {
        version = version,
        url = url,
        sha256 = sha256,
    }
end
