local snip_status_ok, ls = pcall(require, "luasnip")
if not snip_status_ok then
  vim.api.nvim_err_writeln "Failed to load luasnip"
  return
end

-- some shorthands...
local snip = ls.snippet
--[[ local node = ls.snippet_node ]]
--[[ local indent = ls.indent_snippet_node ]]
--[[ local text = ls.text_node ]]
local insert = ls.insert_node
local func = ls.function_node
--[[ local choice = ls.choice_node ]]
--[[ local dynamic = ls.dynamic_node ]]

local types = require('luasnip.util.types')
local rep = require("luasnip.extras").rep
--[[ local fmt = require("luasnip.extras.fmt").fmt ]]
local fmta = require("luasnip.extras.fmt").fmta

ls.config.set_config {
  history = true,

  updateevents = 'TextChanged,TextChangedI',

  enable_autosnippets = true,

  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "<-", "Error" } },
      }
    }
  }
}

local date = function() return { os.date('%Y-%m-%d') } end

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
    ls.parser.parse_snippet("ath", "final theme = AppTheme.of(context);"),
    ls.parser.parse_snippet("_th", "final theme = AppTheme.of(context);"),
    ls.parser.parse_snippet("ssi", "final screenSize = MediaQuery.of(context).size;"),
    ls.parser.parse_snippet("_si", "final screenSize = MediaQuery.of(context).size;"),
    ls.parser.parse_snippet("tda", "//TODO(@anh): "),
    ls.parser.parse_snippet("tdr", "//FIXME (@anh): remove before push"),
    ls.parser.parse_snippet("tdn", "//TODO(@anh): implement on next mr"),
    ls.parser.parse_snippet("tiu", "// ignore: unused-code"),

    ls.parser.parse_snippet("_bs4", "BricksSizes.s4"),
    ls.parser.parse_snippet("_bs8", "BricksSizes.s8"),
    ls.parser.parse_snippet("_bs12", "BricksSizes.s12"),
    ls.parser.parse_snippet("_bs16", "BricksSizes.s16"),
    ls.parser.parse_snippet("_bs24", "BricksSizes.s24"),
    ls.parser.parse_snippet("_bs32", "BricksSizes.s32"),
    ls.parser.parse_snippet("_bs40", "BricksSizes.s40"),
    ls.parser.parse_snippet("_bs64", "BricksSizes.s64"),

    ls.parser.parse_snippet(",bs4", "BricksSizes.s4"),
    ls.parser.parse_snippet(",bs8", "BricksSizes.s8"),
    ls.parser.parse_snippet(",bs12", "BricksSizes.s12"),
    ls.parser.parse_snippet(",bs16", "BricksSizes.s16"),
    ls.parser.parse_snippet(",bs24", "BricksSizes.s24"),
    ls.parser.parse_snippet(",bs32", "BricksSizes.s32"),
    ls.parser.parse_snippet(",bs40", "BricksSizes.s40"),
    ls.parser.parse_snippet(",bs64", "BricksSizes.s64"),
    -- Icon Sizes
    ls.parser.parse_snippet("_bis4", "BricksIconSizes.s4"),
    ls.parser.parse_snippet("_bis8", "BricksIconSizes.s8"),
    ls.parser.parse_snippet("_bis12", "BricksIconSizes.s12"),
    ls.parser.parse_snippet("_bis16", "BricksIconSizes.s16"),
    ls.parser.parse_snippet("_bis24", "BricksIconSizes.s24"),
    ls.parser.parse_snippet("_bis32", "BricksIconSizes.s32"),
    ls.parser.parse_snippet("_bis40", "BricksIconSizes.s40"),
    ls.parser.parse_snippet("_bis64", "BricksIconSizes.s64"),

    snip("bsh", fmta("BricksSpacer.h<>(),", { insert(1, "amount") })),
    snip("bsv", fmta("BricksSpacer.v<>(),", { insert(1, "amount") })),
    snip("bss", fmta("BricksSizes.s<>", { insert(1, "amount") })),

    -- Spacer
    ls.parser.parse_snippet("rcon", "ColoredBox(color: Colors.red,);"),
    snip("csl",
      fmta("class <> extends ConsumerWidget {\n\tconst <>({super.key});\n\t@override\tWidget build(BuildContext context, WidgetRef ref) {\n\t\treturn Container();\n\t}\n}"
        , { insert(1, "NameWidget"), rep(1) })),
    snip("cpn", fmta("context.pushPageNamed(Routes.<>)", { insert(1, "page") })),
    snip("logi", fmta("Log.i('<>');", { insert(1, "message") })),
    snip("logd", fmta("Log.d('<>');", { insert(1, "message") })),
    snip("cloc", fmta("context.loc.<>", { insert(1, "key") })),
    snip("_cloc", fmta("context.loc.<>", { insert(1, "key") })),
    snip("textwidget", fmta("Text( context.loc.<>, style: theme.<>,)", { insert(1, "key"), insert(2, "style") })),
  },
})

-- Reload Snippet
--[[ vim.keymap.set("n", "<leader><leader>l", "<cmd>source ~/.config/nvim/lua/user/lualine.lua<CR>", { silent = true }) ]]

--[[ inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr> ]]
--[[ snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr> ]]
-- vim.cmd [[
-- imap <silent><expr> <ENTER> luasnip#expand_or_jumpable() ? <cmd>lua require'luasnip'.jump(-1)<Cr> : '<Enter>'
--
-- snoremap <silent> <Enter> <cmd>lua require('luasnip').jump(1)<Cr>
-- ]]
