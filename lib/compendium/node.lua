
local Node = require 'pl.class' ()

function Node:_init(path)
  self.path = path or ""
  self.dirs = {}
  self.pages = {}
  self.contents = {}
  self.generators = {}
end

function Node:eachDir ()
  return ipairs(self.dirs)
end

function Node:eachPage ()
  return ipairs(self.pages)
end

function Node:eachContent ()
  return ipairs(self.contents)
end

function Node:eachGenerator ()
  return ipairs(self.generators)
end

function Node:getDir(idx)
  return self.dirs[idx]
end

function Node:getPage(idx)
  return self.pages[idx]
end

function Node:getContent(idx)
  return self.contents[idx]
end

function Node:getGenerator(idx)
  return self.generators[idx]
end

function Node:addDir (path)
  local child = Node(path .. "/")
  table.insert(self.dirs, child)
  return child
end

function Node:addPage (path)
  table.insert(self.pages, path)
end

function Node:addContent (path)
  table.insert(self.contents, path)
end

function Node:addGenerator (path)
  table.insert(self.generators, path)
end

function Node:sort ()
  table.sort(self.pages)
  table.sort(self.dirs, function (a,b) return a.path < b.path end)
  table.sort(self.contents)
  table.sort(self.generators)
end

return Node

