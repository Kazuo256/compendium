package = "compendium"
version = "scm-1"
source = {
  url = "https://github.com/kazuo256/compendium/"
}
description = {
  summary = "A static HTML generation tool",
  detailed = [[
WIP
]],
  --homepage = "http://kazuo256.github.io/luxproject/",
  license = "MIT/X11"
}
dependencies = {
  "lua >= 5.3, < 5.4",
  "luafilesystem",
  "markdown",
  "luxproject"
}
build = {
  type = "builtin",
  modules = {
    ["compendium.css"] = "lib/compendium/css.lua",
    ["compendium.html"] = "lib/compendium/html.lua",
    ["compendium.node"] = "lib/compendium/node.lua"
  },
  --copy_directories = { "doc" },
  install = {
    bin = {
      compendium = "bin/compendium.lua"
    }
  }
}
