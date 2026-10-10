# Neovim setup for remote development

A step-by-step Neovim configuration for developing directly on a remote Linux machine over SSH. Main languages: **Go** and **TypeScript / Angular**.

Included: lazy.nvim, tokyonight, lualine, Treesitter, Telescope, neo-tree, LSP (mason + gopls, ts_ls, angularls), blink.cmp completion, conform.nvim formatting, toggleterm, and avante.nvim (Copilot chat sidebar).

The config itself is distribution independent. It was built and tested on RHEL 9, and the notes at the end of section 2 cover the problems you may hit on older systems.

---

## 1. Requirements

### On the machine you connect from (local)

| Requirement | Why |
|---|---|
| A terminal with **OSC52** support (Windows Terminal, WezTerm, kitty, Alacritty, Ghostty, iTerm2 with clipboard access enabled) | Yanking in Neovim reaches your local clipboard over SSH. Terminals without OSC52 (MobaXterm, macOS Terminal.app, GNOME Terminal) can't copy this way. |
| A **Nerd Font** selected in the terminal, e.g. JetBrainsMono Nerd Font (use the `Mono` variant if the terminal only lists fixed-width fonts) | Icons in neo-tree, lualine and Telescope. Nothing to install on the server. |

### On the machine where Neovim runs (server or workstation)

| Requirement | Used for |
|---|---|
| **Neovim 0.11 or newer** | The config uses `vim.lsp.config`, `vim.lsp.enable` and the nvim-treesitter `main` branch. Developed on 0.12. |
| **git** | Cloning lazy.nvim and all plugins |
| **C compiler** (gcc or clang), **make**, **cmake** | Compiling Treesitter parsers, telescope-fzf-native, avante |
| **curl**, **tar**, **unzip** | Downloads and Mason package extraction |
| **Node.js 22 or newer** and **npm** | TypeScript, Angular, HTML, CSS and JSON language servers, prettier, the Copilot language server |
| **Go** | `gopls`, `goimports`, and building/testing Go projects |
| **Rust toolchain** (`cargo`) | Building avante's native libraries from source, and building the tree-sitter CLI if no usable binary exists |
| **tree-sitter CLI** | nvim-treesitter (`main`) uses it to compile parsers |
| **ripgrep** (`rg`) | Telescope live grep and file finding |
| **fd** | Optional, only to silence a Telescope health warning |
| **OpenSSL development headers**, **pkg-config**, **Perl** with its standard modules (`FindBin`, `IPC::Cmd`, ...) | Building avante from source |
| **Python 3** | The Copilot token script in section 4 |
| **A GitHub Copilot subscription** | Optional, for avante and ghost text |

Install each of them with your distribution's package manager or from the project's official releases, then check:

```bash
nvim --version | head -n 1
node -v && npm -v
go version
cargo --version
tree-sitter --version
rg --version
git --version && cmake --version && cc --version | head -n 1
pkg-config --modversion openssl
perl -MFindBin -e 'print "perl ok\n"'
python3 --version
```

Also make sure these directories are in your `PATH` (for example in `~/.bashrc`):

```bash
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:/usr/local/go/bin:$HOME/go/bin:$PATH"
```

Then install `goimports`, which Go formatting uses:

```bash
go install golang.org/x/tools/cmd/goimports@latest
```

And the Copilot language server (only if you use Copilot):

```bash
npm install -g @github/copilot-language-server
```

Language servers and formatters (`gopls`, `lua_ls`, `ts_ls`, `angularls`, `html`, `cssls`, `jsonls`, `prettier`, `stylua`) are installed by Mason on first start. Check progress with `:Mason`.

### Portability notes

- **Old glibc (e.g. RHEL 9)**: some prebuilt binaries (the npm `tree-sitter-cli`, blink.cmp's native matcher, avante's prebuilt libraries) need a newer glibc and fail with `GLIBC_2.xx not found`. Fixes: build the tree-sitter CLI with `cargo install tree-sitter-cli --locked`, set `fuzzy = { implementation = "lua" }` in `plugins/completion.lua`, and keep `build = "BUILD_FROM_SOURCE=true make"` in `plugins/avante.lua`. On a recent distribution you can use the packaged tree-sitter CLI and drop the other two workarounds.
- **Minimal Perl packages**: some distributions split Perl into small packages, and OpenSSL's build then fails with `Can't locate FindBin.pm`. Install the full Perl core package of your distribution.
- **No outbound internet on the server**: lazy.nvim, Mason, cargo and npm all need to reach GitHub and the package registries. Use a proxy, or download the pieces elsewhere and copy them over.

---

## 2. Config layout

```
~/.config/nvim/
├── init.lua                  # require("config.options"), "config.lazy", "config.lsp"
└── lua/
    ├── config/
    │   ├── options.lua       # options, leader key, clipboard (OSC52), basic keymaps
    │   ├── lazy.lua          # lazy.nvim bootstrap
    │   └── lsp.lua           # diagnostics, LSP keymaps, blink.cmp capabilities
    └── plugins/              # one file per plugin
        ├── colorscheme.lua   # tokyonight
        ├── lualine.lua
        ├── treesitter.lua    # branch main, includes the angular parser
        ├── telescope.lua
        ├── neo-tree.lua
        ├── lsp.lua           # mason, mason-lspconfig, mason-tool-installer
        ├── completion.lua    # blink.cmp
        ├── formatting.lua    # conform.nvim
        ├── toggleterm.lua
        ├── copilot.lua       # copilot.lua (auth + ghost text)
        └── avante.lua        # AI sidebar
```

On the first start, lazy.nvim clones everything and Treesitter compiles its parsers, which takes a few minutes. Always start Neovim from a shell where `which go node cargo tree-sitter` all work, because plugin builds and Mason inherit that environment.

---

## 3. Verifying the install

Run these inside Neovim after the first start:

- `:Lazy` shows all plugins installed with no build errors
- `:checkhealth nvim-treesitter` shows the CLI, the compiler and the parsers as OK
- `:Mason` shows the language servers and tools installed
- `:checkhealth vim.lsp` on a Go or TypeScript file shows the server attached
- `:ConformInfo` shows the formatter for the current buffer as available

Lazy-loaded plugins have no health check until they are loaded, so run `:Lazy load <plugin>` first (for example `:Lazy load telescope.nvim`, then `:checkhealth telescope`).

---

## 4. Avante / Copilot authentication

Avante's Copilot provider reads `~/.config/github-copilot/apps.json`, but the newer `copilot-language-server` stores its login in `auth.db` instead. If avante says `You must setup copilot...` or returns `401 Bad credentials`, create `apps.json` with this script (it runs the GitHub device flow):

```bash
python3 - <<'EOF'
import json, os, time, urllib.request, urllib.parse
cid = "Iv1.b507a08c87ecfe98"
def post(url, data):
    req = urllib.request.Request(url, data=urllib.parse.urlencode(data).encode(),
                                 headers={"Accept": "application/json"})
    return json.load(urllib.request.urlopen(req))

d = post("https://github.com/login/device/code", {"client_id": cid, "scope": "read:user"})
print(f"\nOpen {d['verification_uri']} in your LOCAL browser and enter: {d['user_code']}\n", flush=True)

while True:
    time.sleep(d.get("interval", 5) + 1)
    r = post("https://github.com/login/oauth/access_token", {
        "client_id": cid, "device_code": d["device_code"],
        "grant_type": "urn:ietf:params:oauth:grant-type:device_code"})
    if "access_token" in r:
        break
    if r.get("error") not in ("authorization_pending", "slow_down"):
        raise SystemExit(r)

tok = r["access_token"]
p = os.path.expanduser("~/.config/github-copilot/apps.json")
os.makedirs(os.path.dirname(p), exist_ok=True)
json.dump({f"github.com:{cid}": {"user": "me", "oauth_token": tok, "githubAppId": cid}}, open(p, "w"))
os.chmod(p, 0o600)
print("saved, token length:", len(tok))
EOF
```

Check the token (it should be about 40 characters, and both calls should return 200):

```bash
TOK=$(python3 -c "import json,os;d=json.load(open(os.path.expanduser('~/.config/github-copilot/apps.json')));print(list(d.values())[0]['oauth_token'])")
echo "prefix: ${TOK:0:4}  length: ${#TOK}"
curl -s -o /dev/null -w "api /user: %{http_code}\n" -H "Authorization: Bearer $TOK" https://api.github.com/user
curl -s -o /dev/null -w "copilot token: %{http_code}\n" -H "Authorization: token $TOK" https://api.github.com/copilot_internal/v2/token
```

If the avante native libraries are missing (`missing avante_templates`), build them by hand:

```bash
cd ~/.local/share/nvim/lazy/avante.nvim
BUILD_FROM_SOURCE=true make
ls build/    # avante_templates.so, avante_tokenizers.so, ...
```

Check that your organization allows Copilot Chat and sending code from this machine before using it on company code.

---

## 5. Key commands

`<leader>` is the **Space** key. `<localleader>` is also Space.

### General

| Key | Mode | Action |
|---|---|---|
| `<leader>w` | n | Save |
| `<leader>q` | n | Quit |
| `<Esc>` | n | Clear search highlight |
| `<C-h>` `<C-j>` `<C-k>` `<C-l>` | n | Move between windows |
| `<` / `>` | v | Indent and keep the selection |
| `y` / `yy` | n, v | Yank (also copies to the local clipboard through OSC52) |

### Files and search (Telescope)

| Key | Action |
|---|---|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep in the project |
| `<leader>fw` | Grep the word under the cursor |
| `<leader>fb` | Open buffers |
| `<leader>fr` | Recent files |
| `<leader>fd` | Diagnostics |
| `<leader>fs` | Resume the last search |
| `<leader>fh` | Help tags |
| `<leader>fk` | Search keymaps |
| `<leader>/` | Fuzzy search in the current buffer |

Inside a picker: `<C-n>` / `<C-p>` move, `<C-x>` opens in a horizontal split, `<C-v>` in a vertical split, `<Esc>` closes. Start Neovim from the project directory, not from `/`.

### File explorer (neo-tree)

| Key | Action |
|---|---|
| `<leader>e` | Toggle the explorer |
| `<leader>E` | Reveal the current file in the tree |

Inside the tree: `<CR>` open, `a` add (end with `/` for a directory), `d` delete, `r` rename, `c` copy, `m` move, `H` toggle hidden files, `?` help, `q` close.

### LSP and diagnostics

| Key | Action |
|---|---|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | References |
| `gi` | Implementation |
| `K` | Hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>d` | Line diagnostics (float) |
| `[d` / `]d` | Previous / next diagnostic |

Useful commands: `:Mason`, `:checkhealth vim.lsp`, `:LspLog`, `:lua =vim.lsp.get_clients()`.

### Completion (blink.cmp)

| Key | Action |
|---|---|
| `<C-Space>` | Open the menu manually |
| `<C-n>` / `<C-p>` | Next / previous item |
| `<C-y>` | Accept |
| `<C-e>` | Close |
| `<C-b>` / `<C-f>` | Scroll the documentation |
| `<Tab>` / `<S-Tab>` | Jump between snippet placeholders |

### Formatting (conform.nvim)

| Key | Action |
|---|---|
| `<leader>cf` | Format the buffer (or the visual selection) |

Format on save is on: `goimports` + `gofmt` for Go, `prettier` for TS/JS/HTML/CSS/JSON/YAML/Markdown, `stylua` for Lua. `:ConformInfo` shows which formatter applies to the current buffer. Prettier uses the project's `.prettierrc`.

### Terminal (toggleterm)

| Key | Action |
|---|---|
| `<leader>t` / `<C-\>` | Toggle the bottom terminal |
| `<Esc><Esc>` | Leave terminal mode (then `i` to type again) |

Commands: `:2ToggleTerm` opens a second terminal, `:ToggleTermToggleAll` shows or hides all of them, `:TermExec cmd="go test ./..."` runs a command in the terminal.

### AI sidebar (avante.nvim)

| Key | Action |
|---|---|
| `<leader>aa` | Ask (open the sidebar and send a prompt) |
| `<leader>at` | Toggle the sidebar |
| `<leader>ae` | Edit the selected code (visual mode) |
| `<leader>ar` | Refresh the answer |
| `<leader>an` | New chat |

In the input box, type `@` to add context (`@file`, `@buffers`, `@diagnostics`, `@quickfix`, `@codebase`) and `/` for commands. Proposed changes appear as diffs: `co` keep yours, `ct` take the proposal, `ca` take all, `]x` / `[x` move between hunks. `:AvanteModels` lists the models your plan allows. Keys can differ between versions, so check `:h avante`.

### Ghost text (copilot.lua, optional)

| Key | Action |
|---|---|
| `<M-l>` | Accept the suggestion |
| `<M-]>` / `<M-[>` | Next / previous suggestion |
| `<C-]>` | Dismiss |

---

## 6. Troubleshooting

- **`:checkhealth <plugin>` says "No healthcheck found"**: the plugin is lazy-loaded. Run `:Lazy load <plugin>` first.
- **Parsers fail to compile**: check `which tree-sitter cc` and `:messages`.
- **Plugin build fails**: start Neovim from a shell where `cargo`, `go` and `node` are in `PATH`, then `:Lazy build <plugin>`.
- **`GLIBC_2.xx not found`**: see the portability notes in section 1.
- **Washed-out colors**: `echo $COLORTERM` should print `truecolor`.
- **Copy to the local clipboard doesn't work**: use a terminal with OSC52 support (see section 1).
- **Formatter "unavailable" in `:ConformInfo`**: run `:MasonInstall prettier stylua`.
- **Angular templates have no diagnostics**: run `npm install` in the project, because the language server uses the project's TypeScript version.
- **Update plugins**: `:Lazy sync`.
