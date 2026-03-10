# 🚀 nvim_installation_centos

Installing modern **Neovim (0.10+)** on CentOS 8/9 shouldn't feel like a boss battle. This script automates the process, fixes EOL mirror issues, and drops you straight into a pre-configured **NvChad** environment.
### 🛠️ What this does

   * **Fixes CentOS 8 Mirrors:** Automatically points broken EOL repos to vault.centos.org.

   * **Deep Cleans:** Wipes old Neovim state/cache/share folders to prevent the dreaded uv is nil error.

   * **Latest Binary:** Grabs the latest stable Neovim x86_64 build.

   * **NvChad Setup:** Clones the starter config so you can start coding immediately.

### ⚡ Quick Start

Download the script to your CentOS machine.

**Make it executable:**  

```Bash  
chmod +x install_nvim.sh  
```
**Run it (Don't use sudo!):**  

```Bash
./install_nvim.sh
```
* **Note:** The script will prompt for *sudo* only when it needs to touch */opt* or install system dependencies.

### ⚠️ Prerequisites

* **Nerd Fonts:** You’ll need a Nerd Font (like JetBrainsMono) installed on your local terminal to see the NvChad icons correctly.

* **Compiler:** The script attempts to install gcc-c++, which is required for Tree-sitter syntax highlighting.

### 🤝 Credits

#### Created by compileandgo (Jayant Kushwaha).  

### Why the "No Sudo" rule?

Running the whole script as sudo would make your *~/.config/nvim* folder owned by the *root* user. That leads to permission errors every time you try to save a file. By running as a normal user, the script keeps your config files owned by you.  

**Happy Coding!**  
