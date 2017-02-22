
local lfs = require 'lfs'
local macro = require 'lux.macro'
local html = require 'compendium.html'

local base_path = ...
local out_path  = base_path .. "/out"

lfs.mkdir(out_path)

do -- export css
  local css_in  = io.open("resources/style.css", 'r')
  local css_out = io.open(out_path .. "/style.css", 'w')
  css_out:write(css_in:read('a'))
  css_in:close()
  css_out:close()
end

local pages = {}
for input in lfs.dir(base_path) do
  local page = input:match("^(.+).lua.html$")
  if page then
    table.insert(pages, page)
  end
end

table.sort(pages)

for i,page in ipairs(pages) do
  local page_file = io.open(base_path.."/"..page..".lua.html", 'r')
  local output_file = io.open(out_path.."/"..page..".html", 'w')
  html.setBasePath(base_path)
  local content = macro.process(page_file:read('a'), html)
  page_file:close()
  output_file:write '<!DOCTYPE html>\n'
  output_file:write '<html lang="en">\n'
  output_file:write(content)
  output_file:write '</html>\n'
  output_file:close()
end
