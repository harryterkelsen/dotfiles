return {
  {
    "nvim-telescope/telescope-project.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      extensions = {
        project = {
          base_dirs = {
            "~/Projects/",
          },
          sync_with_nvim_tree = true,
        },
      },
    },
    keys = {
      {
        "<leader>fp",
        function()
          require("telescope").extensions.project.project({})
        end,
        desc = "Find Project",
      },
    },
  },
}
