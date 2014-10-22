# CMake Notes

## Message Stuff

    # The compiler flags for compiling C sources 
	MESSAGE( STATUS "CMAKE_C_FLAGS--------------------------------: " ${CMAKE_C_FLAGS} )
	# the compiler flags for compiling C++ sources 
	MESSAGE( STATUS "CMAKE_CXX_FLAGS: " ${CMAKE_CXX_FLAGS} )
	# Choose the type of build.  Example: SET(CMAKE_BUILD_TYPE Debug) 
	MESSAGE( STATUS "CMAKE_BUILD_TYPE: " ${CMAKE_BUILD_TYPE} )
	# Release flags
	MESSAGE( STATUS "CMAKE_CXX_FLAGS_RELEASE: " ${CMAKE_CXX_FLAGS_RELEASE} )


