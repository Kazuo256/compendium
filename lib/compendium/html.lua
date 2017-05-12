
local md = require 'markdown'
local macro = require 'lux.macro'

local html = {}

local base_path = ""
local output_path = ""

local HEAD = [[
<head>
  <title>%s</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  %s
</head>
]]

local REQUIRE_BOOTSTRAP = [[
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<link rel="stylesheet" href="style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
]]

function html.setBasePaths (in_path, out_path)
  base_path = in_path
  output_path = out_path
end

function html.header (title)
  return function (opt)
    return HEAD:format(title, opt.bootstrap and REQUIRE_BOOTSTRAP or "")
  end
end

function html.content (filename)
  local content_file = io.open(base_path.."/"..filename..".md", 'r')
  return md(macro.process(content_file:read('a'), html))
end

function html.render (page)
  return function (env)
    local page_file = io.open(base_path .. '/' .. page .. ".lua.html", 'r')
    local content = macro.process(page_file:read('a'),
                                  setmetatable(env, { __index = html })
    page_file:close()
    return content
  end
end

function html.printPage (path, content)
  local output_file = io.open(output_path .. "/" .. path .. ".html", 'w')
  output_file:write '<!DOCTYPE html>\n'
  output_file:write '<html lang="en">\n'
  output_file:write(content)
  output_file:write '</html>\n'
  output_file:close()
end

return html
