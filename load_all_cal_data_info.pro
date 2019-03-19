
basedir = '/SMdata4/kreardon/Science/mccd/data/'
dark_files = file_search(basedir + 'dark/','*dark*fits*', count=num_dark_files)
PRINT,'Loading full-frame darks - ', STRTRIM(num_dark_files,2) + ' files'

dark_hdr_stat          = FLTARR(4,num_dark_files)

imn                    = 0
imagein                = readfits(dark_files[imn],darkhdr,/Silent)
dark_hdr_stat[0:3,imn] = moment(imagein)
dark_hdr_info          = parse_mccd_hdr(darkhdr, filename=dark_files[imn])

for imn=1,num_dark_files-1 do begin & imagein = readfits(dark_files[imn],darkhdr,/Silent) & $
    dark_hdr_stat[0:3,imn] = moment(imagein)
    dark_hdr_info = [dark_hdr_info, parse_mccd_hdr(darkhdr, filename=dark_files[imn])] & $
endfor

SAVE,dark_files,dark_hdr_stat,dark_hdr_info,filename='mccd.data.dark.header.info.sav'

; #############################################################################

drsc_files = file_search(basedir + 'drsc/','*drsc*fits*', count=num_drsc_files)
PRINT,'Loading dark scans - ', STRTRIM(num_drsc_files,2) + ' files'

drsc_hdr_stat          = FLTARR(4,num_drsc_files)

imn                    = 0
imagein                = readfits(drsc_files[imn],drschdr,/Silent)
drsc_hdr_stat[0:3,imn] = moment(imagein)
drsc_hdr_info          = parse_mccd_hdr(drschdr, filename=drsc_files[imn])

for imn=1,num_drsc_files-1 do begin & imagein = readfits(drsc_files[imn],drschdr,/Silent) & $
    drsc_hdr_stat[0:3,imn] = moment(imagein) & $
    drsc_hdr_info = [drsc_hdr_info, parse_mccd_hdr(drschdr, filename=drsc_files[imn])] & $
endfor

SAVE,drsc_files,drsc_hdr_stat,drsc_hdr_info,filename='mccd.data.drsc.header.info.sav'


; #############################################################################

flat_files = file_search(basedir + 'flat/','*flat*fits*', count=num_flat_files)
;PRINT,num_flat_files
PRINT,'Loading flat images - ', STRTRIM(num_flat_files,2) + ' files'
flat_hdr_stat          = FLTARR(4,num_flat_files)

imn                    = 0
imagein                = readfits(flat_files[imn],flathdr,/Silent)
flat_hdr_stat[0:3,imn] = moment(imagein)
flat_hdr_info          = parse_mccd_hdr(flathdr, filename=flat_files[imn])

for imn=1,num_flat_files-1 do begin & imagein = readfits(flat_files[imn],flathdr,/Silent) & $
    flat_hdr_stat[0:3,imn] = moment(imagein) & $
    flat_hdr_info = [flat_hdr_info, parse_mccd_hdr(flathdr, filename=flat_files[imn])] & $
endfor

SAVE,flat_files,flat_hdr_stat,flat_hdr_info,filename='mccd.data.flat.header.info.sav'


; #############################################################################

smallscan_files = file_search(basedir + 'smallscan/','*scan*fits*', count=num_smallscan_files)
PRINT,'Loading small scan files - ', STRTRIM(num_smallscan_files,2) + ' files'

smallscan_hdr_stat          = FLTARR(4,num_smallscan_files)

imn                    = 0
imagein                = readfits(smallscan_files[imn],smallscanhdr,/Silent)
smallscan_hdr_stat[0:3,imn] = moment(imagein)
smallscan_hdr_info          = parse_mccd_hdr(smallscanhdr, filename=smallscan_files[imn])

for imn=1,num_smallscan_files-1 do begin & imagein = readfits(smallscan_files[imn],smallscanhdr,/Silent) & $
    smallscan_hdr_stat[0:3,imn] = moment(imagein) & $
    smallscan_hdr_info = [smallscan_hdr_info, parse_mccd_hdr(smallscanhdr, filename=smallscan_files[imn])] & $
endfor

SAVE,smallscan_files,smallscan_hdr_stat,smallscan_hdr_info,filename='mccd.data.smallscan.header.info.sav'


; #############################################################################

sngl_files = file_search(basedir + 'sngl/','*sngl*fits*', count=num_sngl_files)
PRINT,'Loading single files - ', STRTRIM(num_sngl_files,2) + ' files'

sngl_hdr_stat          = FLTARR(4,num_sngl_files)

imn                    = 0
imagein                = readfits(sngl_files[imn],snglhdr,/Silent)
sngl_hdr_stat[0:3,imn] = moment(imagein)
sngl_hdr_info          = parse_mccd_hdr(snglhdr, filename=sngl_files[imn])

for imn=1,num_sngl_files-1 do begin & imagein = readfits(sngl_files[imn],snglhdr,/Silent) & $
    sngl_hdr_stat[0:3,imn] = moment(imagein) & $
    sngl_hdr_info = [sngl_hdr_info, parse_mccd_hdr(snglhdr, filename=sngl_files[imn])] & $
endfor

SAVE,sngl_files,sngl_hdr_stat,sngl_hdr_info,filename='mccd.data.sngl.header.info.sav'

END
