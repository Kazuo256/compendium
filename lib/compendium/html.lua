
local md = require 'markdown'
local template = require 'pl.template'

local HTML = {}

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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<link rel="stylesheet" href="style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
]]

local LINK_STYLESHEET = [[
<link rel="stylesheet" href="%s.css">
]]

function HTML.setBasePaths (in_path, out_path)
  base_path = in_path
  output_path = out_path
end

function HTML.header (title)
  return function (opt)
    local extras = {}
    if opt.bootstrap then
      table.insert(extras, REQUIRE_BOOTSTRAP)
    end
    for _,stylesheet in ipairs(opt.stylesheets or {}) do
      table.insert(extras, LINK_STYLESHEET:format(stylesheet))
    end
    return HEAD:format(title, table.concat(extras, "\n"))
  end
end

function HTML.wrap (env)
  env.__parent = env.__parent or HTML
  return env
end

function HTML.content (content_path)
  return function (env)
    local content_file = io.open(base_path.."/"..content_path..".md", 'r')
    local contents = md(template.substitute(content_file:read('a'),
                                            HTML.wrap(env)))
    content_file:close()
    return contents
  end
end

function HTML.render (page_path)
  return function (env)
    local page_file = io.open(base_path .. '/' .. page_path .. ".lua.html", 'r')
    local contents = template.substitute(page_file:read('a'), HTML.wrap(env))
    page_file:close()
    return contents
  end
end

function HTML.printPage (path, content)
  local output_file = io.open(output_path .. "/" .. path .. ".html", 'w')
  output_file:write '<!DOCTYPE html>\n'
  output_file:write '<html lang="en">\n'
  output_file:write(content)
  output_file:write '</html>\n'
  output_file:close()
end

return HTML

