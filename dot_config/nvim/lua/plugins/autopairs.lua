return {
    'nvim-mini/mini.pairs',
    version = false, -- Always use latest
    config = function()

        require('mini.pairs').setup()


        vim.api.nvim_create_autocmd('FileType', {
            pattern = 'typst',
            callback = function()
           
                local buf = vim.api.nvim_get_current_buf()


                require('mini.pairs').map_buf(buf, 'i', '_', {
                    action = 'closeopen',
                    pair = '__', 

                })

      
                require('mini.pairs').map_buf(buf, 'i', '*', {
                    action = 'closeopen',
                    pair = '**',
                })

                require('mini.pairs').map_buf(buf, 'i', '$', {
                    action = 'closeopen',
                    pair = '$$',
                })

            end,
        })
    end,
}