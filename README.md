# Kontainer
A simple Kirigami GUI for Distrobox

![Kontainer](https://github.com/user-attachments/assets/1273dade-5026-4ffb-b5d1-4f5a332ba0af)

### Installation:

<a href='https://flathub.org/apps/io.github.DenysMb.Kontainer'><img width='240' alt='Download on Flathub' src='https://flathub.org/assets/badges/flathub-badge-en.png'/></a>

### Build instructions

Debug (recommended for development):

```bash
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug
cmake --build build -j
```

Run:

```bash
./build/bin/kontainer
```

Release (optional):

```bash
cmake -S . -B build -DCMAKE_BUILD_TYPE=Release && cmake --build build
```

### Requirements:
Those are required even for Flatpak version:
- Distrobox
- A terminal emulator

### Functionalities:
- Create, delete and upgrade distroboxes;
- Open terminal inside distroboxes;
- Create shortcut for distroboxes;
- Install files inside distroboxes.


### Screenshots

<img width="830" height="658" alt="Screenshot_20251102_123101" src="https://github.com/user-attachments/assets/1399b1e2-1c95-42d0-8d2d-c9aeb8159dca" />
<img width="830" height="658" alt="Screenshot_20251102_123136" src="https://github.com/user-attachments/assets/93cbf483-4b48-4f63-a6e5-efad71416799" />
<img width="830" height="658" alt="Screenshot_20251102_123220" src="https://github.com/user-attachments/assets/827aa8af-976e-43b2-8653-c096d694cf20" />
<img width="830" height="658" alt="Screenshot_20251102_124023" src="https://github.com/user-attachments/assets/4ac20850-79ab-4226-bb92-9383691163fa" />
<img width="730" height="558" alt="Screenshot_20251102_123338" src="https://github.com/user-attachments/assets/799dc5e4-a92a-4f30-ad1e-c98cd719018d" />

> Icon by [@Micro856](https://github.com/Micro856). Thank you for the contribution!
