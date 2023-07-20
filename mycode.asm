.model small
.stack 100h
.data
controlport equ 0300h ;Port address of control
port
sensorport equ 0301h ;Port address of sensor port
onvalue db 01h ;Value to turn on the pump motor
offvalue db 00h ;Value to turn off the pump motor
.code
main proc
mov ax, @data ;Initialize DS register
mov ds, ax
mov dx, controlport ;Set the control port
mov ax, 0000h ;Initialize the pump motor to off
out dx, ax
mov cx, 05 ;Number of readings to take
mov bx, 00 ;Initialize the counter
loop1:
mov dx, sensorport ;Set the sensor port
in al, dx ;Read the water level
cmp al, 20 ;Check if the water level is high
jle lowlevel ;Jump if the water level is low
mov dx, controlport ;Set the control port
mov al, offvalue ;Turn off the pump motor
out dx, al ;Output the value to the port
jmp endloop
lowlevel:
mov dx, controlport ;Set the control port
mov al, onvalue ;Turn on the pump motor
out dx, al ;Output the value to the port
endloop:
inc bx ;Increment the counter
cmp bx, cx ;Check if the counter has reached
the limit
jl loop1 ;Jump if the counter has not reached the
limit
mov ah, 4ch ;Exit program
int 21h
main endp
end main

