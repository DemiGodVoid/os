void kernel_main() {
    char *video_memory = (char *)0xB8000; // VGA text buffer

    // Print "Hello, World!" to the screen
    const char *message = "Hello, World!";
    int i = 0;
    while (message[i] != 0) {
        video_memory[i * 2] = message[i];  // Character
        video_memory[i * 2 + 1] = 0x07;   // Color attribute (white on black)
        i++;
    }

    while (1);  // Infinite loop to prevent reboot
}
