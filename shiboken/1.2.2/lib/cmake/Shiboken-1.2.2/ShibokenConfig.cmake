if (NOT PYTHON_SUFFIX)
    message(STATUS "Using default python: -python2.7")
    SET(PYTHON_SUFFIX -python2.7)
endif()
include(/usr/local/Cellar/shiboken/1.2.2/lib/cmake/Shiboken-1.2.2/ShibokenConfig${PYTHON_SUFFIX}.cmake)
