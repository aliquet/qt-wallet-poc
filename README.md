# Qt/QML Crypto Wallet Emulator (PoC)

> ⚠️ Demo UI/UX pouze pro prezentaci. **Neukládá reálné klíče, nepodepisuje skutečné transakce.**

## Struktura
- `src/` – C++ backend (`WalletSimulator`) napojený do QML.
- `qml/` – UI v QML (onboarding se seedem, potvrzení transakce).
- `CMakeLists.txt` – build skript pro CMake + Qt6.

## Build (Linux/macOS)
```bash
mkdir build && cd build
cmake .. -DCMAKE_PREFIX_PATH=/path/to/Qt/6.5.0/gcc_64
cmake --build . -j
./qt_wallet_poc
```

## Build (Windows)
- Otevřete `CMakeLists.txt` v **Qt Creatoru**, vyberte kit (MSVC/MinGW) a spusťte **Build & Run**.

## Poznámky
- QML modul se načítá z `qrc:/WalletPoc/qml/Main.qml`.
- Seed slova jsou náhodně volená z krátkého seznamu – **nejde o BIP-39**.
- Transakce i podpis jsou **simulované** (bez práce s klíči).