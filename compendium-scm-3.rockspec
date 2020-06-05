
package = "compendium"
version = "scm-3"
source = {
  url = "https://github.com/kazuo256/compendium"
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
    ["compendium.css"] = "lib/compendium/css.lua",
    ["compendium.html"] = "lib/compendium/html.lua",
    ["compendium.node"] = "lib/compendium/node.lua"
  },
}
