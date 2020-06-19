# Purpose:
# Find out how the find script passes data back to the main CMake script.

cmake_minimum_required(VERSION 3.2)

project("main")

message("CMAKE_CURRENT_SOURCE_DIR is " ${CMAKE_CURRENT_SOURCE_DIR})

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

message("CMAKE_MODULE_PATH is " ${CMAKE_MODULE_PATH})

#find_package("POTATO")

# REQUIRED sets POTATO_FIND_REQUIRED in the find script.
# - Note that POTATO_FIND_REQUIRED is set even if POTATO_FOUND was set on a previous execution

find_package("POTATO" REQUIRED)

#-------------------------------------------------------------------------------------------------------------------------
# Analyzing the results of find_package
#-------------------------------------------------------------------------------------------------------------------------

#Note:  If you don't trust me that this is an effective way to find whether a varaible is cache or not, please see:
#       https://github.com/amelvill-umich/CMake_Is_Cache
get_property(isPotatoFoundCache CACHE POTATO_FOUND PROPERTY TYPE)
message("isPotatoFoundCache: " ${isPotatoFoundCache})

#Values previously set:
message("POTATO_DIR is " ${POTATO_DIR})

# Not transferred from FindPotato script:
# (this varaible has no value here)
message("POTATO_FIND_REQUIRED is " ${POTATO_FIND_REQUIRED})

# Transferred by some mysterious means (???) from FindPotato script:
#
# Note that it seems like find_package reads the <package>_FOUND (local!) variable set in FindPotato.cmake,
# then sets a <package>_FOUND local variable in this script's scope.
# ... why doesn't CMake just make <package>_FOUND a cache variable?
message("POTATO_FOUND is " ${POTATO_FOUND})

# Cache variables set in FindPotato script.
message("POTATO_INCLUDE_DIR is " ${POTATO_INCLUDE_DIR})
message("POTATO_NONSENSE_INCLUDE_DIR is " ${POTATO_NONSENSE_INCLUDE_DIR})