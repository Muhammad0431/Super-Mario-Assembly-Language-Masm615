
;/////////////////////////// i190431 and i170021////////////////////////////
.model small
.stack 4096
.data

;messages used by the start and endscreen functions
message byte "YOU HAVE COMPLETED LEVEL 1!","$"
message2 byte "WELCOME TO THE GAME PRESS ENTER KEY TO CONTINUE","$"
message3 byte "YOU HAVE COMPLETED LEVEL 2!","$"
message4 byte "CONGRATULATIONS! YOU WON!","$"
message5 byte "YOU LOST","$"
scoremessage byte "Score:","S"
pressenter byte "Press Enter for next level","$"

level word 0

marioLives word 3 			;number of lives of mario, starts with 3
marioState word 1 			;if this bool is 1 mario is alive if 0 mario is dead
y1 word 400
x1 word 260
marioy word 165				;coordinates to move mario
mariox word 20
maxx word 0 				;max point of babloo
maxy word 0 				;max point of babloo
midx word 0					;midpoint of babloo
midy word 0					;midpoint of babloo
groundY word 195
marioSpeed word 4			;speed of babloo


tempxStart word 0
tempxEnd word 0
tempy word 0

_length word 0				; of any rectangle
_width word 0				; of any rectangle

color word 0

ph1 word 25
px1 word 60					;pillar1 coordinates
py1 word 150

ph2 word 15
px2 word 150				;pillar2
py2 word 160

ph3 word 15
px3 word 240				;pillar3
py3 word 160 

cx1 word 250				;first coins coordinates
cy1 word 130	
coin1CollisionBool word 1	;checks collision of coin1, 0 for no collision and coin displayed, 1 for yes collision and coin not displayed

cx2 word 75					;second coins coordinates
cy2 word 130	
coin2CollisionBool word 1	;checks collision of coin2, 0 for no collision and coin displayed, 1 for yes collision and coin not displayed

ex1 word 95					;enemy coordinates
ey1 word 175
enemy1MoveBool word 0		;0 to move right, 1 to move left----will be 0 initially as enemy will first move right
enemy1Collision word 1		;0 means there is no collision, 1 means there has been a collision, will control display of enemy and death of mario

ex2 word 195				;enemy coordinates
ey2 word 175
enemy2MoveBool word 0		;0 to move right, 1 to move left----will be 0 initially as enemy will first move right
enemy2Collision word 1		;0 means there is no collision, 1 means there has been a collision, will control display of enemy and death of mario

hx1 word 100					;coordiantes for life perk
hy1 word 130
heartCollisionBool word 0 	;0 means no collision and must be displayed, vice versa for 1
tx1 word ?

bx1 word 280           		;coordinates for drawing the boss
by1 word 40	

fx1 word 290             ;coordinates of the flame
fy1 word 66

dcx1 word 300            ;coordinates for the castle
dcy1 word 170

store word 0
temp word 0					;for temporary values
score word 0				;score incremented for certain actions

timeCoin1 word 10					;for randomizing collectibles
timeCoin2 word 120
timeHeart word 220

enemy1 byte 256 DUP(36h)	;enemy array for drawing
coin1 byte 224 DUP(36h)		;coin array for drawing

DrawBossarr byte 36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,0Fh,36h,36h,0Fh,36h,36h,36h,36h,0Fh,0Fh,36h,06h,36h
            byte 36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,0Fh,06h,36h,0Fh,0Fh,06h,01h,01h,01h,0Fh,0Fh,0Fh,06h,36h
            byte 36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,0Fh,06h,06h,01h,01h,01h,0Fh,0Fh,06h,06h,01h,01h,0Fh,0Fh,0Fh,06h,36h
			byte 36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,0Fh,0Fh,01h,0Fh,0Fh,06h,01h,01h,01h,01h,01h,01h,01h,01h,01h,0Fh,0Fh,06h,06h,36h
			byte 36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,01h,01h,01h,0Fh,0Fh,01h,01h,01h,01h,01h,01h,0Eh,01h,01h,01h,0Fh,0Fh,0Fh,0Fh,36h
			byte 36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,0Fh,06h,06h,01h,01h,01h,01h,01h,01h,0Fh,06h,06h,01h,0Fh,06h,01h,0Fh,0Fh,06h,0Fh,0Fh,36h
			byte 36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,0Fh,0Fh,06h,01h,01h,01h,01h,01h,01h,0Fh,0Fh,06h,01h,01h,01h,01h,0Fh,0Fh,06h,06h,0Fh,06h
			byte 36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,0Fh,0Fh,01h,01h,01h,01h,01h,01h,01h,0Fh,0Fh,01h,01h,01h,01h,01h,0Fh,01h,06h,06h,06h,06h
			byte 36h,36h,36h,36h,36h,36h,36h,36h,36h,01h,01h,01h,01h,0Fh,06h,06h,01h,01h,01h,01h,01h,01h,01h,01h,0Fh,0Fh,01h,06h,0Fh,0Fh,06h,06h
			byte 36h,36h,36h,36h,36h,36h,36h,36h,01h,06h,01h,01h,01h,0Fh,0Fh,06h,01h,01h,01h,01h,01h,01h,01h,0Fh,0Fh,01h,01h,01h,0Fh,0Fh,06h,06h
			byte 36h,36h,36h,36h,36h,36h,36h,36h,36h,06h,06h,06h,01h,01h,0Fh,0Fh,01h,01h,01h,01h,0Fh,0Fh,0Fh,0Fh,0Fh,01h,01h,01h,01h,06h,0Fh,06h
			byte 36h,36h,36h,36h,36h,36h,36h,36h,0Fh,0Fh,0Fh,06h,01h,01h,01h,01h,01h,0Fh,0Fh,0Fh,0Fh,0Fh,0Fh,01h,01h,01h,01h,01h,06h,06h,06h,06h			
			byte 36h,36h,36h,36h,36h,36h,36h,36h,01h,0Fh,0Fh,0Fh,01h,01h,01h,01h,0Fh,0Fh,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,06h,06h,06h,06h
			byte 36h,36h,36h,36h,36h,36h,36h,36h,01h,01h,0Fh,01h,01h,01h,01h,0Fh,0Fh,06h,06h,01h,01h,01h,01h,01h,01h,01h,01h,36h,36h,06h,0Fh,0Fh
			byte 36h,36h,36h,36h,36h,36h,36h,36h,01h,01h,01h,01h,01h,01h,01h,0Fh,06h,06h,06h,00h,0Fh,01h,01h,01h,01h,01h,36h,36h,36h,36h,0Fh,0Fh
			byte 36h,36h,36h,36h,36h,36h,36h,36h,0Fh,0Fh,0Fh,0Fh,01h,01h,01h,0Fh,06h,06h,0Fh,00h,06h,01h,01h,01h,01h,36h,36h,36h,36h,36h,36h,0Fh
			byte 36h,36h,36h,36h,36h,36h,36h,36h,0Fh,0Fh,0Fh,0Fh,0Fh,01h,01h,0Fh,06h,00h,00h,06h,06h,06h,06h,36h,36h,36h,36h,36h,36h,36h,36h,36h
			byte 0Fh,36h,36h,36h,36h,01h,01h,01h,01h,01h,01h,0Fh,0Fh,0Fh,0Fh,0Fh,01h,0Fh,06h,06h,06h,06h,06h,06h,36h,36h,36h,36h,36h,36h,36h,36h
			byte 0Fh,06h,06h,36h,36h,01h,01h,01h,01h,01h,01h,01h,0Fh,0Fh,0Fh,0Fh,01h,36h,06h,06h,06h,06h,06h,06h,36h,36h,36h,36h,36h,36h,36h,36h
			byte 0Fh,0Fh,06h,06h,01h,01h,01h,01h,01h,01h,01h,01h,01h,0Fh,0Fh,01h,36h,36h,06h,06h,06h,06h,06h,06h,36h,36h,36h,36h,36h,36h,36h,36h
			byte 36h,0Fh,0Fh,06h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,01h,36h,06h,00h,00h,06h,06h,06h,0Fh,36h,36h,36h,36h,36h,36h,36h,36h
			byte 36h,0Fh,0Fh,01h,01h,01h,01h,06h,06h,06h,06h,06h,06h,01h,01h,36h,36h,06h,0Fh,00h,00h,0h,0h,00h,36h,36h,36h,36h,36h,36h,36h,36h
			byte 36h,01h,01h,01h,01h,01h,06h,06h,01h,01h,0Fh,06h,06h,06h,06h,36h,36h,06h,06h,06h,0Fh,00h,0Fh,36h,36h,36h,36h,36h,36h,36h,36h,36h
			byte 36h,01h,01h,01h,01h,01h,01h,01h,06h,0Fh,01h,01h,01h,0Fh,06h,06h,06h,36h,36h,06h,06h,06h,06h,36h,36h,36h,36h,36h,36h,36h,36h,36h
			byte 36h,36h,01h,01h,01h,01h,01h,01h,01h,06h,01h,01h,36h,36h,36h,06h,06h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h
			byte 36h,36h,36h,36h,0Fh,0Fh,0Fh,01h,01h,06h,01h,01h,36h,36h,36h,06h,06h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h
			byte 36h,36h,36h,36h,0Fh,0Fh,0Fh,01h,06h,06h,0Fh,36h,36h,36h,0Fh,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h
			byte 36h,36h,36h,36h,01h,01h,0Fh,0Fh,01h,06h,01h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h
			byte 36h,36h,36h,36h,36h,01h,0Fh,06h,06h,06h,0Fh,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h
			byte 36h,36h,36h,36h,36h,06h,06h,06h,06h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h
			byte 36h,36h,36h,36h,06h,00h,06h,06h,06h,0Fh,0Fh,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h			
			byte 36h,36h,36h,36h,36h,06h,06h,06h,0Fh,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h,36h

			;the array below is for drawing the flame 
DrawFlamearr byte 36h,36h,36h,40h,36h,36h,36h
			 byte 36h,36h,40h,0Eh,40h,36h,36h
			 byte 36h,40h,0Eh,04h,0Fh,40h,36h
			 byte 40h,0Eh,04h,00h,04h,0Fh,40h
			 byte 40h,0Eh,04h,00h,04h,0Fh,40h
			 byte 40h,0Eh,04h,04h,04h,0Fh,40h
             byte 40h,0Eh,0Eh,0Eh,0Eh,0Fh,40h
			 byte 36h,40h,40h,40h,40h,40h,36h
			;the array is used for drawing castle in level 3
DrawCastlearr byte  36h,36h,36h,36h,0h,36h,36h,36h,36h,36h,36h,0h,04h,04h,04h,04h
			 byte  36h,36h,36h,36h,0h,36h,36h,36h,36h,36h,36h,0h,04h,04h,36h,36h
			 byte  36h,36h,36h,0h,04h,0h,36h,36h,36h,36h,36h,0h,36h,36h,36h,36h
			 byte  36h,36h,0h,04h,04h,04h,0h,0h,36h,0h,36h,0h,0h,0h,0h,36h
			 byte  36h,36h,0h,04h,04h,04h,0h,08h,0h,08h,0h,08h,0h,08h,0h,36h				 
			 byte  36h,36h,0h,04h,04h,04h,0h,08h,08h,08h,08h,08h,08h,08h,0h,36h			  
			 byte  36h,36h,0h,08h,08h,08h,0h,08h,0h,08h,0h,08h,0h,08h,0h,36h	
			 byte  36h,36h,0h,08h,0h,08h,0h,08h,08h,08h,08h,08h,08h,08h,0h,36h
			 byte  36h,36h,0h,08h,08h,08h,0h,04h,04h,04h,04h,04h,04h,04h,0h,36h
			 byte  36h,0h,0h,0h,08h,0h,0h,08h,08h,0h,0h,08h,08h,08h,0h,36h
			 byte  36h,0h,04h,0h,0h,08h,08h,0h,0h,08h,08h,0h,08h,08h,0h,36h
			 byte  0h,04h,04h,04h,0h,08h,08h,08h,08h,08h,08h,0h,08h,08h,0h,36h
			 byte  0h,04h,04h,04h,0h,08h,0h,08h,08h,0h,08h,0h,08h,0h,0h,36h
			 byte  0h,0h,0h,0h,0h,08h,0h,08h,08h,0h,08h,0h,0h,04h,0h,0h
			 byte  0h,08h,08h,08h,0h,08h,08h,08h,08h,08h,08h,0h,04h,04h,04h,0h
			 byte  0h,08h,0h,0h,0h,08h,0h,0h,0h,0h,08h,0h,0h,0h,04h,0h
			 byte  0h,08h,0h,08h,0h,0h,0h,08h,08h,0h,0h,0h,08h,0h,04h,0h
			 byte  0h,08h,0h,08h,08h,08h,08h,08h,08h,08h,08h,08h,08h,0h,04h,0h
			 byte  0h,08h,0h,08h,08h,08h,08h,0h,0h,08h,08h,08h,08h,0h,0h,0h
			 byte  0h,08h,0h,08h,08h,08h,0h,0h,0h,0h,08h,08h,08h,0h,08h,0h
			 byte  0h,08h,0h,08h,08h,08h,0h,0h,0h,0h,08h,08h,08h,0h,08h,0h
			 byte  0h,08h,0h,08h,08h,08h,0h,0h,0h,0h,08h,08h,08h,0h,08h,0h
			 byte  0h,08h,0h,08h,08h,08h,0h,0h,0h,0h,08h,08h,08h,0h,08h,0h
			 byte  0h,08h,0h,08h,08h,08h,0h,0h,0h,0h,08h,08h,08h,0h,08h,0h
			 byte  0h,0h,0h,0h,0h,0h,0h,0h,0h,0h,0h,0h,0h,0h,0h,0h	
			 
DrawHeartarr byte 36h,00h,00h,00h,00h,00h,36h,36h,00h,00h,00h,00h,00h,36h
            byte 00h,00h,04h,04h,04h,00h,36h,36h,00h,04h,04h,04h,00h,00h
			byte 00h,04h,0Fh,0Fh,04h,04h,00h,00h,04h,04h,04h,04h,04h,00h
			byte 00h,04h,0Fh,04h,04h,04h,04h,04h,04h,04h,04h,04h,04h,00h
			byte 00h,04h,04h,04h,04h,04h,04h,04h,04h,04h,04h,04h,04h,00h
			byte 00h,04h,04h,04h,04h,04h,04h,04h,04h,04h,04h,04h,04h,00h
			byte 00h,00h,04h,04h,04h,04h,04h,04h,04h,04h,04h,04h,00h,00h
			byte 36h,00h,00h,04h,04h,04h,04h,04h,04h,04h,04h,00h,00h,36h
			byte 36h,36h,00h,00h,04h,04h,04h,04h,04h,04h,00h,00h,36h,36h
			byte 36h,36h,36h,00h,00h,04h,04h,04h,04h,00h,00h,36h,36h,36h
			byte 36h,36h,36h,36h,00h,00h,04h,04h,00h,00h,36h,36h,36h,36h
			byte 36h,36h,36h,36h,36h,00h,00h,00h,00h,36h,36h,36h,36h,36h


.code
main proc
mov ax,@data
mov ds,ax

;video mode set/clear screen
mov ah,0
mov al,13h
int 10h

; ;timer set
mov cx,0000h
mov dx,0ffffh
mov ah,86h
int 15h

call fillCoinArray
call fillEnemyArray

	;for random collectibles
	push ax
	mov ax,timeCoin1
	mov cx1,ax
	mov ax,timeCoin2
	mov hx1,ax
	mov ax,timeHeart
	mov cx2,ax
	pop ax

level1:
    cmp marioLives,0
	jne game_ended1
	; call endscreen4
	jmp level3End ;game ends over there
	game_ended1:
	;displays the whole screen with all objects
	call displayScreen
	
	;movement done here
	mov ah,01
	int 16h
	jnz _move
	jmp skips
	_move:
		;checking which key pressed
		mov ah,00
		int 16h
		cmp ah,01h				;if esc key pressed game ended
		je _gameEnd
		push ax
		cmp ah,4dh;right key pressed
		jne decrement
		
		;checking if pillar ahead using pixel colors
		mov bh,0
		mov cx,maxx
		inc cx
		mov dx,marioy
		inc dx
		mov ah,0dh
		int 10h
		cmp al,36h              ;checking colour ahead
		jne decrement
		add mariox,4			;speed
		call comeDown           ;mario will eventually come down if on pillar
		decrement:
			pop ax
			push ax
			cmp ah,4bh
			jne up
			
			;checking if pillar behind using pixel colors
			mov bh,0
			mov cx,mariox
			dec cx
			mov dx,marioy
			inc dx
			mov ah,0dh
			int 10h
			cmp al,36h
			jne up
			sub mariox,4			;speed
			call comeDown           ;keeps on reducing marios y till ground is reached
	up: 
		pop ax
		cmp ah,48h
		jne skips
		call jump
		
skips:
	call randomize
	cmp maxx,300
	jl level1


call endscreen
level1End::
start01:

mov ah,01
int 16h
jnz start12
start12:
	mov ah,0
	int 16h
	cmp ah,1ch
	jne start11
	jmp start21
start11:
	cmp ah,2dh
	jne start01

;video mode set/clear screen
mov ah,0
mov al,13h
int 10h


start21:
	;enemy, heart and coin checks
	mov heartCollisionBool,0
	mov enemy1Collision,0
	mov enemy2Collision,0
	mov coin1CollisionBool,0
	mov coin2CollisionBool,0
	
	;random collectibles
	push ax
	mov ax,timeCoin1
	mov cx1,ax
	mov ax,timeCoin2
	mov cx2,ax
	mov ax,timeHeart
	mov hx1,ax
	pop ax
	
	;mario moved at start
	mov dx,165
	mov marioy,dx			;coordinates to move mario
	mov dx,20
	mov mariox,dx
	mov dx,2
	mov level,dx
level2:
    cmp marioLives,0
	jne game_ended2
	;call endscreen4
	jmp level3End
	game_ended2:
	;displays the whole screen with all objects
	call displayScreen
	
	;movement done here
	mov ah,01
	int 16h
	jnz _move2
	jmp skips2
	_move2:
		;checking which key pressed
		mov ah,00
		int 16h
		cmp ah,01h				;if esc key pressed game ended
		je _gameEnd
		push ax
		cmp ah,4dh
		jne decrement2
		
		;checking if pillar ahead using pixel colors
		mov bh,0
		mov cx,maxx
		inc cx
		mov dx,marioy
		inc dx
		mov ah,0dh
		int 10h
		cmp al,36h
		jne decrement2
		add mariox,4			;speed
		call comeDown
		decrement2:
			pop ax
			push ax
			cmp ah,4bh
			jne up2
			
			;checking if pillar behind using pixel colors
			mov bh,0
			mov cx,mariox
			dec cx
			mov dx,marioy
			inc dx
			mov ah,0dh
			int 10h
			cmp al,36h
			jne up2
			sub mariox,4			;speed
			call comeDown
	up2: 
		pop ax
		cmp ah,48h
		jne skips2
		call jump
		
skips2:
	call randomize;
	cmp maxx,300
	jle level2

call endscreen2

level2End::

start03:
	mov ah,01
	int 16h
	jnz start13
start13:
	mov ah,0
	int 16h
	cmp ah,1ch
	jne start113
	jmp start23
start113:
	cmp ah,2dh
	jne start03

	;video mode set/clear screen
	mov ah,0
	mov al,13h
	int 10h

start23:

	;before starting a level all checks are set to zero
	;enemy, heart and coin checks
	mov heartCollisionBool,1
	mov enemy1Collision,0
	mov enemy2Collision,0
	mov coin1CollisionBool,0
	mov coin2CollisionBool,0
	
	;random Collectibles
	push ax
	mov ax,timeCoin1
	mov hx1,ax
	mov ax,timeCoin2
	mov cx2,ax
	mov ax,timeHeart
	mov cx1,ax
	pop ax
	
	mov dx,165
	mov marioy,dx			;coordinates to move mario
	mov dx,20
	mov mariox,dx
	mov dx,3
	mov level,dx
level3:
    cmp marioLives,0
	jne game_ended3
	;call endscreen4
	jmp level3End
	game_ended3:
	;displays the whole screen with all objects
	call displayScreen
	
	;movement done here
	mov ah,01
	int 16h
	jnz _move3
	jmp skips3
	_move3:
		;checking which key pressed
		mov ah,00
		int 16h
		cmp ah,01h				;if esc key pressed game ended
		je level3End
		push ax
		cmp ah,4dh
		jne decrement3
		
		;checking if pillar ahead using pixel colors
		mov bh,0
		mov cx,maxx
		inc cx
		mov dx,marioy
		inc dx
		mov ah,0dh
		int 10h
		cmp al,36h
		jne decrement3
		add mariox,4			;speed
		call comeDown
		decrement3:
			pop ax
			push ax
			cmp ah,4bh
			jne up3
			
			;checking if pillar behind using pixel colors
			mov bh,0
			mov cx,mariox
			dec cx
			mov dx,marioy
			inc dx
			mov ah,0dh
			int 10h
			cmp al,36h
			jne up3
			sub mariox,4			;speed
			call comeDown
	up3: 
		pop ax
		cmp ah,48h
		jne skips3
		call jump
		
skips3:
call randomize;
cmp maxx,300
jle level3

call endscreen3

level3End::

cmp marioLives,0
jne _gameEnd
call endscreen4
_gameEnd::
mov ah,4ch
int 21h


main endp
						;/////////////////////////////////////Movement PROCEDURES/////////////////////////////////////////////;
				

				
jump proc uses cx
	mov cx,15
	up:
		push cx
		
		sub marioy,4							;speed
		call displayScreen
		mov ah,01
		int 16h
		jnz l3
		jmp skips2
		l3:
			;increment in the coordinates
			mov ah,00
			int 16h
			cmp ah,4dh
			jne decrement
			mov temp,ax
			mov bh,0
			mov cx,maxx
			inc cx
			mov dx,midy
			inc dx
			mov ah,0dh
			int 10h
			cmp al,36h;compared with background colour
			jne decrement
			add mariox,4						;speed
			decrement:
				mov temp,ax
				cmp ah,4bh
				jne skips2;up
				mov bh,0
				mov cx,mariox
				sub cx,3
				mov dx,midy
				inc dx
				mov ah,0dh
				int 10h
				cmp al,36h
				jne skips2
				sub mariox,4					;speed
		skips2:
		pop cx
	loop up
	call comeDown
	ret
jump endp

comeDown proc 

pop store
push ax

;checking if pillar below using pixel colors
	down5:
	;code for getting a pixel 
		mov bh,0
		mov cx,midx
		mov dx,maxy
		mov ah,0dh
		int 10h
		cmp al,36h
		je increaseY
	jmp _end
	
increaseY:
	call displayScreen
	mov ah,01
	int 16h
	jnz _moveWhileComingDown
	jmp keyNotPressed
	_moveWhileComingDown:
		;increment in the coordinates
		mov ah,00
		int 16h
		cmp ah,4dh
		jne decrementWhileComingDown
		mov temp,ax
		mov bh,0
		mov cx,maxx
		inc cx
		mov dx,midy
		inc dx
		mov ah,0dh
		int 10h
		cmp al,36h
		jne decrementWhileComingDown
		add mariox,4					;speed
		decrementWhileComingDown:
			cmp ah,4bh
			jne keyNotPressed
			mov bh,0
			mov cx,mariox
			sub cx,3
			mov dx,midy
			inc dx
			mov ah,0dh
			int 10h
			cmp al,36h
			jne keyNotPressed
			sub mariox,4				;speed
			
	keyNotPressed:
		;checking if object not below mario
		mov bh,0
		mov cx,midx
		mov dx,maxy
		inc dx
		mov ah,0dh
		int 10h
		cmp al,36h
		jne _end
		add marioy,4						;speed
	objectBelow:
		jmp down5
_end:
	pop ax
	push store
ret
comeDown endp

coin1Collision proc uses ax bx cx dx
	cmp coin1CollisionBool,1
	je _endCoinCollision
	topCollisionWithMario:
		mov bh,0
		mov cx,cx1
		add cx,7
		mov dx,cy1
		dec dx
		mov ah,0dh
		int 10h
		cmp al,06h
		jne frontCollisionWithMario
		mov coin1CollisionBool,1
		inc score
	frontCollisionWithMario:
		mov bh,0
		mov cx,cx1
		add cx,14
		mov dx,cy1
		;add dx,8
		mov ah,0dh
		int 10h
		cmp al,04h
		jne backCollisionWithMario
		mov coin1CollisionBool,1
		inc score
	backCollisionWithMario:
		mov bh,0
		mov cx,cx1
		dec cx
		mov dx,cy1
		;add dx,8
		mov ah,0dh
		int 10h
		cmp al,04h
		jne _endCoinCollision
		mov coin1CollisionBool,1
		inc score
_endCoinCollision:
ret
coin1Collision endp

coin2Collision proc uses ax bx cx dx
	cmp coin2CollisionBool,1
	je _endCoinCollision
	topCollisionWithMario:
		mov bh,0
		mov cx,cx2
		add cx,7
		mov dx,cy2
		dec dx
		mov ah,0dh
		int 10h
		cmp al,06h
		jne frontCollisionWithMario
		mov coin2CollisionBool,1
		inc score
	frontCollisionWithMario:
		mov bh,0
		mov cx,cx2
		add cx,14
		mov dx,cy2
		;add dx,8
		mov ah,0dh
		int 10h
		cmp al,04h
		jne backCollisionWithMario
		mov coin2CollisionBool,1
		inc score
	backCollisionWithMario:
		mov bh,0
		mov cx,cx2
		dec cx
		mov dx,cy2
		;add dx,8
		mov ah,0dh
		int 10h
		cmp al,04h
		jne _endCoinCollision
		mov coin2CollisionBool,1
		inc score
_endCoinCollision:
;call comeDown
ret
coin2Collision endp

heartCollision proc uses ax bx cx dx
	cmp heartCollisionBool,1
	je _endHeartCollision
	topCollisionWithMario:
		mov bh,0
		mov cx,hx1
		add cx,6
		mov dx,hy1
		dec dx
		mov ah,0dh
		int 10h
		cmp al,06h
		jne frontCollisionWithMario
		mov heartCollisionBool,1
		inc marioLives
		jmp _endHeartCollision
	frontCollisionWithMario:
		mov bh,0
		mov cx,hx1
		add cx,13
		mov dx,hy1
		add dx,7
		mov ah,0dh
		int 10h
		cmp al,04h
		jne backCollisionWithMario
		mov heartCollisionBool,1
		inc marioLives
		jmp _endHeartCollision

	backCollisionWithMario:
		mov bh,0
		mov cx,hx1
		dec cx
		mov dx,hy1
		add dx,7
		mov ah,0dh
		int 10h
		cmp al,04h
		jne _endHeartCollision
		mov heartCollisionBool,1
		inc marioLives
		jmp _endHeartCollision
		
_endHeartCollision:
ret
heartCollision endp

moveEnemy1 proc uses ax bx cx dx
	;when collision detected add check here with bool
	cmp enemy1Collision,1
	je _endMovement
	topCollisionWithMario:
		mov bh,0
		mov cx,ex1
		add cx,8
		mov dx,ey1
		dec dx
		mov ah,0dh
		int 10h
		cmp al,06h                  ;comparing with brown as the enemy's colour is brown
		jne frontCollisionWithMario
		mov enemy1Collision,1
		inc score
		jmp _endMovement

	frontCollisionWithMario:
		mov bh,0
		mov cx,ex1
		add cx,16
		mov dx,ey1
		;add dx,8
		mov ah,0dh
		int 10h
		cmp al,04h
		jne backCollisionWithMario
		
		;mario comes back to original position
		mov marioX,20
		mov marioY,165
		dec marioLives
	
	backCollisionWithMario:
		mov bh,0
		mov cx,ex1
		dec cx
		mov dx,ey1
		;add dx,8
		mov ah,0dh
		int 10h
		cmp al,04h
		jne rightCompare
				
		;mario comes back to original position
		mov marioX,20
		mov marioY,165
		dec marioLives
		
	;these labels are for comparing collision with the pillars
	
	rightCompare:
		mov bh,0
		mov cx,ex1
		add cx,24
		mov dx,ey1
		add dx,8
		mov ah,0dh
		int 10h
		cmp al,02h
		jne leftCompare
		mov enemy1MoveBool,1
	leftCompare:
		mov bh,0
		mov cx,ex1
		dec cx
		mov dx,ey1
		add dx,8
		mov ah,0dh
		int 10h
		cmp al,02h
		jne movingRight
		mov enemy1MoveBool,0
	movingRight:
		cmp enemy1MoveBool,0
		jne movingLeft
		add ex1,2
		jmp _endMovement
	movingLeft:
		cmp enemy1MoveBool,1
		jne _endMovement
		sub ex1,2
		jmp _endMovement
	_endMovement:
		ret
moveEnemy1 endp

moveEnemy2 proc uses ax bx cx dx
	;when collision detected add check here with bool
	cmp enemy2Collision,1
	je _endMovement
	topCollisionWithMario:
		mov bh,0
		mov cx,ex2
		add cx,8
		mov dx,ey2
		dec dx
		mov ah,0dh
		int 10h
		cmp al,06h
		jne frontCollisionWithMario
		mov enemy2Collision,1
		inc score
		jmp _endMovement
	frontCollisionWithMario:
		mov bh,0
		mov cx,ex2
		add cx,16
		mov dx,ey2
		;add dx,8
		mov ah,0dh
		int 10h
		cmp al,04h
		jne backCollisionWithMario
				
		;mario comes back to original position
		mov marioX,20
		mov marioY,165
		dec marioLives
	
	backCollisionWithMario:
		mov bh,0
		mov cx,ex2
		dec cx
		mov dx,ey2
		;add dx,8
		mov ah,0dh
		int 10h
		cmp al,04h
		jne rightCompare
				
		;mario comes back to original position
		mov marioX,20
		mov marioY,165
		dec marioLives
	
	rightCompare:
		mov bh,0
		mov cx,ex2
		add cx,24
		mov dx,ey2
		add dx,8
		mov ah,0dh
		int 10h
		cmp al,02h
		jne leftCompare
		mov enemy2MoveBool,1
	leftCompare:
		mov bh,0
		mov cx,ex2
		sub cx,1
		mov dx,ey2
		add dx,0
		mov ah,0dh
		int 10h
		cmp al,02h
		jne movingRight
		mov enemy2MoveBool,0
	movingRight:
		cmp enemy2MoveBool,0
		jne movingLeft
		add ex2,2
		jmp _endMovement
	movingLeft:
		cmp enemy2MoveBool,1
		jne _endMovement
		sub ex2,2
		jmp _endMovement
	_endMovement:
		ret
moveEnemy2 endp

moveBoss proc uses ax bx cx dx

	cmp bx1,0
	jl movetheboss
	sub bx1,2
	call drawBoss
	movetheboss:
	cmp bx1,0
	jne bossendnotreached
	mov dx,300
	mov bx1,dx
	bossendnotreached:



ret 
moveBoss endp

moveFlame proc uses cx dx bx ax

	cmp fy1,190
	jge dontdrawflame

	add fy1,10
		mov dx,bx1
		add dx,10
		mov fx1,dx
		mov bh,0
		mov cx,fx1
		add cx,3
		mov dx,fy1
		add dx,8
		mov ah,0dh
		int 10h
		cmp al,04h
		jne dontdrawflame
		mov mariox,20
		mov marioy,165
		mov marioState,0
		dec marioLives

	dontdrawflame:

	cmp fy1,190
	jl endthisproc
	mov dx,by1
	add dx,26
	mov fy1,dx

	endthisproc:

call drawFlame
ret 
moveFlame endp

randomize proc

	inc timeCoin1
	inc timeCoin2
	inc timeHeart
	cmp timeCoin1,100
	jne _coin2
	mov timeCoin1,10
	_coin2:
	cmp timeCoin2,200
	jne _heart
	mov timeCoin2,120
	_heart:
	cmp timeHeart,300
	jne _endRandomize
	mov timeHeart,220
_endRandomize:	
ret
randomize endp

						;/////////////////////////////////////DISPLAY PROCEDURES///////////////////////////////////////////////;
printline proc uses ax cx dx bp
	mov bp,sp
	MOV AH, 0ch
	MOV AL, byte ptr color
	MOV CX,tempxEnd 		; end of line in x axis
	MOV DX,tempy 			; y coordinate
	l1:
		dec cx
		INT 10H
	cmp cx,tempxStart 		; starting point of line in x axis
	jne l1
	ret
printline endp

drawRectangle proc uses ax
	mov ax,_width
	add ax,tempy
	outerloop:
	call printline
	inc tempy
	cmp tempy,ax
	jne outerloop
	ret
drawRectangle endp

drawPillar proc uses bp ax
	mov bp,sp
	mov color,02h
	
	;upper half
	mov ax,[bp+8]
	mov tempxStart,ax		;x of object
	mov tempxEnd,ax
	add tempxEnd,40			;length of rectangle = 40
	mov ax,[bp+6]
	mov tempy,ax 			; y of object
	mov ax,20				; width for upper rect
	mov _width,ax
	call drawRectangle
	
	;lower half
	mov ax,[bp+8]
	mov tempxStart,ax		;x of object
	add tempxStart,10
	mov tempxEnd,ax
	add tempxEnd,30 		; basically length=10 of lower rect, x+10 - x+30 
	mov ax, [bp+6]
	mov tempy,ax 			; y of object
	add tempy,20 			;adding value of width here
	mov ax,[bp+10]			; width for upper rect
	mov _width,ax			;actual height of pillar
	call drawRectangle

	ret 6
drawPillar endp

displayScreen proc uses ax
  
	; background/sky
	mov ah, 006h
	mov al, 0
	mov cx, 0
	mov dh, 25
	mov dl, 40
	mov bh, 36h
	int 10h
	;floor formed
	mov ah, 06h
	mov al, 0
	mov cl,0			;x1
	mov ch,24			;y1
	mov dh, 25			;y2
	mov dl, 40			;x2
	mov bh, 06h
	int 10h
	
	cmp level,3
	je dontdrawflag
	;flag formed
	;pole of flag
	mov ah, 06h
	mov al, 0
	mov cl,39
	mov ch,1
	mov dh, 24
	mov dl, 40
	mov bh, 06h
	int 10h
	;flag white part
	mov ah, 06h
	mov al, 0
	mov cl,37
	mov ch,1
	mov dh, 5
	mov dl, 38
	mov bh, 0fh
	int 10h
	;flag green part
	mov ah, 06h
	mov al, 0
	mov cl,32
	mov ch,1
	mov dh, 5
	mov dl, 37
	mov bh, 02h
	int 10h
	dontdrawflag:
	
	;first pillar
	push ph1
	push px1
	push py1
	call drawPillar
	;second pillar
	push ph2
	push px2
	push py2
	call drawPillar
	;third pillar
	push ph3
	push px3
	push py3
	call drawPillar

	;enemy1 formed
	cmp enemy1Collision,0
	jne _drawEnemy2
	push ex1
	push ey1 ;entries asre pushed to make enemy formation generic
	call drawenemy
	
	_drawEnemy2:
	cmp enemy2Collision,0
	jne _drawCoin1
	push ex2
	push ey2
	call drawenemy
	
	
	_drawCoin1:
	;coin1 formed
	cmp coin1CollisionBool,0
	jne _drawCoin2
	push cx1
	push cy1
	call drawCoin
	
	_drawCoin2:
	;coin1 formed
	cmp coin2CollisionBool,0
	jne _life
	push cx2
	push cy2
	call drawCoin
	
	_life:
	cmp heartCollisionBool,0
	jne _babloo
	call drawHeart
	
	
	_babloo:
	;babloo mario
	call drawMario
	
	;Movement for enemy2
	call moveEnemy1
	
	;Movement for enemy2
	call moveEnemy2
	
	;Collision for coin1
	call coin1Collision
	
	;Collision for coin2
	call coin2Collision
	
	;collision for heart
	call heartCollision
	
	;here the boss,flame and Castle will be drawn only for level 3
	cmp level,3
	jne bossnotformed
	call drawCastle
	call moveBoss
	call moveFlame
	bossnotformed:
	
	;int 10h
	;lives displayed at the top of the screen
	push hy1
	push hx1		;pushing these values so values of previous hearts are not lost
	mov cx,marioLives
	cmp cx,0
	je _displayEnd
	mov hx1,2
	mov hy1,10
	displaylives:
	push cx
	call drawHeart
	add hx1,16
	pop cx
	loop displaylives
	pop hx1
	pop hy1
	;Score displayed at the top of the screen
	mov cx,6
	mov si,0
	mov  dl, 0 ;column  
	mov  dh, 0 ;row  
	scoredisplay:
		mov  bh, 0  
		mov  ah, 02h
		int  10h
		mov  al, scoremessage[si]
		mov  bl, 0fh  
		mov  bh, 0    
		mov  ah, 0Eh  
		int  10h
		inc si
		inc dl
	loop scoredisplay
	;mov  dl, 0 ;column  
	mov  dh, 0 ;row  
	mov bh,0
	mov ah,02h
	int 10h
	mov al,byte ptr score
	add al,48
	mov bl,0fh
	mov bh,0
	mov ah,0Eh
	int 10h

	
	;timer set
	mov cx,0000h
	mov dx,0ffffh
	mov ah,86h
	int 15h
	
_displayEnd:	
ret 
displayScreen endp

drawenemy proc uses cx dx bx si ax 
push bp
mov bp,sp
	mov dx,[bp+14];ey1
	mov y1,dx
	mov dx,[bp+16];ex1
	mov x1,dx
	mov temp,dx
	mov si,0
	mov cx,16
	el1:
		push cx
		mov cx,16
		el2:
			push cx
			MOV AH, 0Ch
			MOV AL,enemy1[si]
			mov bh,0
			MOV CX, x1
			MOV DX, y1 
			INT 10H
			add si,1
			inc x1
			pop cx
			loop el2
			pop cx
			mov dx,temp
			mov x1,dx
			inc y1
		loop el1
pop bp
ret 4
drawenemy endp


drawCoin proc uses cx dx bx si ax
push bp
mov bp,sp
	mov dx,[bp+14];cy1
	mov y1,dx
	mov dx,[bp+16];cx1
	mov x1,dx
	mov temp,dx
	mov si,0
	mov cx,15
	el1:
		push cx
		mov cx,14
		el2:
			push cx
			MOV AH, 0Ch
			MOV AL,coin1[si]
			mov bh,0
			MOV CX, x1
			MOV DX, y1 
			INT 10H
			add si,1
			inc x1
			pop cx
			loop el2
			pop cx
			mov dx,temp
			mov x1,dx
			inc y1
		loop el1
pop bp
ret 4
drawCoin endp

drawBoss proc uses cx dx ax
	mov dx,by1
	mov y1,dx
	mov dx,bx1
	mov x1,dx
	mov temp,dx
		mov si,0
		mov cx,32
	bl1:
		push cx
		mov cx,32
		bl2:
			push cx
			MOV AH, 0Ch
			MOV AL,DrawBossarr[si]
			mov bh,0
			MOV CX, x1 ; CX = 10
			MOV DX, y1 ; DX = 20
			INT 10H
			add si,1
			inc x1
			pop cx
		loop bl2
		
		pop cx
		mov dx,temp
		mov x1,dx
		inc y1
	loop bl1

ret 
drawBoss endp

drawFlame proc
    mov dx,fy1
	mov y1,dx
	mov dx,fx1
	mov x1,dx
		mov temp,dx
		mov si,0
		mov cx,8
	fl1:
		push cx
		mov cx,7
		fl2:
			push cx
			MOV AH, 0Ch
			MOV AL,DrawFlamearr[si]
			mov bh,0
			MOV CX, x1 ; CX = 10
			MOV DX, y1 ; DX = 20
			INT 10H
			add si,1
			inc x1
			pop cx
			
		loop fl2
		pop cx
		mov dx,temp
		mov x1,dx
		inc y1
	loop fl1

ret 
drawFlame endp

drawCastle proc
	mov dx,dcy1
	mov y1,dx
	mov dx,dcx1
	mov x1,dx
	mov temp,dx
	mov si,0
	mov cx,24
	dcl1:
	push cx
	mov cx,16
		dcl2:
			push cx
			MOV AH, 0Ch
			MOV AL,DrawCastlearr[si]
			mov bh,0
			MOV CX, x1 ; CX = 10
			MOV DX, y1 ; DX = 20
			INT 10H
			add si,1
			inc x1
			pop cx
			
		loop dcl2
	pop cx
	mov dx,temp
	mov x1,dx
	inc y1
loop dcl1

ret 
drawCastle endp

drawHeart proc uses ax bx cx dx
	mov dx,hy1
	mov y1,dx
	mov dx,hx1
	mov x1,dx
	mov tx1,dx
	mov si,0
	mov cx,12
	hl1:
		push cx
		mov cx,14
		hl2:
			push cx
			MOV AH, 0Ch
			MOV AL,DrawHeartarr[si]
			mov bh,0
			MOV CX, x1 ; CX = 10
			MOV DX, y1 ; DX = 20
			INT 10H
			add si,1
			inc x1
			pop cx
		loop hl2
		pop cx
		mov dx,tx1
		mov x1,dx
		inc y1
	loop hl1
ret 
drawHeart endp

startscreen proc

	;new screen displayed
	mov ah,0
	mov al,13h
	int 10h
	;background color changed
	MOV AH, 06h
	MOV AL, 0
	MOV CX, 0
	MOV DH, 80
	MOV DL, 80
	MOV BH, 14h
	INT 10h

	;message of game ending is being printed over here
	mov cx,47
	mov si,0
	mov  dl, 20   
	mov  dh, 12   
	l111:
		mov  bh, 0  
		mov  ah, 02h
		int  10h
		mov  al, message2[si]
		mov  bl, 0fh  
		mov  bh, 0    
		mov  ah, 0Eh  
		int  10h
		inc si
		inc dl
	loop l111
	

ret 
startscreen endp

endscreen proc

	;new screen displayed
	mov ah,0
	mov al,13h
	int 10h
	; ;background color changed
	; mov ax,0
	; push ax
	; mov ax,0
	; push ax
	; mov ax,100
	; push ax
	; mov ax,29
	; push ax
	; mov color,03h
	; call drawrectangle

	;message of game ending is being printed over here
	mov cx,27
	mov si,0
	mov  dl, 6   
	mov  dh, 12  
	l111:
		mov  bh, 0  
		mov  ah, 02h
		int  10h
		mov  al, message[si]
		mov  bl, 0fh  
		mov  bh, 0    
		mov  ah, 0Eh  
		int  10h
		inc si
		inc dl
	loop l111
	
	mov cx,26
	mov si,0
	mov dl,6
	mov dh,14
	printmessage:
	
		mov  bh, 0  
		mov  ah, 02h
		int  10h
		mov  al, pressenter[si]
		mov  bl, 0fh  
		mov  bh, 0    
		mov  ah, 0Eh  
		int  10h
		inc si
		inc dl
	
	loop printmessage

jmp level1End

ret 
endscreen endp

endscreen2 proc

	;new screen displayed
	mov ah,0
	mov al,13h
	int 10h
	;background color changed
	; mov ax,0
	; push ax
	; mov ax,0
	; push ax
	; mov ax,100
	; push ax
	; mov ax,29
	; push ax
	; mov color,03h
	; call drawrectangle

	;message of game ending is being printed over here
	mov cx,27
	mov si,0
	mov  dl, 6   
	mov  dh, 12  
	l111:
		mov  bh, 0   
		mov  ah, 02h
		int  10h
		mov  al, message3[si]
		mov  bl, 0fh  
		mov  bh, 0    
		mov  ah, 0Eh  
		int  10h
		inc si
		inc dl
	loop l111
		mov cx,26
	mov si,0
	mov dl,6
	mov dh,14
	printmessage2:
	
		mov  bh, 0  
		mov  ah, 02h
		int  10h
		mov  al, pressenter[si]
		mov  bl, 0fh  
		mov  bh, 0    
		mov  ah, 0Eh  
		int  10h
		inc si
		inc dl
	
	loop printmessage2

jmp level2End

ret 
endscreen2 endp

endscreen3 proc

	;new screen displayed
	mov ah,0
	mov al,13h
	int 10h
	;background color changed
	; mov ax,0
	; push ax
	; mov ax,0
	; push ax
	; mov ax,100
	; push ax
	; mov ax,29
	; push ax
	; mov color,03h
	; call drawrectangle

	;message of game ending is being printed over here
	mov cx,25
	mov si,0
	mov  dl, 6   
	mov  dh, 12  
	l113:
		mov  bh, 0   
		mov  ah, 02h
		int  10h
		mov  al, message4[si]
		mov  bl, 03h  
		mov  bh, 0    
		mov  ah, 0Eh  
		int  10h
		inc si
		inc dl
	loop l113
	
	

	jmp level3End

ret 
endscreen3 endp

endscreen4 proc uses ax bx cx dx

	;new screen displayed
	mov ah,0
	mov al,13h
	int 10h
	; ;background color changed
	; mov ax,0
	; push ax
	; mov ax,0
	; push ax
	; mov ax,100
	; push ax
	; mov ax,29
	; push ax
	; mov color,03h
	; call drawrectangle

	;message of game ending is being printed over here
	mov cx,8
	mov si,0
	mov  dl, 15  
	mov  dh, 12  
	l114:
		mov  bh, 0   
		mov  ah, 02h
		int  10h
		mov  al, message5[si]
		mov  bl, 04h  
		mov  bh, 0    
		mov  ah, 0Eh  
		int  10h
		inc si
		inc dl
	loop l114

ret 
endscreen4 endp
;------------------------------------------------------------------------------------------------------------------------------------------------------;
drawMario proc uses ax cx dx


	mov dx,mariox
	mov x1,dx
	mov dx,marioy
	mov y1,dx
	
	;setting max point of mario
	mov ax,x1
	add ax,14
	mov maxx,ax
	mov ax,y1
	add ax,30
	mov maxy,ax
	
	;setting midpoint of mario
	mov ax,x1
	add ax,7
	mov midx,ax
	mov ax,y1
	add ax,15
	mov midy,ax

	;drawing mario

	mov cx,3
	l0:
	push cx
	mov cx,15
	l1:
	push cx
	mov dx,x1
	mov tempxStart,dx
	mov dx,x1
	add dx,12
	mov tempxEnd,dx
	mov dx,04h
	mov color,dx
	mov dx,y1
	mov tempy,dx
	call printline
	pop cx
	loop l1
	pop cx
	mov dx,mariox
	mov x1,dx
	add y1,1
	loop l0

	mov dx,mariox
	mov tempxStart,dx
	add tempxStart,12
	mov tempxEnd,dx
	add tempxEnd,13
	mov dx,marioy
	mov y1,dx
	mov tempy,dx
	add tempy,1
	call printline

	mov dx,mariox
	mov tempxstart,dx
	add tempxStart,1
	mov tempxEnd,dx
	add tempxEnd,10
	mov dx,marioy
	mov tempy,dx
	add tempy,3
	mov dx,06h
	mov color,dx
	call printline

	mov dx,mariox
	mov tempxstart,dx
	add tempxStart,0
	mov tempxEnd,dx
	add tempxEnd,11
	mov dx,marioy
	mov tempy,dx
	add tempy,4
	mov dx,06h
	mov color,dx
	call printline

	mov dx,mariox
	mov tempxstart,dx
	sub tempxStart,1
	mov tempxEnd,dx
	add tempxEnd,12
	mov dx,marioy
	mov tempy,dx
	add tempy,5
	mov dx,06h
	mov color,dx
	call printline

	mov dx,mariox
	mov tempxstart,dx
	sub tempxStart,1
	mov tempxEnd,dx
	add tempxEnd,13
	mov dx,marioy
	mov tempy,dx
	add tempy,6
	mov dx,06h
	mov color,dx
	call printline

	mov dx,mariox
	mov tempxstart,dx
	sub tempxStart,1
	mov tempxEnd,dx
	add tempxEnd,14
	mov dx,marioy
	mov tempy,dx
	add tempy,7
	mov dx,06h
	mov color,dx
	call printline

	mov dx,mariox
	mov tempxstart,dx
	sub tempxStart,1
	mov tempxEnd,dx
	add tempxEnd,13
	mov dx,marioy
	mov tempy,dx
	add tempy,8
	mov dx,06h
	mov color,dx
	call printline

	mov dx,mariox
	mov tempxstart,dx
	add tempxStart,0
	mov tempxEnd,dx
	add tempxEnd,12
	mov dx,marioy
	mov tempy,dx
	add tempy,9
	mov dx,06h
	mov color,dx
	call printline

	mov dx,mariox
	mov tempxstart,dx
	add tempxStart,1
	mov tempxEnd,dx
	add tempxEnd,12
	mov dx,marioy
	mov tempy,dx
	add tempy,10
	mov dx,06h
	mov color,dx
	call printline

	mov dx,mariox
	mov tempxstart,dx
	add tempxStart,1
	mov tempxEnd,dx
	add tempxEnd,11
	mov dx,marioy
	mov tempy,dx
	add tempy,11
	mov dx,04h
	mov color,dx
	call printline

	mov dx,mariox
	mov tempxstart,dx
	add tempxStart,0
	mov tempxEnd,dx
	add tempxEnd,12
	mov dx,marioy
	mov tempy,dx
	add tempy,12
	mov dx,04h
	mov color,dx
	call printline

	mov dx,marioy
	mov y1,dx
	mov cx,7
	ml1:
	push cx
	mov dx,mariox
	mov tempxstart,dx
	sub tempxStart,1
	mov tempxEnd,dx
	add tempxEnd,13
	mov dx,y1
	mov tempy,dx
	add tempy,13
	mov dx,04h
	mov color,dx
	call printline
	pop cx
	add y1,1
	loop ml1

	mov dx,mariox
	mov tempxstart,dx
	add tempxStart,0
	mov tempxEnd,dx
	add tempxEnd,12
	mov dx,marioy
	mov tempy,dx
	add tempy,20
	mov dx,04h
	mov color,dx
	call printline

	mov dx,mariox
	mov tempxstart,dx
	add tempxStart,2
	mov tempxEnd,dx
	add tempxEnd,10
	mov dx,marioy
	mov tempy,dx
	add tempy,21
	mov dx,01h
	mov color,dx
	call printline

	mov dx,mariox
	mov tempxstart,dx
	add tempxStart,7
	mov tempxEnd,dx
	add tempxEnd,8
	mov dx,marioy
	mov tempy,dx
	add tempy,21
	mov dx,0h
	mov color,dx
	call printline



	mov dx,marioy
	mov y1,dx
	mov cx,4
	ml2:
	push cx
	mov dx,mariox
	mov tempxstart,dx
	add tempxStart,1
	mov tempxEnd,dx
	add tempxEnd,11
	mov dx,y1
	mov tempy,dx
	add tempy,22
	mov dx,01h
	mov color,dx
	call printline
	mov dx,mariox
	mov tempxstart,dx
	add tempxStart,8
	mov tempxEnd,dx
	add tempxEnd,9
	mov dx,y1
	mov tempy,dx
	add tempy,22
	mov dx,0h
	mov color,dx
	call printline
	pop cx
	add y1,1
	loop ml2

	mov dx,mariox
	mov tempxstart,dx
	add tempxStart,8
	mov tempxEnd,dx
	add tempxEnd,9
	mov dx,marioy
	mov tempy,dx
	add tempy,22
	mov dx,0h
	mov color,dx
	call printline

	mov dx,mariox
	mov tempxstart,dx
	add tempxStart,2
	mov tempxEnd,dx
	add tempxEnd,10
	mov dx,marioy
	mov tempy,dx
	add tempy,26
	mov dx,01h
	mov color,dx
	call printline

	mov dx,mariox
	mov tempxstart,dx
	add tempxStart,7
	mov tempxEnd,dx
	add tempxEnd,8
	mov dx,marioy
	mov tempy,dx
	add tempy,26
	mov dx,0h
	mov color,dx
	call printline

	mov dx,mariox
	mov tempxstart,dx
	add tempxStart,2
	mov tempxEnd,dx
	add tempxEnd,10
	mov dx,marioy
	mov tempy,dx
	add tempy,27
	mov dx,06h
	mov color,dx
	call printline

	mov dx,mariox
	mov tempxstart,dx
	add tempxStart,2
	mov tempxEnd,dx
	add tempxEnd,11
	mov dx,marioy
	mov tempy,dx
	add tempy,28
	mov dx,06h
	mov color,dx
	call printline

	mov dx,mariox
	mov tempxstart,dx
	add tempxStart,2
	mov tempxEnd,dx
	add tempxEnd,10
	mov dx,marioy
	mov tempy,dx
	add tempy,29
	mov dx,06h
	mov color,dx
	call printline

	mov dx,mariox
	mov tempxstart,dx
	add tempxStart,7
	mov tempxEnd,dx
	add tempxEnd,8
	mov dx,marioy
	mov tempy,dx
	add tempy,27
	mov dx,0h
	mov color,dx
	call printline

	mov dx,mariox
	mov tempxstart,dx
	add tempxStart,8
	mov tempxEnd,dx
	add tempxEnd,9
	mov dx,marioy
	mov tempy,dx
	add tempy,28
	mov dx,0h
	mov color,dx
	call printline

	mov dx,mariox
	mov tempxstart,dx
	add tempxStart,7
	mov tempxEnd,dx
	add tempxEnd,8
	mov dx,marioy
	mov tempy,dx
	add tempy,29
	mov dx,0h
	mov color,dx
	call printline

	mov dx,mariox
	mov tempxstart,dx
	add tempxStart,8
	mov tempxEnd,dx
	add tempxEnd,9
	mov dx,marioy
	mov tempy,dx
	add tempy,6
	mov dx,0h
	mov color,dx
	call printline
	mov dx,mariox
	mov tempxstart,dx
	add tempxStart,9
	mov tempxEnd,dx
	add tempxEnd,10
	mov dx,marioy
	mov tempy,dx
	add tempy,9
	mov dx,0h
	mov color,dx
	call printline

	mov dx,mariox
	mov tempxstart,dx
	add tempxStart,10
	mov tempxEnd,dx
	add tempxEnd,11
	mov dx,marioy
	mov tempy,dx
	add tempy,9
	mov dx,0h
	mov color,dx
	call printline

	mov dx,mariox
	mov tempxstart,dx
	add tempxStart,11
	mov tempxEnd,dx
	add tempxEnd,12
	mov dx,marioy
	mov tempy,dx
	add tempy,9
	mov dx,0h
	mov color,dx
	call printline

	
ret 
drawMario endp

;fills array for enemy
fillEnemyArray proc uses cx

	mov si,0
	mov cx,6
	add si,6
	mov cx,4
	fl1:
	mov dl,06h
	mov enemy1[si],dl

	inc si
	loop fl1
	add si,11
	mov cx,6
	fl2:
	mov dl,06h
	mov enemy1[si],dl
	inc si
	loop fl2
	add si,9
	mov cx,8
	fl3:
	mov dl,06h
	mov enemy1[si],dl
	inc si
	loop fl3
	add si,7
	mov cx,10
	fl4:
	mov dl,06h
	mov enemy1[si],dl
	inc si
	loop fl4
	add si,5
	mov dl,06h
	mov enemy1[si],dl
	inc si
	mov dl,0h
	mov enemy1[si],dl
	inc si
	mov dl,0h
	mov enemy1[si],dl
	inc si
	mov cx,6
	fl5:

	mov dl,06h
	mov enemy1[si],dl
	inc si

	loop fl5
	mov dl,0h
	mov enemy1[si],dl
	inc si
	mov dl,0h
	mov enemy1[si],dl
	inc si
	mov dl,06h
	mov enemy1[si],dl
	add si,4
	mov cx,3
	fl6:

	mov dl,06h
	mov enemy1[si],dl
	inc si
	loop fl6
	mov dl,07h
	mov enemy1[si],dl
	inc si
	mov dl,0h
	mov enemy1[si],dl
	inc si
	mov cx,4
	fl7:
	mov dl,06h
	mov enemy1[si],dl
	inc si
	loop fl7
	mov dl,0h
	mov enemy1[si],dl
	inc si
	mov dl,07h
	mov enemy1[si],dl
	inc si
	mov cx,3
	fl8:
	mov dl,06h
	mov enemy1[si],dl
	inc si
	loop fl8
	add si,2
	mov cx,3
	fl9:
	mov dl,06h
	mov enemy1[si],dl
	inc si
	loop fl9
	mov dl,07h
	mov enemy1[si],dl
	inc si
	mov dl,0h
	mov enemy1[si],dl
	inc si
	mov cx,4
	fl10:
	mov dl,06h
	mov enemy1[si],dl
	inc si
	loop fl10
	mov dl,0h
	mov enemy1[si],dl
	inc si
	mov dl,07h
	mov enemy1[si],dl
	inc si
	mov cx,3
	fl11:
	mov dl,06h
	mov enemy1[si],dl
	inc si
	loop fl11
	add si,1
	mov cx,4
	fl12:
	mov dl,06h
	mov enemy1[si],dl
	inc si
	loop fl12
	mov dl,07h
	mov enemy1[si],dl
	inc si
	mov dl,0h
	mov enemy1[si],dl
	inc si
	mov dl,07h
	mov enemy1[si],dl
	inc si
	mov dl,06h
	mov enemy1[si],dl
	inc si
	mov dl,06h
	mov enemy1[si],dl
	inc si
	mov dl,07h
	mov enemy1[si],dl
	inc si
	mov dl,0h
	mov enemy1[si],dl
	inc si
	mov dl,07h
	mov enemy1[si],dl
	inc si
	mov cx,4
	fl13:
	mov dl,06h
	mov enemy1[si],dl
	inc si
	loop fl13
	mov cx,4
	fl14:
	mov dl,06h
	mov enemy1[si],dl
	inc si
	loop fl14
	mov cx,3
	fl15:
	mov dl,07h
	mov enemy1[si],dl
	inc si
	loop fl15
	mov dl,06h
	mov enemy1[si],dl
	inc si
	mov dl,06h
	mov enemy1[si],dl
	inc si
	mov cx,3
	fl16:
	mov dl,07h
	mov enemy1[si],dl
	inc si
	loop fl16
	mov cx,20
	fl17:
	mov dl,06h
	mov enemy1[si],dl
	inc si
	loop fl17
	inc si
	mov cx,4
	fl18:
	mov dl,06h
	mov enemy1[si],dl
	inc si
	loop fl18
	mov cx,6
	fl19:
	mov dl,07h
	mov enemy1[si],dl
	inc si
	loop fl19
	mov cx,4
	f1:
	mov dl,06h
	mov enemy1[si],dl
	inc si
	loop f1
	add si,5
	mov cx,8
	f2:
	mov dl,07h
	mov enemy1[si],dl
	inc si
	loop f2
	add si,6
	mov cx,2
	f3:
	mov dl,0h
	mov enemy1[si],dl
	inc si
	loop f3
	mov cx,8
	f4:
	mov dl,07h
	mov enemy1[si],dl
	inc si
	loop f4
	mov cx,2
	f5:
	mov dl,0h
	mov enemy1[si],dl
	inc si
	loop f5
	add si,3
	mov cx,5
	f6:
	mov dl,0h
	mov enemy1[si],dl
	inc si
	loop f6
	mov cx,4
	f7:
	mov dl,07h
	mov enemy1[si],dl
	inc si
	loop f7
	mov cx,5
	f8:
	mov dl,0h
	mov enemy1[si],dl
	inc si
	loop f8
	add si,2
	mov cx,6
	f9:
	mov dl,0h
	mov enemy1[si],dl
	inc si
	loop f9
	add si,2
	mov cx,6
	f10:
	mov dl,0h
	mov enemy1[si],dl
	inc si
	loop f10
	add si,3
	mov cx,5
	f11:
	mov dl,0h
	mov enemy1[si],dl
	inc si
	loop f11
	add si,2
	mov cx,5
	f12:
	mov dl,0h
	mov enemy1[si],dl
	inc si
	loop f12
ret
fillEnemyArray endp

;fills array for coin
fillCoinArray proc uses cx dx bx si ax

	mov si,0
	add si,4
	mov cx,6
	c1:
	mov dl,0h
	mov coin1[si],dl
	inc si
	loop c1
	add si,6
	mov cx,3
	c2:
	mov dl,0h
	mov coin1[si],dl
	inc si
	loop c2
	mov cx,3
	c3:
	mov dl,07h
	mov coin1[si],dl
	inc si
	loop c3
	mov cx,4
	c4:
	mov dl,0h
	mov coin1[si],dl
	inc si
	loop c4
	add si,3
	mov cx,2
	c5:
	mov dl,0h
	mov coin1[si],dl
	inc si
	loop c5
	mov cx,2
	c6:
	mov dl,07h
	mov coin1[si],dl
	inc si
	loop c6
	mov cx,5
	c7:
	mov dl,0Eh
	mov coin1[si],dl
	inc si
	loop c7
	mov cx,2
	c8:
	mov dl,0h
	mov coin1[si],dl
	inc si
	loop c8
	add si,3
	mov dl,0h
	mov coin1[si],dl
	inc si
	mov dl,07h
	mov coin1[si],dl
	inc si
	mov cx,5
	c9:
	mov dl,0Eh
	mov coin1[si],dl
	inc si
	loop c9
	mov dl,0h
	mov coin1[si],dl
	inc si
	mov cx,2
	c10:
	mov dl,0Eh
	mov coin1[si],dl
	inc si
	loop c10
	mov cx,2
	c11:
	mov dl,0h
	mov coin1[si],dl
	inc si
	loop c11
	add si,2
	mov dl,0h
	mov coin1[si],dl
	inc si
	mov dl,07h
	mov coin1[si],dl
	inc si
	mov cx,5
	c12:
	mov dl,0Eh
	mov coin1[si],dl
	inc si
	loop c12
	mov dl,0h
	mov coin1[si],dl
	inc si
	mov cx,2
	c13:
	mov dl,0Eh
	mov coin1[si],dl
	inc si
	loop c13
	mov cx,2
	c14:
	mov dl,0h
	mov coin1[si],dl
	inc si
	loop c14
	add si,1
	mov dl,0h
	mov coin1[si],dl
	inc si
	mov dl,0h
	mov coin1[si],dl
	inc si
	mov dl,07h
	mov coin1[si],dl
	inc si
	mov cx,5
	c15:
	mov dl,0Eh
	mov coin1[si],dl
	inc si
	loop c15
	mov dl,0h
	mov coin1[si],dl
	inc si
	mov cx,2
	c16:
	mov dl,0Eh
	mov coin1[si],dl
	inc si
	loop c16
	mov cx,2
	c17:
	mov dl,0h
	mov coin1[si],dl
	inc si
	loop c17
	mov dl,0h
	mov coin1[si],dl
	inc si
	mov dl,0h
	mov coin1[si],dl
	inc si
	mov dl,07h
	mov coin1[si],dl
	inc si
	mov cx,6
	c18:
	mov dl,0Eh
	mov coin1[si],dl
	inc si
	loop c18
	mov dl,0h
	mov coin1[si],dl
	inc si
	mov cx,3
	c19:
	mov dl,0Eh
	mov coin1[si],dl
	inc si
	loop c19
	mov cx,2
	c20:
	mov dl,0h
	mov coin1[si],dl
	inc si
	loop c20
	mov dl,0h
	mov coin1[si],dl
	inc si
	mov dl,07h
	mov coin1[si],dl
	inc si
	mov cx,6
	c23:
	mov dl,0Eh
	mov coin1[si],dl
	inc si
	loop c23
	mov dl,0h
	mov coin1[si],dl
	inc si
	mov cx,3
	c22:
	mov dl,0Eh
	mov coin1[si],dl
	inc si
	loop c22
	mov cx,2
	c21:
	mov dl,0h
	mov coin1[si],dl
	inc si
	loop c21

	mov dl,0h
	mov coin1[si],dl
	inc si
	mov dl,07h
	mov coin1[si],dl
	inc si
	mov cx,6
	c24:
	mov dl,0Eh
	mov coin1[si],dl
	inc si
	loop c24
	mov dl,0h
	mov coin1[si],dl
	inc si
	mov cx,3
	c25:
	mov dl,0Eh
	mov coin1[si],dl
	inc si
	loop c25
	mov cx,2
	c26:
	mov dl,0h
	mov coin1[si],dl
	inc si
	loop c26

	mov dl,0h
	mov coin1[si],dl
	inc si
	mov dl,07h
	mov coin1[si],dl
	inc si
	mov cx,6
	c27:
	mov dl,0Eh
	mov coin1[si],dl
	inc si
	loop c27
	mov dl,0h
	mov coin1[si],dl
	inc si
	mov cx,3
	c28:
	mov dl,0Eh
	mov coin1[si],dl
	inc si
	loop c28
	mov cx,2
	c29:
	mov dl,0h
	mov coin1[si],dl
	inc si
	loop c29
	mov dl,0h
	mov coin1[si],dl
	inc si
	mov dl,0h
	mov coin1[si],dl
	inc si
	mov dl,07h
	mov coin1[si],dl
	inc si
	mov cx,5
	c30:
	mov dl,0Eh
	mov coin1[si],dl
	inc si
	loop c30
	mov dl,0h
	mov coin1[si],dl
	inc si
	mov cx,2
	c31:
	mov dl,0Eh
	mov coin1[si],dl
	inc si
	loop c31
	mov cx,2
	c32:
	mov dl,0h
	mov coin1[si],dl
	add si,1
	loop c32
	add si,2
	mov dl,0h
	mov coin1[si],dl
	inc si
	mov dl,07h
	mov coin1[si],dl
	inc si
	mov cx,2
	c33:
	mov dl,0Eh
	mov coin1[si],dl
	inc si
	loop c33
	mov cx,4
	c34:
	mov dl,0h
	mov coin1[si],dl
	inc si
	loop c34
	mov cx,2
	c35:
	mov dl,0Eh
	mov coin1[si],dl
	inc si
	loop c35
	mov cx,2
	c36:
	mov dl,0h
	mov coin1[si],dl
	inc si
	loop c36
	add si,2
	mov cx,2
	c37:
	mov dl,0h
	mov coin1[si],dl
	inc si
	loop c37
	mov dl,07h
	mov coin1[si],dl
	inc si
	mov cx,6
	c38:
	mov dl,0Eh
	mov coin1[si],dl
	inc si
	loop c38
	mov cx,2
	c39:
	mov dl,0h
	mov coin1[si],dl
	inc si
	loop c39
	add si,4
	mov cx,3
	c40:
	mov dl,0h
	mov coin1[si],dl
	inc si
	loop c40
	mov cx,3
	c41:
	mov dl,0Eh
	mov coin1[si],dl
	inc si
	loop c41
	mov cx,4
	c42:
	mov dl,0h
	mov coin1[si],dl
	inc si
	loop c42
	add si,5
	mov cx,8
	c43:
	mov dl,0h
	mov coin1[si],dl
	inc si
	loop c43
ret 
fillCoinArray endp

end main


