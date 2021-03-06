# Reset to empty
export MULLE_SDE_UPDATE_CALLBACKS="sourcetree:source"


# Used by `mulle-match find` to speed up the search.
export MULLE_MATCH_FILENAMES="config:*.h:*.inc:*.c:CMakeLists.txt:*.cmake:*.m:*.aam"


# Used by `mulle-match find` to locate files
export MULLE_MATCH_PATH="${PROJECT_SOURCE_DIR}:CMakeLists.txt:cmake"


# Used by `mulle-match find` to ignore boring subdirectories like .git
export MULLE_MATCH_IGNORE_PATH=


# noob it up a little, to only have ObjC headers for
# Foundation as the default
export MULLE_SOURCETREE_TO_C_INCLUDE_FILE="DISABLE"


#
#
#
export MULLE_SOURCETREE_TO_C_PRIVATEINCLUDE_FILE="DISABLE"


# tell mulle-sde to keep files protected from read/write changes
export MULLE_SDE_PROTECT_PATH="cmake/share"


