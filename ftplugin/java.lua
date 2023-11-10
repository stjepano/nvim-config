local jdtls_dir = vim.fn.stdpath('data') .. '/mason/packages/jdtls'
local jdtls_config_dir = jdtls_dir .. '/config_mac_arm/'
local plugins_dir = jdtls_dir .. '/plugins'
local path_to_jar = plugins_dir .. '/org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar'
local root_markers = {'.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'}
local root_dir = require('jdtls.setup').find_root(root_markers)
local java_candidates_dir = '/Users/stjepan.obrankovic/.sdkman/candidates/java/'
if root_dir == "" then
  return
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath('data') .. '/site/java/workspace-root/' .. project_name
os.execute('mkdir -p ' .. workspace_dir)

local jdtls_start_cmd = {
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

    '-jar', path_to_jar,
    '-configuration', jdtls_config_dir,
    '-data', workspace_dir,
}

--[[
print("Super duper")
local function table_to_string(tbl)
    local result = "{"
    for k, v in pairs(tbl) do
        -- Check the key type (ignore any numerical keys - assume its an array)
        if type(k) == "string" then
            result = result.."[\""..k.."\"]".."="
        end

        -- Check the value type
        if type(v) == "table" then
            result = result..table_to_string(v)
        elseif type(v) == "boolean" then
            result = result..tostring(v)
        else
            result = result .. v
        end
        result = result.." "
    end
    -- Remove leading commas from the result
    if result ~= "" then
        result = result:sub(1, result:len()-1)
    end
    return result.."}"
end
print("Start command", table_to_string(jdtls_start_cmd))
]]--


local config = {
  cmd = jdtls_start_cmd,

  root_dir = root_dir,

  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  settings = {
    java = {
      eclipse = {
        downloadSources = true,
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
        settings = {
          url = vim.fn.stdpath "config" .. "/lang-servers/intellij-java-google-style.xml",
          profile = "GoogleStyle",
        },
      },
      import = {
        gradle = {
          enabled = true,
          wrapper = {
            enabled = true
          }
        }
      },
      signatureHelp = { enabled = true },
      contentProvider = { preferred = 'fernflower' },
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*"
        },
        filteredTypes = {
          "com.sun.*",
          "io.micrometer.shaded.*",
          "java.awt.*",
          "jdk.*", "sun.*",
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
        },
        hashCodeEquals = {
          useJava7Objects = true,
        },
        useBlocks = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
        runtimes = {
          {
            name = "JavaSE-11",
            path = java_candidates_dir .. "11.0.21.fx-zulu",
          },
          {
            name = "JavaSE-17",
            path = java_candidates_dir .. "17.0.9.fx-zulu",
          },
          {
            name = "JavaSE-1.8",
            path = java_candidates_dir .. "8.0.392.fx-zulu"
          },
        }
      },
    },
  }
}

require('jdtls').start_or_attach(config)
