# Win-Scream Hotkey Receiver

This script (`hotkeyreceiver.ps1`) listens for UDP commands and triggers media control hotkeys on Windows computers.

## hotkeyreceiver.ps1

This PowerShell script does the following:

1. Sets up functions to interact with Windows API for sending keyboard events and hiding windows.
2. Listens on UDP port 9999 for incoming commands.
3. Interprets received commands and triggers corresponding media control hotkeys:
   - 'n': Next Track
   - 'p': Previous Track
   - 'P': Play/Pause

The script runs in the background, hiding its window to avoid interfering with the user's desktop.

## Installation

To install the Win-Scream Hotkey Receiver:

1. Ensure both `hotkeyreceiver.ps1` and `install_task.bat` are in the same directory.
2. Run `install_task.bat`
3. Follow any prompts that appear.

After installation, the hotkey receiver will start automatically each time you log in to your Windows account.

## Usage

Once installed, the script will listen for UDP packets on port 9999. Send the appropriate character ('n', 'p', or 'P') to this port to trigger the corresponding media control action.

## Uninstallation

1. Run `uninstall_task.bat`
