;+
; NAME:
;   blank0
; PURPOSE:
;   This function converts all blanks in a string to zeros.  Thus " 1:38: 8"
;   becomes "01:38:08".
; CALLING SEQUENCE:
;   outstr = blank0(instr)
; PARAMETERS:
;   instr = input string
;   outstr = output string
; MODIFICATON HISTORY:
;   1992 Jun 01:  Written by J-F de La Beaujardiere, from code fragment
;                 provided by T. R. Metcalf. [version 1.0]
;-

FUNCTION blank0, instr

; Convert input string to byte array
sb = byte(instr) 

; Search for blanks (ASCII 32)
si = where(sb EQ 32)

; Replace blanks with zeros (ASCII 48)
if si(0) NE -1 then sb(si)=48

; Return new string and exit
return, string(sb)
end
