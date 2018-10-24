;+
; NAME:
;	get_mccd_times.pro
; PURPOSE:
; 	extract times of beginning, middle, and end of a sequence of
;	incrementally numbered MCCD scans stored on disk
; CATEGORY:
; CALLING SEQUENCE:
;	times = get_mccd_times(file,beg,ned)
; INPUTS:
;	file = the base of the MCCD files
;	beg = the beginning file number of the sequence of files
;	ned = the ending file number of the sequence
; KEYWORD PARAMETERS:
;	/MSEC = causes times to be returned in float array as milliseconds
;		past midnight
;	PRECISION = 1, 10, or 100, indicating whether time is precise to 
;		1 sec (default), 10ths of a second, or 100ths of a second.  
;		Time information is recorded in 100ths of a second so no 
;		greater precision is available. If PRECISION is absent or 
;		is not 1, 10 or 100, then 10ths are used.
; OUTPUTS:
;	times = strarr(neg-beg+1,3) - string representations (HH:MM:SS)
;		of the beginning, middle, and end if the MCCD scans
; MODIFICATION HISTORY:
;       k. reardon - 1992 - initial implementation
;  	k. reardon - 25 february, 1994 - cleaned up
;  	k. reardon - 24 october, 2018 - adapting for different filename convention

function get_mccd_times,filename,msec=msec,precision=precision

if not keyword_set(precision) then precision = 1
tst = where(precision eq [1,10,100]) ge 0
if tst(0) lt 0 then precision = 1
if not keyword_set(msec) then times = strarr(3) else $
	times = fltarr(3)
 
scan    = readfits(filename)
sizfil  = size(scan) 
totrows = sizfil(3)

beg     = 0
ned     = 0

for i = beg,ned do begin 
    filen = file
  
    if not keyword_set(msec) then begin
   	    times(i-beg,0) = obs_time(filen,0,index=i,prec=precision)
   	    times(i-beg,1) = obs_time(filen,fix(totrows/2)-1,index=i,prec=precision)
   	    times(i-beg,2) = obs_time(filen,totrows-1,index=i,prec=precision)
    endif else begin
   	    times(i-beg,0) = time2msec(obs_time(filen,0,index=i,prec=precision))
   	    times(i-beg,1) = time2msec(obs_time(filen,fix(totrows/2)-1,$
			 index=i,prec=precision))
   	    times(i-beg,2) = time2msec(obs_time(filen,totrows-1,$
			 index=i,prec=precision))
    endelse

endfor

return,times

end
