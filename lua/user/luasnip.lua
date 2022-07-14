local snip_status_ok, ls = pcall(require, "luasnip")
if not snip_status_ok then
  vim.api.nvim_err_writeln "Failed to load luasnip"
  return
end

-- some shorthands...
local snip = ls.snippet
local node = ls.snippet_node
local indent = ls.indent_snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamic = ls.dynamic_node

local types = require('luasnip.util.types')
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta

ls.config.set_config {
  history = true,

  updateevents = 'TextChanged,TextChangedI',

  enable_autosnippets = true,

  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "<-", "Error"} },
      }
    }
  }
}

local date = function() return {os.date('%Y-%m-%d')} end

ls.add_snippets(nil, {
  all = {
    snip({
        trig = "date",
        namr = "date",
        dscr = "date in the form of yyyy-mm-dd",
    }, {
        func(date, {}),
    }),
  --  snip("ncsl", {
  --     text("class "),
  --     insert(1, "WidgetName"),
  --     text(" extends ConsumerWidget {"),
  --     text("const "),
  --     insert(rep(1), "WidgetName"),
  --     text("({super.key}); "),
  --     text("}"),
  --   }, ""),
  },
  dart = {
    ls.parser.parse_snippet("th", "final theme = AppTheme.of(context);"),
    ls.parser.parse_snippet("loc", "final localizations = context.localizations;"),
    ls.parser.parse_snippet("si", "final screenSize = MediaQuery.of(context).size;"),
    ls.parser.parse_snippet("tor", "//TODO: (@anh): remove before push"),
    snip("csl", fmta("class <> extends ConsumerWidget {\n\tconst <>({super.key});\n\t@override\tWidget build(BuildContext context, WidgetRef ref) {\n\t\treturn Container();\n\t}\n}", { insert(1, "NameWidget"), rep(1)})),
    snip("cpn", fmta("context.pushPageNamed(Routes.<>)", { insert(1, "page")})),
  },
})

-- {
--   "Consumer Stateless": {
--     "scope": "dart",
--     "prefix": "stlessConsumer",
--     "description": "Create a ConsumerStatelessWidget",
--     "body": [
--       "class $1 extends ConsumerWidget {",
--       "\tconst $1({Key? key}) : super(key: key);\n",
--       "\t@override",
--       "\tWidget build(BuildContext context, WidgetRef ref) {",
--       "\t\treturn Container();",
--       "\t}",
--       "}"
--     ]
--   },
--   "Consumer Stateful": {
--     "scope": "dart",
--     "prefix": "stfulConsumer",
--     "description": "Create a ConsumerStatefulWidget",
--     "body": [
--       "class $1 extends ConsumerStatefulWidget {",
--       "\tconst $1({Key? key}) : super(key: key);\n",
--       "\t@override",
--       "\tConsumerState<ConsumerStatefulWidget> createState() => _$1State();",
--       "}\n",
--       "class _$1State extends ConsumerState<$1> {\n",
--       "\t@override",
--       "\tWidget build(BuildContext context) {",
--       "\t\treturn Container();",
--       "\t}",
--       "}"
--     ]
--   }
-- }

-- Reload Snippet
vim.keymap.set( "n", "<leader><leader>l", "<cmd>source ~/.config/nvim/lua/user/lualine.lua<CR>", { silent = true })
