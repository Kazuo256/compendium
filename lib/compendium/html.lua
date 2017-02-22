
local md = require 'markdown'
local macro = require 'lux.macro'

local html = {}

local base_path = ""

local HEAD = [[
<head>
  <title>%s</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
  <link rel="stylesheet" href="style.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</head>
]]

function html.setBasePath (path)
  base_path = path
end

function html.header (title)
  return HEAD:format(title)
end

function html.content (filename)
  local content_file = io.open(base_path.."/"..filename..".md", 'r')
  return md(macro.process(content_file:read('a'), html))
end

return html
