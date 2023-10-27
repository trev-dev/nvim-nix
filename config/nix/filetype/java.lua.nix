# vim: ft=lua
{ pkgs }:
''
local jdtls = require("jdtls")
local jdt_language_server = "${pkgs.jdt-language-server}/bin/jdt-language-server"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:gs?/?-?:s?-??:s?-$??")
local workspace_root = os.getenv("HOME") .. "/.cache/jdtls/"
local workspace = workspace_root .. project_name

local function safe_codelens_refresh()
  pcall(vim.lsp.codelens.refresh)
end

local function on_attach(_, buff)
  local dap = require("jdtls.dap")
  local setup = require("jdtls.setup")
  dap.setup_dap_main_class_configs()
  setup.add_commands()
  safe_codelens_refresh()
  jdtls.setup_dap({hotcodereplace = "auto"})
local map = vim.keymap.set local function with_desc(desc)
    return {buffer = buff, desc = desc}
  end
  map("n", "<A-o>", jdtls.organize_imports, with_desc("Organize imports"))
  map("n", "crv", jdtls.extract_variable, with_desc("Extract variable"))
  map("n", "crv", jdtls.extract_variable, with_desc("Extract variable"))
  map("n", "crc", jdtls.extract_constant, with_desc("Extract constant"))
  map("n", "crc", jdtls.extract_constant, with_desc("Extract constant"))
  map("n", "crm", jdtls.extract_method, with_desc("Extract method"))
  map("n", "<localleader>df", jdtls.test_class, with_desc("Debug test class"))
  map("n", "<localleader>dn", jdtls.test_nearest_method,
    with_desc("Debug nearest test method"))
end

local java_debug_jar = "${pkgs.vscode-extensions.vscjava.vscode-java-debug}"
  .. "/share/vscode/extensions/vscjava.vscode-java-debug/server"
  .. "/com.microsoft.java.debug.plugin-*.jar"

local vsc_java_test_jarfiles = "${pkgs.vscode-extensions.vscjava.vscode-java-test}"
  .. "/share/vscode/extensions/vscjava.vscode-java-test/server/*.jar"

local bundles = {
  vim.fn.glob(java_debug_jar, 1)
}

vim.list_extend(
  bundles,
  vim.split(vim.fn.glob(vsc_java_test_jarfiles, 1), "\n")
)

local config = {
  cmd = { jdt_language_server, "-data", workspace },
  init_options = {bundles = bundles},
  on_attach = on_attach,
  root_dir = require("jdtls.setup").find_root({".git", "mvnw", "gradlew", "pom.xml"}),
  settings = {
    java = {
      codeGeneration = {
        toString = {
          template = (
          "''${object.className}"
          .. "{''${member.name()}=''${member.value}, "
          .. "''${otherMembers}}"
          )
        }
      },
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*"
        }
      },
      configuration = {runtimes = {}},
      contentProvider = {preferred = "fernflower"},
      eclipse = {downloadSources = true},
      implementationsCodeLens = {enabled = true},
      inlayHints = {parameterNames = {enabled = "all"}},
      maven = {downloadSources = true},
      references = {includeDecompiledSources = true},
      referencesCodeLens = {enabled = true},
      signatureHelp = {enabled = true},
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999
        }
      }
    }
  }
}

local au = vim.api.nvim_create_autocmd
local augrp = vim.api.nvim_create_augroup

au({"BufWritePost"}, {
  callback = safe_codelens_refresh,
  pattern = {"*.java"}
})

au({"FileType"}, {
  group = augrp("JDTLS", {clear = true}),
  pattern = "java",
  callback = function()
    jdtls.start_or_attach(config)
    vim.opt_local.colorcolumn = "120"
  end
})
''
