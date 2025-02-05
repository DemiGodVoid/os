[org 0x7C00]          ; Boot sector starts at 0x7C00
KERNEL_OFFSET equ 0x1000  

    ; Set up stack
    mov bp, 0x9000
    mov sp, bp

    ; Load kernel from disk
    mov bx, KERNEL_OFFSET  ; Load to memory location 0x1000
    mov dh, 2              ; Load 2 sectors (adjust if needed)
    call load_kernel

    ; Jump to kernel
    jmp KERNEL_OFFSET

load_kernel:
    pusha
    mov ah, 0x02      ; BIOS read sector function
    mov al, dh        ; Number of sectors to read
    mov ch, 0         ; Cylinder 0
    mov dh, 0         ; Head 0
    mov cl, 2         ; Start from sector 2
    int 0x13          ; Call BIOS interrupt
    jc error          ; Check for errors
    popa
    ret

error:
    hlt              ; Halt on error

times 510-($-$$) db 0  ; Pad bootloader to 512 bytes
dw 0xAA55               ; Boot signature
