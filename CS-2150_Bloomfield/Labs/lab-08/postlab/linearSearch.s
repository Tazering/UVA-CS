;	Name: Tyler Kim
;	Computing Id: tkj9ep
;	Date: 04/01/2022
;	Filename: linearSearch.s
;
;	Parameter 1: edi => address of array
;	Parameter 2: esi => size of the array
;	Parameter 3: edx => target value

	global linearSearch
	
	section .text
	
	
linearSearch:
	mov eax, -1
	mov r11d, 0

loop:
	cmp esi, r11d
	je endLoop
	cmp edx, [edi+r11d*4]
	je updateTheValue
	inc r11d
	jmp loop

updateTheValue:
	mov eax, r11d

endLoop:
	ret


