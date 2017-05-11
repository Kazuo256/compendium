
local lfs = require 'lfs'
local macro = require 'lux.macro'
local html = require 'compendium.html'
local node = require 'compendium.node'
local css = require 'compendium.css'

local base_path = ...
local out_path  = "./out"

local function generic_path (root, path)
  return root .. "/" .. path
end

local function base (path)
  return generic_path(base_path, path)
end

local function out (path)
  return generic_path(out_path, path)
end

local tree = node:new{}

local function makeTree (node)
  for input in lfs.dir(base(node.path)) do
    local path = node.path .. input
    local attr = lfs.attributes(base(path))
    if attr.mode == "file" then
      local name, format = path:match("^([^.]-)%.(.+)$")
      if format == "lua.html" then
        node:addPage(name)
      elseif format == "md" then
        node:addContent(name)
      elseif format == "lua" then
        node:addGenerator(name)
      end
    elseif attr.mode == "directory" and input ~= "." and input ~= ".." then
      makeTree(node:addDir(path))
    end
  end
  node:sort()
end

makeTree(tree)

local function printPage (output_path, content)
  local output_file = io.open(output_path, 'w')
  output_file:write '<!DOCTYPE html>\n'
  output_file:write '<html lang="en">\n'
  output_file:write(content)
  output_file:write '</html>\n'
  output_file:close()
end

html.setBasePaths(base_path, out_path)

local function walkTree (node)
  -- create dirs and export stylsheets
  local path = out(node.path)
  lfs.mkdir(path)
  local css_out = io.open(path .. "style.css", 'w')
  css_out:write(css)
  css_out:close()
  local env = setmetatable({ node = node }, { __index = html })
  for _,generator in node:eachGenerator() do
    local generator_chunk = assert(loadfile(base(generator .. ".lua"),
                                            't', env))
    local content = generator_chunk()
  end
  for _,dir in node:eachDir() do
    walkTree(dir)
  end
end

walkTree(tree)
