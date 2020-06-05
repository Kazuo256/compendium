
package = "compendium"
version = "scm-3"
source = {
  url = "https://github.com/lux-archive/compendium"
}
description = {
  summary = "A static HTML generation tool",
  detailed = [[
WIP
]],
  license = "MIT/X11",
  maintainer = "kazuo256@gmail.com"
}
dependencies = {
  "lua >= 5.3",
  "luafilesystem",
  "markdown",
  "penlight"
}
build = {
  type = "builtin",
  install = {
    bin = { "bin/compendium" }
  },
  modules = {
    ["compendium.css"] = "lua/compendium/css.lua",
    ["compendium.html"] = "lua/compendium/html.lua",
    ["compendium.node"] = "lua/compendium/node.lua"
  },
}
