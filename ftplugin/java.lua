local config = {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

    
    '-jar', '/Users/stjepan.obrankovic/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar',
    '-configuration', '/Users/stjepan.obrankovic/.local/share/nvim/mason/packages/jdtls/config_mac/config.ini',
    '-data', '/Users/stjepan.obrankovic/code/jdtls/java'
  },

  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),

  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive"
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      format = {
        enabled = true,
        --[[
        settings = {
          url = vim.fn.stdpath "config" .. "/lang-servers/intellij-java-google-style.xml",
          profile = "GoogleStyle",
        },
        ]]--
      },
      signatureHelp = { enabled = true },
      contentProvider = { preferred = 'fernflower' },

    }
  }
}

print("Java FT plugin code executed")
require('jdtls').start_or_attach(config)
