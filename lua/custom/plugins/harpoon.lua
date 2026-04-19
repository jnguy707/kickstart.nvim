return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim', -- Ensure Telescope is a dependency
    },

    -- The 'config' function runs after the plugin is installed and loaded
    config = function()
      local harpoon = require 'harpoon'

      -- 1. Initialize Harpoon first (Crucial for avoiding nil errors)
      harpoon:setup {}

      -- 2. Define the Telescope toggle function
      local conf = require('telescope.config').values

      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        -- Iterate through the harpoon list items and collect file paths
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require('telescope.pickers')
          .new({}, {
            prompt_title = 'Harpoon',
            finder = require('telescope.finders').new_table {
              results = file_paths,
            },
            -- Use Telescope's built-in previewer/sorter configurations
            previewer = conf.file_previewer {},
            sorter = conf.generic_sorter {},
          })
          :find()
      end

      -- 3. Set the keymaps using the custom function
      vim.keymap.set('n', '<leader>a', function()
        harpoon:list():add()
      end, { desc = 'Harpoon: Add File' })

      -- Keymap to toggle the custom Telescope Harpoon picker
      vim.keymap.set('n', '<leader>e', function()
        toggle_telescope(harpoon:list())
      end, { desc = 'Harpoon: Open Telescope Picker' })

      -- Keymaps for direct file jumps (using your preferred C-1, C-2, etc.)
      vim.keymap.set('n', '<C-1>', function()
        harpoon:list():select(1)
      end, { desc = 'Harpoon: Select File 1' })
      vim.keymap.set('n', '<C-2>', function()
        harpoon:list():select(2)
      end, { desc = 'Harpoon: Select File 2' })
      vim.keymap.set('n', '<C-3>', function()
        harpoon:list():select(3)
      end, { desc = 'Harpoon: Select File 3' })
      vim.keymap.set('n', '<C-4>', function()
        harpoon:list():select(4)
      end, { desc = 'Harpoon: Select File 4' })
    end,

    -- We can omit the top-level 'keys' table since we defined keymaps in 'config'
    -- but you could move the direct select keymaps back to the 'keys' table if preferred.
  },
}
