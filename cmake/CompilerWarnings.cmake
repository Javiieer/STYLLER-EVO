# Compiler warnings configuration for OTX Server

function(set_project_warnings target_name)
    set(MSVC_WARNINGS
        /W4     # Baseline reasonable warnings
        /w14242 # Conversion warnings
        /w14254 # Operator conversion warnings
        /w14263 # Member function does not override
        /w14265 # Class has virtual functions but no virtual destructor
        /w14287 # Unsigned/negative constant mismatch
        /we4289 # Loop variable used outside loop
        /w14296 # Expression is always true/false
        /w14311 # Pointer truncation
        /w14545 # Expression before comma has no effect
        /w14546 # Function call before comma has no effect
        /w14547 # Operator before comma has no effect
        /w14549 # Operator before comma has no effect
        /w14555 # Expression has no effect
        /w14619 # Pragma warning suppressed
        /w14640 # Thread un-safe static member initialization
        /w14826 # Conversion is sign-extended
        /w14905 # Wide string literal cast
        /w14906 # String literal cast
        /w14928 # Illegal copy-initialization
        /permissive- # Conformance mode
    )

    set(GCC_CLANG_WARNINGS
        -Wall
        -Wextra
        -Wshadow
        -Wnon-virtual-dtor
        -Wold-style-cast
        -Wcast-align
        -Wunused
        -Woverloaded-virtual
        -Wpedantic
        -Wconversion
        -Wsign-conversion
        -Wnull-dereference
        -Wdouble-promotion
        -Wformat=2
        -Wno-maybe-uninitialized
    )

    if(MSVC)
        set(PROJECT_WARNINGS ${MSVC_WARNINGS})
    else()
        set(PROJECT_WARNINGS ${GCC_CLANG_WARNINGS})
    endif()

    target_compile_options(${target_name} PRIVATE ${PROJECT_WARNINGS})
endfunction()
