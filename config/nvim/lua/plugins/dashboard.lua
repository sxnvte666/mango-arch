return {
    'nvimdev/dashboard-nvim',
     event = 'VimEnter',
     config = function()
        require('dashboard').setup {
            theme = 'doom',
              config = {
                header = {}, --your header
                center = {
                  {
                    icon = '  ',
                    desc = 'Open Yazi',
                    desc_hl = 'String',
                    key = 'y',
                    keymap = 'SPC f ',
                    key_hl = 'Number',
                    key_format = ' %s', -- remove default surrounding `[]`
                    action = 'Yazi'
                  },
                  {
                    icon = '  ',
                    desc = 'Telescope find',
                    key = 'f',
                    keymap = 'SPC f ',
                    key_format = ' %s', -- remove default surrounding `[]`
                    action = 'Telescope fd'
                    },
                    {
                      icon = '  ',
                      desc = 'Terminal',
                      key = 't',
                      keymap = 'SPC f ',
                      key_format = ' %s', -- remove default surrounding `[]`
                      action = 'terminal'
                    },
                    {
                      icon = '  ',
                      desc = 'Telescope old files',
                      key = 'o',
                      keymap = 'SPC f ',
                      key_format = ' %s', -- remove default surrounding `[]`
                      action = 'Telescope oldfiles'
                      },

                },
                footer = {}  --your footer
              }
       }
     end,
     dependencies = { {'nvim-tree/nvim-web-devicons'}}
}
