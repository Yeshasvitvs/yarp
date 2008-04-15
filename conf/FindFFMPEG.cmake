# from VTK project

#
# Find the native FFMPEG includes and library
#
# This module defines
# FFMPEG_INCLUDE_DIR, where to find avcodec.h, avformat.h ...
# FFMPEG_LIBRARIES, the libraries to link against to use FFMPEG.
# FFMPEG_FOUND, If false, do not try to use FFMPEG.

# also defined, but not for general use are
# FFMPEG_avformat_LIBRARY and FFMPEG_avcodec_LIBRARY, where to find the FFMPEG library.
# This is usefull to do it this way so that we can always add more libraries
# if needed to FFMPEG_LIBRARIES if ffmpeg ever changes...

FIND_PATH(FFMPEG_INCLUDE_DIR1 avformat.h
  /usr/local/include/ffmpeg
  /usr/include/ffmpeg
  $ENV{FFMPEG_DIR}
  $ENV{FFMPEG_DIR}/ffmpeg
  $ENV{FFMPEG_DIR}/include/ffmpeg
  /usr/include/libavformat
  /usr/local/include/libavformat
)

FIND_PATH(FFMPEG_INCLUDE_DIR2 avutil.h
  /usr/local/include/ffmpeg
  /usr/include/ffmpeg
  $ENV{FFMPEG_DIR}
  $ENV{FFMPEG_DIR}/ffmpeg
  $ENV{FFMPEG_DIR}/include/ffmpeg
  /usr/include/libavutil
  /usr/local/include/libavutil
)

FIND_PATH(FFMPEG_INCLUDE_DIR3 avcodec.h
  /usr/local/include/ffmpeg
  /usr/include/ffmpeg
  $ENV{FFMPEG_DIR}
  $ENV{FFMPEG_DIR}/ffmpeg
  $ENV{FFMPEG_DIR}/include/ffmpeg
  /usr/include/libavcodec
  /usr/local/include/libavcodec
)

FIND_PATH(FFMPEG_INCLUDE_DIR4 swscale.h
  /usr/local/include/ffmpeg
  /usr/include/ffmpeg
  $ENV{FFMPEG_DIR}
  $ENV{FFMPEG_DIR}/ffmpeg
  $ENV{FFMPEG_DIR}/include/ffmpeg
  /usr/include/libswscale
  /usr/local/include/libswscale
)

FIND_PATH(FFMPEG_INCLUDE_DIR5 avdevice.h
  /usr/local/include/ffmpeg
  /usr/include/ffmpeg
  $ENV{FFMPEG_DIR}
  $ENV{FFMPEG_DIR}/ffmpeg
  $ENV{FFMPEG_DIR}/include/ffmpeg
  /usr/include/libavdevice
  /usr/local/include/libavdevice
)

IF (FFMPEG_INCLUDE_DIR1)
  IF (FFMPEG_INCLUDE_DIR2)
    IF (FFMPEG_INCLUDE_DIR3)
      SET(FFMPEG_INCLUDE_DIR 
	${FFMPEG_INCLUDE_DIR1}
	${FFMPEG_INCLUDE_DIR2}
	${FFMPEG_INCLUDE_DIR3})
    ENDIF (FFMPEG_INCLUDE_DIR3)
  ENDIF (FFMPEG_INCLUDE_DIR2)
ENDIF (FFMPEG_INCLUDE_DIR1)

IF (FFMPEG_INCLUDE_DIR4)
      SET(FFMPEG_INCLUDE_DIR 
	${FFMPEG_INCLUDE_DIR}
	${FFMPEG_INCLUDE_DIR4})
ENDIF (FFMPEG_INCLUDE_DIR4)

IF (FFMPEG_INCLUDE_DIR5)
      SET(FFMPEG_INCLUDE_DIR 
	${FFMPEG_INCLUDE_DIR}
	${FFMPEG_INCLUDE_DIR5})
ENDIF (FFMPEG_INCLUDE_DIR5)

FIND_LIBRARY(FFMPEG_avformat_LIBRARY avformat
  /usr/local/lib
  /usr/lib
  $ENV{FFMPEG_DIR}
  $ENV{FFMPEG_DIR}/lib
)

FIND_LIBRARY(FFMPEG_avcodec_LIBRARY avcodec
  /usr/local/lib
  /usr/lib
  $ENV{FFMPEG_DIR}
  $ENV{FFMPEG_DIR}/lib
)

FIND_LIBRARY(FFMPEG_avutil_LIBRARY avutil
  /usr/local/lib
  /usr/lib
  $ENV{FFMPEG_DIR}
  $ENV{FFMPEG_DIR}/lib
)

FIND_LIBRARY(FFMPEG_swscale_LIBRARY swscale
  /usr/local/lib
  /usr/lib
  $ENV{FFMPEG_DIR}
  $ENV{FFMPEG_DIR}/lib
)

FIND_LIBRARY(FFMPEG_avdevice_LIBRARY avdevice
  /usr/local/lib
  /usr/lib
  $ENV{FFMPEG_DIR}
  $ENV{FFMPEG_DIR}/lib
)

FIND_LIBRARY(_FFMPEG_z_LIBRARY_ z
  /usr/local/lib
  /usr/lib
  $ENV{FFMPEG_DIR}
  $ENV{FFMPEG_DIR}/lib
)



IF(FFMPEG_INCLUDE_DIR)
  IF(FFMPEG_avformat_LIBRARY)
    IF(FFMPEG_avcodec_LIBRARY)
      IF(FFMPEG_avutil_LIBRARY)
        SET( FFMPEG_FOUND "YES" )
        SET( FFMPEG_LIBRARIES 
          ${FFMPEG_avformat_LIBRARY}
          ${FFMPEG_avcodec_LIBRARY} 
          ${FFMPEG_avutil_LIBRARY} 
          )
	IF(FFMPEG_swscale_LIBRARY)
          SET( FFMPEG_LIBRARIES 
	    ${FFMPEG_LIBRARIES}
            ${FFMPEG_swscale_LIBRARY}
          )
	ENDIF(FFMPEG_swscale_LIBRARY)
	IF(FFMPEG_avdevice_LIBRARY)
          SET( FFMPEG_LIBRARIES 
	    ${FFMPEG_LIBRARIES}
            ${FFMPEG_avdevice_LIBRARY}
          )
	ENDIF(FFMPEG_avdevice_LIBRARY)
	IF(_FFMPEG_z_LIBRARY_)
          SET( FFMPEG_LIBRARIES 
	    ${FFMPEG_LIBRARIES}
            ${_FFMPEG_z_LIBRARY_}
          )
	ENDIF(_FFMPEG_z_LIBRARY_)
      ENDIF(FFMPEG_avutil_LIBRARY)
    ENDIF(FFMPEG_avcodec_LIBRARY)
  ENDIF(FFMPEG_avformat_LIBRARY)
ENDIF(FFMPEG_INCLUDE_DIR)

MARK_AS_ADVANCED(
  FFMPEG_INCLUDE_DIR
  FFMPEG_INCLUDE_DIR1
  FFMPEG_INCLUDE_DIR2
  FFMPEG_INCLUDE_DIR3
  FFMPEG_INCLUDE_DIR4
  FFMPEG_INCLUDE_DIR5
  FFMPEG_avformat_LIBRARY
  FFMPEG_avcodec_LIBRARY
  FFMPEG_avutil_LIBRARY
  FFMPEG_swscale_LIBRARY
  FFMPEG_avdevice_LIBRARY
  _FFMPEG_z_LIBRARY_
  )

