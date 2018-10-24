;+
; NAME:
;   obs_time
; PURPOSE:
;   This function reads the scan time of an MCCD row and returns an ASCII
;   string.  The time is stored in the first four pixels at the North edge
;   of the row for the image taken at wavelength pixel 0.
; CALLING SEQUENCE:
;   time = obs_time (cube, row, index=index, precision=precision, /help)
; INPUTS:
;   cube = MCCD data cube *or* corresponding filename.
;   row = MCCD scan row (Y coordinate) in IDL (zero-based) numbering.
; OPTIONAL INPUT PARAMETERS:
;   index = sequence number of MCCD file.  If specified, the full file name
;      is give by FILE.INDEX.
;   precision = 1, 10, or 100, indicating whether time is precise to 1 sec,
;      10ths of a second (default), or 100ths of a second.  Time information
;      is recorded in 100ths of a second so no greater precision is available.
;      If PRECISION is absent or is not 1, 10 or 100, then 10ths are used.
; KEYWORD PARAMETERS:
;   help = nonzero to print calling sequence summary.  The summary is
;      also printed if the function is called with no parameters.
; OUTPUT:
;   time = ASCII string specifying scan time to desired PRECISION.
; OTHER ROUTINES INVOKED:
;   reafits.pro (JPW):  reads FITS file.
;   blank0.pro (JdLB):  converts spaces to zeros in a string.
; ACKNOWLEDGEMENTS:
;   This is a modified version of a function written by Kristen L. Blais.
; BUGS:
;   Should return error message if LOWPIX2 keyword of FITS header is
;   defined and >0, indicating that the time data are absent.
; MODIFICATION HISTORY:
;   1991 Jul 24:  Modified from original K. L. Blais routine by J-F de La
;                 Beaujardiere. [version 1.0]
;   1991 Sep 19:  Ability to specify filename for CUBE added. (JdLB) [1.1]
;   1991 Sep 19:  HELP keyword added. (JdLB) [1.2]
;   1993 Jan 20:  PRECISION keyword added.  Code streamlined.  Automatic
;                 printing (when no parameters are specified) of help
;                 message added. (JdLB) [1.3]
;   1993 Feb 04:  INDEX keyword added. (JdLB) [1.4]
;-


FUNCTION obs_time, cube, row, index=index, precision=precision, help=help

on_error, 2  ;return to caller if error occurs

; Display calling sequence summary
if ( (keyword_set(help)) OR (n_params() EQ 0) ) then begin
   print, "CALLING SEQUENCE:"
   print, "   time = obs_time (cube, row, index=index, precision=precision,"
   print, "      /help)"
   return, ""
endif

; Read data cube if not passed as parameter
if (n_elements(cube) EQ 1) then begin  ;assume parameter is a scalar string
   filename = strtrim(cube, 2)
   if (n_elements(index) EQ 1) then begin
      filename = filename + "." + strtrim(index,2)
   endif
   tmp = findfile(filename, count=file_count)
   if (file_count EQ 0) then begin
      print, "File " + filename + " not found."
      return, ""  ;exit procedure
   endif else begin
      cube = readfits(filename)
   endelse
endif

; Extract time information from start of row (in 100ths of a second)
number = long(cube(0, 0:3, row), 0)
STOP
print,number

; Convert to hours, minutes and seconds

decimal_hours = number/360000.0
hours = fix(decimal_hours)
hr = string(hours, format='(i2.2)')

decimal_minutes = (decimal_hours - hours) * 60
minutes = fix(decimal_minutes)
mn = string(minutes, format='(i2.2)')

decimal_seconds = (decimal_minutes - minutes) * 60
if (n_elements(precision) EQ 0) then precision = 10  ;default: 10ths of sec
precision = float(precision)
case (precision) of
   1: begin  ;result rounded to whole seconds
      seconds = fix(decimal_seconds*precision + 0.5) / precision
      sc = string(seconds, format='(i2.2)')
   end
   100: begin  ;result rounded to 100ths of seconds (best available)
      seconds = fix(decimal_seconds*precision + 0.5) / precision
      sc = string(seconds, format='(f5.2)')
   end
   else: begin  ;result rounded to 10ths of seconds (default)
      precision = 10.0
      seconds = fix(decimal_seconds*precision + 0.5) / precision
      sc = string(seconds, format='(f4.1)')
   end
endcase

; Return time string
f_time = hr + ":" + mn + ":" + sc
f_time = blank0(f_time)
return, f_time

end
