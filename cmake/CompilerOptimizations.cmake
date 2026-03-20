# Compiler optimizations for OTX Server

function(set_optimization_flags target_name)
    if(CMAKE_BUILD_TYPE MATCHES Release)
        if(MSVC)
            target_compile_options(${target_name} PRIVATE
                /O2         # Maximize speed
                /Ob2        # Inline expansion
                /Oi         # Enable intrinsic functions
                /Ot         # Favor fast code
                /GL         # Whole program optimization
            )
            target_link_options(${target_name} PRIVATE
                /LTCG       # Link-time code generation
                /OPT:REF    # Eliminate unreferenced functions/data
                /OPT:ICF    # Enable COMDAT folding
            )
        else()
            # GCC/Clang optimizations
            target_compile_options(${target_name} PRIVATE
                -O3             # Maximum optimization
                -march=native   # Optimize for current CPU
                -mtune=native   # Tune for current CPU
                -ffast-math     # Fast math operations
                -funroll-loops  # Unroll loops
                -flto           # Link-time optimization
            )
            target_link_options(${target_name} PRIVATE
                -flto           # Link-time optimization
            )
        endif()
    elseif(CMAKE_BUILD_TYPE MATCHES Debug)
        if(MSVC)
            target_compile_options(${target_name} PRIVATE /Od /Zi)
        else()
            target_compile_options(${target_name} PRIVATE -O0 -g3 -ggdb)
        endif()
    endif()
endfunction()
