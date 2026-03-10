# umao-cursor-switcher

Cursor theme switcher for [UmaOS](https://github.com/pod32g/umaos). Pick from 24 Uma Musume character cursor packs via a Qt6/QML GUI.

![Qt6/QML](https://img.shields.io/badge/Qt6-QML-green) ![Python](https://img.shields.io/badge/Python-3.10+-blue) ![Arch](https://img.shields.io/badge/Arch_Linux-pacman-1793d1)

## Cursor Themes

All 24 pixloen cursor packs are bundled and installed automatically:

Agnes Digital, Belno Light, Daiwa Scarlet, Dream Journey, El Condor Pasa, Gold Ship, Haru Urara, Kitasan Black, Manhattan Cafe, Matikanetannhauser, Mayano Top Gun, Meisho Doto, Mejiro McQueen, Nice Nature, Oguri Cap, Rice Shower, Sakura Bakushin O, Silence Suzuka, Special Week, Symboli Rudolf, T.M. Opera O, Tamamo Cross, Tokai Teio, Vodka

## How it works

1. Launch the app — discovers installed `pixloen-*` themes in `/usr/share/icons`
2. Select a character cursor from the list (current theme is marked "Active")
3. Click **Apply** — updates KDE, GTK, and X11 cursor configs instantly
4. KWin is reconfigured automatically; log out/in if needed for full effect

## Architecture

- **Python backend** (`umao-cursor-switcher`) — PyQt6 QObject exposing theme list and apply slot to QML
- **QML frontend** (`qml/`) — PickerScreen (radio list), DoneScreen (confirmation), Theme singleton (UmaOS design tokens)
- **Fallback chain** — PyQt6 QML GUI → kdialog → text mode, depending on available display server and packages
- **Cursor archives** (`cursors/`) — 24 pixloen `.tar.gz` packs, extracted during package build

## Building

```bash
makepkg -si
```

Or install as part of UmaOS via the `custom-pkgs/umao-cursor-switcher/PKGBUILD` in the main [umaos](https://github.com/pod32g/umaos) repo.

## Dependencies

- `python` (3.10+)
- `python-pyqt6`
- `qt6-declarative`
- Optional: `kdialog` (fallback GUI)

## License

MIT
