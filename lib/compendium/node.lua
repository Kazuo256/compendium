
local node = require 'lux.class' :new {
  path = ""
}

node.__init = {
  dirs = {},
  pages = {},
  contents = {},
  generators = {}
}

function node:eachDir ()
  return ipairs(self.dirs)
end

function node:eachPage ()
  return ipairs(self.pages)
end

function node:eachContent ()
  return ipairs(self.contents)
end

function node:eachGenerator ()
  return ipairs(self.generators)
end

function node:addDir (path)
  local child = node:new { path = path .. "/" }
  table.insert(self.dirs, child)
  return child
end

function node:addPage (path)
  table.insert(self.pages, path)
end

function node:addContent (path)
  table.insert(self.contents, path)
end

function node:addGenerator (path)
  table.insert(self.generators, path)
end

function node:sort ()
  table.sort(self.pages)
  table.sort(self.dirs)
  table.sort(self.contents)
  table.sort(self.generators)
end

return node
