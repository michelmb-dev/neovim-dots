return {

  -- Noice
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })
      table.insert(opts.routes, 1, {
        filter = {
          cond = function()
            return not focused
          end,
        },
        view = "notify_send",
        opts = { stop = false },
      })

      opts.commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })

      opts.presets.lsp_doc_border = true
    end,
  },

  -- animations
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.scroll = {
        enable = false,
      }
    end,
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        -- globalstatus = false,
        theme = "catppuccin",
      },
    },
  },

  -- customize filename
  {
    "b0o/incline.nvim",
    dependencies = {
      "catppuccin",
    },
    event = "BufReadPre",
    priority = 1200,
    config = function()
      local colors = require("catppuccin.palettes").get_palette("mocha")
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = {
              guibg = colors.lavender,
              guifg = colors.base,
            },
            InclineNormalNC = {
              guifg = colors.lavender,
              -- guibg = colors.surface2,
            },
          },
        },
        window = { margin = { vertical = 0, horizontal = 0 } },
        hide = {
          cursorline = true,
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename
          end

          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },

  -- bufferline
  -- https://github.com/akinsho/bufferline.nvim
  {
    "akinsho/bufferline.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "catppuccin",
    },
    after = "catppuccin",
    event = "VeryLazy",
    keys = {
      { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    },
    opts = function()
      local colors = require("catppuccin.palettes").get_palette("mocha")
      return {
        options = {
          mode = "buffers",
          separator_style = "slant",
          show_buffer_close_icons = false,
          show_close_icon = false,
          always_show_bufferline = true,
        },
        highlights = {
          fill = { bg = colors.surface1 },
          background = { bg = colors.surface0 },
          separator = {
            fg = colors.surface1,
            bg = colors.surface0,
          },
          separator_visible = {
            fg = colors.surface1,
            bg = colors.surface2,
          },
          separator_selected = {
            fg = colors.surface1,
            bg = colors.surface2,
          },
          buffer_visible = {
            fg = colors.green,
            bg = colors.surface2,
            bold = true,
            italic = true,
          },
          buffer_selected = {
            fg = colors.lavender,
            bg = colors.surface2,
            bold = true,
            italic = true,
          },
          modified = {
            fg = colors.peach,
            bg = colors.surface0,
          },
          modified_visible = {
            fg = colors.peach,
            bg = colors.surface2,
          },
          modified_selected = {
            fg = colors.green,
            bg = colors.surface2,
          },
        },
      }
    end,
  },
}
