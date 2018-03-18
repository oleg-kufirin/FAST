# Download and set up DCMTK

include(cmake/Externals.cmake)

set(MODULES ofstd oflog dcmdata dcmimgle)

ExternalProject_Add(dcmtk
        PREFIX ${FAST_EXTERNAL_BUILD_DIR}/dcmtk
        BINARY_DIR ${FAST_EXTERNAL_BUILD_DIR}/dcmtk
        GIT_REPOSITORY "https://github.com/DCMTK/dcmtk.git"
        GIT_TAG "DCMTK-3.6.3"
        CMAKE_ARGS
            -DCMAKE_MACOSX_RPATH=ON
            -DBUILD_SHARED_LIBS=ON
        CMAKE_CACHE_ARGS
            -DDCMTK_MODULES:STRING=${MODULES}
            -DCMAKE_BUILD_TYPE:STRING=Release
            -DCMAKE_VERBOSE_MAKEFILE:BOOL=OFF
            -DCMAKE_INSTALL_MESSAGE:BOOL=LAZY
            -DCMAKE_INSTALL_PREFIX:STRING=${FAST_EXTERNAL_INSTALL_DIR}
)
if(WIN32)
    set(DCMTK_LIBRARIES ofstd.lib oflog.lib dcmdata.lib dcmimgle.lib)
else(WIN32)
    set(DCMTK_LIBRARIES
        ${CMAKE_SHARED_LIBRARY_PREFIX}ofstd${CMAKE_SHARED_LIBRARY_SUFFIX}
        ${CMAKE_SHARED_LIBRARY_PREFIX}oflog${CMAKE_SHARED_LIBRARY_SUFFIX}
        ${CMAKE_SHARED_LIBRARY_PREFIX}dcmdata${CMAKE_SHARED_LIBRARY_SUFFIX}
        ${CMAKE_SHARED_LIBRARY_PREFIX}dcmimgle${CMAKE_SHARED_LIBRARY_SUFFIX}
    )
endif(WIN32)
list(APPEND LIBRARIES ${DCMTK_LIBRARIES})
list(APPEND FAST_EXTERNAL_DEPENDENCIES dcmtk)
