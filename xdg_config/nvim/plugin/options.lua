local opt = vim.opt

opt.belloff = "all" -- Turn the bell off completely.
opt.cursorline = true -- Highlight the current line.
opt.hidden = true -- Don't ask to save when changing buffers (i.e. when jumping to a type definition).
opt.hlsearch = true -- Highlight all its matches of previous search pattern (type :noh to remove highlighting).
opt.ignorecase = true -- Ignore case when searching...
opt.incsearch = true -- While searching show where the pattern, as it was typed so far, matches.
opt.joinspaces = false -- No double spaces with join
opt.number = true
opt.relativenumber = true

opt.scrolloff = 10 -- Make it so there are always ten lines below my cursor
opt.sidescrolloff = 8

opt.showcmd = true -- Show (partial) command on the last line of the screen.
opt.showmatch = true -- Show matching brackets when cursor is over one of them.
opt.showmode = true
opt.smartcase = true -- ... unless there is a capital letter in the query.
opt.smartindent = true -- Insert indents automatically

opt.splitbelow = true -- Prefer windows splitting to the bottom.
opt.splitright = true -- Prefer windows splitting to the right.
opt.termguicolors = true            -- True color support
opt.wildmode = {'list', 'longest'}  -- Command-line completion mode
opt.wrap = false                    -- Disable line wrap

-- Helpful related items:
--   1. :center, :left, :right
--   2. gw{motion} - Put cursor back after formatting motion.
--
-- TODO: w, {v, b, l}
opt.formatoptions = opt.formatoptions
  - "a" -- Auto formatting is BAD.
  - "t" -- Don't auto format my code. I got linters for that.
  + "c" -- In general, I like it when comments respect textwidth
  + "q" -- Allow formatting comments w/ gq
  - "o" -- O and o, don't continue comments
  + "r" -- But do continue when pressing enter.
  + "n" -- Indent past the formatlistpat, not underneath it.
  + "j" -- Auto-remove comments if possible.
  - "2" -- I'm not in gradeschool anymore
