
local lfs = require 'lfs'
local md = require 'markdown'
local macro = require 'lux.macro'

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

local template
do
  template_file = io.open("templates/basic.html", 'r')
  template = template_file:read('a')
  template_file:close()
end

local chapters = {}
for input in lfs.dir(base_path) do
  local chapter = input:match("^(.+).md$")
  if chapter then
    table.insert(chapters, chapter)
  end
end

table.sort(chapters)

for i,chapter in ipairs(chapters) do
  local chapter_file = io.open(base_path.."/"..chapter..".md", 'r')
  local output_file = io.open(out_path.."/"..chapter..".html", 'w')
  local content = md(macro.process(chapter_file:read('a'), {}, '%%'))
  local prev_link = i > 1 and (chapters[i-1]..".html") or '#'
  local next_link = i < #chapters and (chapters[i+1]..".html") or '#'
  local output = template:format(content, prev_link, next_link)
  output_file:write(output)
  chapter_file:close()
  output_file:close()
end
