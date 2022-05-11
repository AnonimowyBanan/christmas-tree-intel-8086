_code segment
assume  cs:_code, ds:_data, ss:_stack

start:  mov     ax,_data
        mov     ds,ax
        mov     ax,_stack
        mov     ss,ax
        mov     sp,offset top
;------------------------------
mov ax,0B800h                           
mov es,ax                               
xor di,di                               

;------------------------------
;-        blank screen        -
;------------------------------
mov ah,0                                
mov al,""                               
mov cx,2000                             
cld                                     
rep stosw                               

;------------------------------
;-           print            -
;------------------------------

xor di,di                               
xor cx,cx                               
mov di,80                               

mov cl,1                                

mov dl,0                                
loop:
        mov bl,cl                       

        mov ah,[att]                    
        mov al,[znak]                   

        loop2:
                mov es:[di],al          
                inc di                  
                mov es:[di],ah          
                inc di                  
                dec bl                  
        jnz loop2

        mov ax,158                      
        sub ax,cx                       
        sub ax,cx
        add di,ax                       
        add cl,2                        

        inc [att]                       
        inc [znak]                      

inc dl                                  
cmp dl,24                               
jle loop                                


;------------------------------
        mov     ah,4ch
        mov     al,0
        int     21h
_code ends

_data segment
        znak db "A"
        att db 1

        ; your data goes here
_data ends

_stack segment stack
        dw      100h dup(0)
top     Label word
_stack ends

end start