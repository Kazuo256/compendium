
local lfs = require 'lfs'
local macro = require 'lux.macro'
local html = require 'compendium.html'

local base_path = ...
local out_path  = "./out"

local pages = {}
local dirs = { out_path }

local function findPages (dir)
  for input in lfs.dir(base_path .. "/" .. dir) do
    local path = dir .. input
    local attr = lfs.attributes(base_path .. "/" .. path)
    if attr.mode == "file" then
      local page = path:match("^(.+).lua.html$") if page then
        table.insert(pages, page)
      end
    elseif attr.mode == "directory" and input ~= "." and input ~= ".." then
      table.insert(dirs, path)
      findPages(path .. "/")
    end
  end
end

findPages("")

table.sort(dirs)
table.sort(pages)

do
  local css_in  = io.open("resources/style.css", 'r')
  local css = css_in:read('a')
  css_in.close()
  for i,dir in ipairs(dirs) do
    lfs.mkdir(out_path .. "/" .. dir)
    -- export css
    local css_out = io.open(out_path .. "/" .. dir .. "/style.css", 'w')
    css_out:write(css)
    css_out:close()
  end
end

for i,page in ipairs(pages) do
  local page_file = io.open(base_path .. "/" .. page .. ".lua.html", 'r')
  local output_file = io.open(out_path .. "/" .. page .. ".html", 'w')
  html.setBasePath(base_path)
  local content = macro.process(page_file:read('a'), html)
  page_file:close()
  output_file:write '<!DOCTYPE html>\n'
  output_file:write '<html lang="en">\n'
  output_file:write(content)
  output_file:write '</html>\n'
  output_file:close()
end
