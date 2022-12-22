require('neotest').setup({
  adapters = {
    require('neotest-dart') {
      command = 'flutter',
      use_lsp = true -- When set Flutter outline information is used when constructing test name.
    },
  }
})
