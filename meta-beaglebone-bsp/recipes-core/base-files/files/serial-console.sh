# Fix backspace handling on serial console (DEL 0x7F, as sent by most terminal emulators)
stty erase ^?
