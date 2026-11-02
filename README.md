# 🧪 BerzeliusOS (Tall-Form Beaker Edition)

> *"In scientific inquiry, precise glassware yields pure truths."*  
> **BerzeliusOS** is an Arch Linux-based distribution engineered for computational chemistry, laboratory synthesis, and scientific computing, themed around the iconic **Berzelius tall-form beaker** and modern borosilicate laboratory glassware.

---

## 🏛️ The Inspiration: Jöns Jacob Berzelius & The Tall-Form Beaker

**Jöns Jacob Berzelius (1779–1848)** is revered as one of the founding fathers of modern chemistry alongside Lavoisier, Dalton, and Boyle. Among his revolutionary achievements:

* **Modern Chemical Symbolism:** He abolished obscure alchemical glyphs and created the letter-and-number notation used worldwide today (e.g. $\text{H}_2\text{O}$, $\text{CO}_2$, $\text{FeSO}_4$).
* **Elemental Discoveries:** He discovered **Cerium** ($^{58}\text{Ce}$ in 1803), **Selenium** ($^{34}\text{Se}$ in 1817), **Silicon** ($^{14}\text{Si}$ in 1824), **Thorium** ($^{90}\text{Th}$ in 1829), and was the first to isolate **Zirconium** ($^{40}\text{Zr}$).
* **Foundational Chemical Concepts:** He coined the core terms **catalysis**, **isomerism**, **allotrope**, and **polymer**.
* **The Berzelius Beaker:** While standard Griffin beakers are low-form ($H \approx 1.4 \times D$), the **Berzelius beaker** is a tall-form vessel ($H \approx 2 \times D$). Its slender cylindrical proportions minimize exposed surface area, prevent splashing during rigorous titrations, and optimize heating distribution.

---

## 🌟 Distro Highlights

### 🔬 1. Built-in Chemistry & Scientific Suite
* **`kalzium`**: Comprehensive KDE periodic system of elements, isotope calculators, and 3D molecular viewer.
* **`avogadro` & `avogadrolibs`**: Molecular editor, crystallography database, and orbital visualizer.
* **`gnuplot`**: Production plotting tool for spectral and titration curve rendering.
* **`berzelius-calc`**: Custom CLI stoichiometry crucible:
  * Recursive molar mass parsing for complex formulas (e.g. `Th(NO3)4`, `KMnO4`, `Fe2(SO4)3`).
  * Titration stoichiometry solver ($C_1 V_1 = C_2 V_2$).
  * Laboratory solution preparation calculator ($m = M \times V \times C$).
* **`periodic`**: Terminal-native periodic table highlighting elements discovered or isolated by Berzelius.
* **Python Scientific Stack**: `numpy`, `scipy`, `matplotlib`, and `sympy` preconfigured out of the box.

### 💎 2. Borosilicate Glass UI & Visual Identity
* **Picom Compositor**: Tuned with `dual_kawase` background blur, translucent frosted-glass panels, and meniscus curvature.
* **Custom Artwork**: High-resolution 1080p SVG/PNG wallpaper featuring the tall-form beaker with metric graduation markings, refraction highlights, and luminescent reaction fluid.
* **Laboratory Shell**:
  * Colorized `fastfetch` displaying the Berzelius beaker ASCII art and system reagent metrics.
  * Chemistry terminal prompt: `🧪 [Bz] user@berzelius ~/crucible $`.
  * Pre-aliased laboratory commands (`titrate`, `prep`, `calc`, `periodic`, `beaker`).

### ⚡ 3. Pure Rolling Arch Linux Base
* Lightweight, responsive XFCE desktop environment.
* Fast live boot with UEFI (systemd-boot) and BIOS (Syslinux) support.
* Guided installer integration via `archinstall` for installation onto bare-metal or NVMe drives.

---

## 📁 Repository Structure

```
.
├── airootfs/                       # Root overlay files for the live ISO
│   ├── etc/
│   │   ├── os-release              # BerzeliusOS distro metadata
│   │   ├── issue & motd            # Console beaker ASCII banner
│   │   ├── fastfetch/              # Beaker ASCII art & custom metrics
│   │   ├── skel/                   # Default user environment (wallpapers, panel, picom blur)
│   │   │   └── Desktop/            # Launchers for installer, Kalzium, & calculator
│   │   └── systemd/system/         # Autologin and live setup services
│   └── usr/
│       ├── local/bin/
│       │   ├── berzelius-welcome   # Interactive laboratory guide & installer launcher
│       │   ├── berzelius-calc      # Python stoichiometry & molar mass engine
│       │   ├── periodic            # CLI periodic table
│       │   └── berzelius-setup     # Live user initialization script
│       └── local/share/berzelius/  # High-res SVG/PNG wallpapers and beaker icons
├── efiboot/                        # UEFI systemd-boot configuration
├── grub/                           # GRUB boot configuration
├── syslinux/                       # BIOS bootloader configuration with splash art
├── packages.x86_64                 # Curated package manifest
├── pacman.conf                     # Build pacman repository configuration
├── profiledef.sh                   # Archiso profile definition
├── build.sh                        # Automated build & SHA256 checksum script
├── test-qemu.sh                    # QEMU virtual machine test script
└── README.md                       # Documentation
```

---

## 🛠️ How to Build BerzeliusOS

### 1. Prerequisites
On an Arch Linux host (or Arch-based system like CachyOS/EndeavourOS):

```bash
sudo pacman -S --needed archiso git
```

### 2. Synthesize the ISO
Run the automated build script:

```bash
sudo ./build.sh
```

The script will:
1. Validate manifests and script permissions.
2. Invoke `mkarchiso` to resolve Arch packages, build the kernel initramfs, squashfs filesystem, and bootloaders.
3. Output the bootable ISO image to `./out/berzeliusos-<version>-x86_64.iso`.
4. Generate the corresponding `.sha256` cryptographic signature.

---

## 🚀 Testing with QEMU

You can boot the live image immediately in a virtual laboratory using the provided script:

```bash
./test-qemu.sh
```

The runner automatically leverages KVM hardware acceleration, 4GB RAM, and VirtIO graphics for a smooth session.

---

## 💾 Installing BerzeliusOS to Disk

Once booted into the live session:
1. Double-click **Install BerzeliusOS** on the desktop, or
2. Open a terminal and run:
   ```bash
   sudo archinstall
   ```
3. Follow the guided prompts to partition your drive, select timezone, user credentials, and complete the installation.

---

## ⚗️ Quick Command Reference

| Command | Action |
|---|---|
| `berzelius-welcome` | Open the interactive laboratory navigator & installer guide |
| `berzelius-calc <formula>` | Calculate molar mass & elemental breakdown (e.g. `berzelius-calc KMnO4`) |
| `titrate` | Run the beaker titration calculator ($C_1 V_1 = C_2 V_2$) |
| `prep` | Calculate solute mass required to prepare a specific solution |
| `periodic` | View the terminal periodic system highlighting Berzelius elements |
| `kalzium` | Launch the GUI periodic table application |
| `fetch` | Display laboratory hardware reagents via Fastfetch |
