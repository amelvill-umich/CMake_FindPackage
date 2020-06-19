# Note: the name of this file is very case sensitive
message("Start of FindPOTATO.cmake")

message("POTATO_DIR is " ${POTATO_DIR})
message("POTATO_FIND_REQUIRED is " ${POTATO_FIND_REQUIRED})
message("POTATO_FOUND is " ${POTATO_FOUND})
message("POTATO_INCLUDE_DIR is " ${POTATO_INCLUDE_DIR})
message("POTATO_NONSENSE_INCLUDE_DIR is " ${POTATO_NONSENSE_INCLUDE_DIR})


# Note: I could have automatically set POTATO_DIR, but I'm going to have you set it through the UI, 
#       or command line with something like, in a build folder created in the root,
#           cmake .. -DPOTATO_DIR=/home/me/CMake_FindPackage/librobotpotato

if (NOT POTATO_FOUND AND NOT POTATO_DIR)
    SET(POTATO_DIR "" CACHE PATH "libpotato installation directory, as in the librobotpotato folder in this repository with include and src on it." FORCE)
    if (POTATO_FIND_REQUIRED)
        message(FATAL_ERROR "Please set POTATO_DIR variable to the root of the libpotato installation directory.")
    endif()

    message("Could not find libpotato (no directory), but since it's not required we're just going to end early")
    return()

endif()

message("Looking up libpotato using POTATO_DIR")

# Note: FIND_PATH creates a cache varaible, I don't have to declare the variable before this function writes to it or anything like that
FIND_PATH( 
    POTATO_INCLUDE_DIR 
    potato.h 
    PATHS ${POTATO_DIR}/include 
    DOC "Path to potato includes" 
    NO_DEFAULT_PATH
) 

#Note: find_path does not error out or anything if it can't find it, it just makes a cache variable with <varname>-NOTFOUND at the end of it
FIND_PATH( 
    POTATO_NONSENSE_INCLUDE_DIR 
    doesnotexist.h 
    PATHS ${POTATO_DIR}/include 
    DOC "Path to nonsense includes" 
    NO_DEFAULT_PATH
) 

# Unfortunately even if C_INCLUDE_PATH is, e.g., /home/me/CMake_FindPackage/librobotpotato/extrainclude
# this will not work. It looks like CMake does not take env vars into account
# https://stackoverflow.com/q/50346194
#
# It looks like the only way to change the behavior of the find scripts is to make your own find script
# or specify <package>_PATH to the cmake command line.
FIND_PATH(
    POTATO_EXTRA_INCLUDE_DIR
    potato_extra.h
    # Deliberately not providing a path because this won't be in a place cmake can find   
    DOC "Path to header that needs to be found with C_INCLUDE_PATH"
    NO_DEFAULT_PATH
)

# Note: CMake does not seem to have any kind of builtin setup to say 
#       "if every single find statement succeeded, set POTATO_FOUND"

# Though it does have this function, which a lot of our scripts use:
include (FindPackageHandleStandardArgs)

# Note: POTATO_FOUND (set by find_package_handle_standard_args) is not a cache varaible, it's a local variable

# Does not cause a fatal error if it could find POTATO_INCLUDE_DIR
find_package_handle_standard_args (POTATO DEFAULT_MSG POTATO_INCLUDE_DIR)

# Causes a fatal error because POTATO_NONSENSE_INCLUDE_DIR is NOTFOUND, all of the entries to the right of DEFAULT_MSG have to be truey
# find_package_handle_standard_args (POTATO DEFAULT_MSG POTATO_INCLUDE_DIR POTATO_NONSENSE_INCLUDE_DIR)



message("Ok, we're done looking for the potato library, here's the new variable values:")
message("POTATO_DIR is " ${POTATO_DIR})
message("POTATO_FIND_REQUIRED is " ${POTATO_FIND_REQUIREd})
message("POTATO_FOUND is " ${POTATO_FOUND})
message("POTATO_INCLUDE_DIR is " ${POTATO_INCLUDE_DIR})
message("POTATO_NONSENSE_INCLUDE_DIR is " ${POTATO_NONSENSE_INCLUDE_DIR})
message("POTATO_EXTRA_INCLUDE_DIR is " ${POTATO_EXTRA_INCLUDE_DIR})

message("End of findpotato.cmake")