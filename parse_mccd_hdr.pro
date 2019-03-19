FUNCTION parse_mccd_hdr, header_in, filename=filename

IF NOT keyword_set(filename) THEN filename=''

array_size   = FIX([sxpar(header_in,'NAXIS1'),sxpar(header_in,'NAXIS2'),sxpar(header_in,'NAXIS3')])

array_type   = [sxpar(header_in,'CRVAL1'),sxpar(header_in,'CRVAL2'),sxpar(header_in,'CRVAL3')]

array_val    = [sxpar(header_in,'CRVAL1'),sxpar(header_in,'CRVAL2'),sxpar(header_in,'CRVAL3')]
array_refpix = [sxpar(header_in,'CRPIX1'),sxpar(header_in,'CRPIX2'),sxpar(header_in,'CRPIX3')]
array_delt   = [sxpar(header_in,'CDELT1'),sxpar(header_in,'CDELT2'),sxpar(header_in,'CDELT3')]

date_obs     = sxpar(header_in,'DATE-OBS') + 'Z' +sxpar(header_in,'TIME-OBS')
t_obs     = sxpar(header_in,'T_OBS')

scan_center  = sxpar(header_in,'FASTGUID')
fast_guide   = sxpar(header_in,'SCCENTER')
grating_num  = sxpar(header_in,'GRATNO')
grating_ang  = sxpar(header_in,'GRATANG')
scan_type    = sxpar(header_in,'SCANTYPE')
data_type    = sxpar(header_in,'DATATYPE')
scan_dir     = sxpar(header_in,'SCANDIR')
step_size    = sxpar(header_in,'STEPSZ')
exptime      = sxpar(header_in,'EXPLEN')
offsets      = [sxpar(header_in,'OFFSET1'),sxpar(header_in,'OFFSET2')]
binning      = [sxpar(header_in,'BIN1'),sxpar(header_in,'BIN2')]
slitwidth    = sxpar(header_in,'SLITWDTH')
xy_pos       = [sxpar(header_in,'X'),sxpar(header_in,'Y')]
hg_pos       = [sxpar(header_in,'LAT'),sxpar(header_in,'LONG')]
object       = sxpar(header_in,'OBJECT')
rotator_pos  = sxpar(header_in,'IMAGEROT')
filter       = sxpar(header_in,'FILTER')
program      = sxpar(header_in,'PROGRAM')
observer     = sxpar(header_in,'OBSERVER')

instrument   = sxpar(header_in,'INSTRUME')

source       = sxpar(header_in,'SOURCE')


mccd_meta    = CREATE_STRUCT( name='mccd', $
                             'date_obs',   date_obs, $
                             't_obs',   t_obs, $
                             'instrument', instrument, $
                             'exptime', exptime, $
                             'xy_pos', xy_pos, $
                             'hg_pos', hg_pos, $
                             'object', object, $
                             'program', program, $
                             'array_size', array_size, $
                             'array_type', array_type, $
                             'array_val', array_val, $
                             'array_refpix', array_refpix, $
                              'array_delt', array_delt, $
                             'scan_center', scan_center, $
                             'fast_guide', fast_guide, $
                             'grating_num', grating_num, $
                             'data_type', data_type, $
                             'scan_type', scan_type, $
                             'scan_dir', scan_dir, $
                            'step_size', step_size, $
                            'offsets', offsets, $
                             'binning', binning, $
                             'slitwidth', slitwidth, $
                             'rotator_pos', rotator_pos, $
                             'filter', filter, $
                             'observer', observer, $
                             'source', source, $
                             'filename', filename $
)

RETURN, mccd_meta

END
                             
                             
                             