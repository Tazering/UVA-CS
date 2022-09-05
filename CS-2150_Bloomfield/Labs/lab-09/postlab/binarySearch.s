;	Name: Tyler Kim
;	Computing Id: tkj9ep
;	Date: 04/15/2022
;	Filename: binarySearch.s
;
;	Parameter 1: edi => address of array
;	Parameter 2: esi => lower bound
;	Parameter 3: edx => upper bound
;	Parameter 4: ecx => key

	global binarySearch
	
	section .text
	
binarySearch:
mov eax, -1
mov r11d, 0

loop:
cmp esi, edx
jg end
mov r11d, esi
add r11d, edx
shr r11d, 1
cmp [edi + 4*r11d], ecx
jl lowerUpdate
jg higherUpdate
je updateRet
jmp loop

lowerUpdate:
mov esi, r11d
add esi, 1
jmp loop

higherUpdate:
mov edx, r11d
sub edx, 1
jmp loop

updateRet:
mov eax, r11d

end:
ret
