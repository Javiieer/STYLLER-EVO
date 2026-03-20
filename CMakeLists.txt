cmake_minimum_required(VERSION 3.16)
project(otx-styller VERSION 1.0.0 LANGUAGES CXX)

# Set C++ standard
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Add cmake modules path
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

# Output binary name
set(EXECUTABLE_NAME "theotxserver")

# Build type
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release CACHE STRING "Choose the type of build." FORCE)
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "RelWithDebInfo" "MinSizeRel")
endif()

# Compiler flags
if(MSVC)
    # Windows / Visual Studio
    add_compile_options(
        /W3         # Warning level 3
        /MP         # Multi-processor compilation
        /bigobj     # Big object files
        /EHsc       # Exception handling
    )
    add_compile_definitions(_WIN32_WINNT=0x0601 _CRT_SECURE_NO_WARNINGS)
else()
    # Linux / GCC / Clang
    add_compile_options(
        -pipe
        -Wall
        -Wno-maybe-uninitialized
        -pthread
        -fno-strict-aliasing
    )
    
    # Optimization flags for release
    if(CMAKE_BUILD_TYPE MATCHES Release)
        add_compile_options(
            -O3
            -march=native
            -mtune=native
        )
    endif()
endif()

# Preprocessor definitions
add_compile_definitions(
    _REENTRANT
    BOOST_DISABLE_ASSERTS
    NDEBUG
    __USE_MYSQL__
    __ROOT_PERMISSION__
)

# Find required packages
find_package(Boost REQUIRED COMPONENTS system filesystem thread regex iostreams)
find_package(fmt CONFIG REQUIRED)
find_package(luajit CONFIG REQUIRED)
find_package(LibXml2 REQUIRED)
find_package(pugixml CONFIG REQUIRED)
find_package(unofficial-libmariadb CONFIG REQUIRED)

if(WIN32)
    find_package(mpir REQUIRED)
else()
    find_package(GMP REQUIRED)
endif()

# Source files
set(SOURCES
    src/actions.cpp
    src/allocator.cpp
    src/baseevents.cpp
    src/beds.cpp
    src/chat.cpp
    src/combat.cpp
    src/condition.cpp
    src/configmanager.cpp
    src/connection.cpp
    src/container.cpp
    src/creature.cpp
    src/creatureevent.cpp
    src/cylinder.cpp
    src/database.cpp
    src/databasemanager.cpp
    src/databasemysql.cpp
    src/depot.cpp
    src/dispatcher.cpp
    src/exception.cpp
    src/fileloader.cpp
    src/game.cpp
    src/globalevent.cpp
    src/group.cpp
    src/house.cpp
    src/housetile.cpp
    src/ioban.cpp
    src/ioguild.cpp
    src/iologindata.cpp
    src/iomap.cpp
    src/iomapserialize.cpp
    src/item.cpp
    src/itemattributes.cpp
    src/items.cpp
    src/luascript.cpp
    src/mailbox.cpp
    src/manager.cpp
    src/map.cpp
    src/monster.cpp
    src/monsters.cpp
    src/movement.cpp
    src/networkmessage.cpp
    src/npc.cpp
    src/otpch.cpp
    src/otserv.cpp
    src/outfit.cpp
    src/mounts.cpp
    src/outputmessage.cpp
    src/party.cpp
    src/sha1.cpp
    src/player.cpp
    src/position.cpp
    src/protocol.cpp
    src/protocolgame.cpp
    src/protocolhttp.cpp
    src/protocollogin.cpp
    src/protocolold.cpp
    src/quests.cpp
    src/raids.cpp
    src/rsa.cpp
    src/scheduler.cpp
    src/scriptmanager.cpp
    src/server.cpp
    src/spawn.cpp
    src/spectators.cpp
    src/spells.cpp
    src/status.cpp
    src/talkaction.cpp
    src/teleport.cpp
    src/textlogger.cpp
    src/thing.cpp
    src/tile.cpp
    src/tools.cpp
    src/trashholder.cpp
    src/waitlist.cpp
    src/weapons.cpp
    src/vocation.cpp
)

# Create executable
add_executable(${EXECUTABLE_NAME} ${SOURCES})

# Include directories
target_include_directories(${EXECUTABLE_NAME} PRIVATE
    ${CMAKE_SOURCE_DIR}/src
    ${Boost_INCLUDE_DIRS}
    ${LIBXML2_INCLUDE_DIR}
)

# Link libraries
target_link_libraries(${EXECUTABLE_NAME} PRIVATE
    Boost::system
    Boost::filesystem
    Boost::thread
    Boost::regex
    Boost::iostreams
    fmt::fmt
    luajit::luajit
    LibXml2::LibXml2
    pugixml::pugixml
    unofficial::libmariadb
)

# Platform-specific libraries
if(WIN32)
    target_link_libraries(${EXECUTABLE_NAME} PRIVATE
        mpir::mpir
        ws2_32
        wsock32
        crypt32
    )
else()
    target_link_libraries(${EXECUTABLE_NAME} PRIVATE
        ${GMP_LIBRARIES}
        pthread
        crypto
        sqlite3
    )
    
    # Try to find and link tcmalloc if available
    find_library(TCMALLOC_LIBRARY NAMES tcmalloc_minimal tcmalloc)
    if(TCMALLOC_LIBRARY)
        message(STATUS "Found tcmalloc: ${TCMALLOC_LIBRARY}")
        target_link_libraries(${EXECUTABLE_NAME} PRIVATE ${TCMALLOC_LIBRARY})
    else()
        message(WARNING "tcmalloc not found, performance may be affected")
    endif()
endif()

# Set output directory
set_target_properties(${EXECUTABLE_NAME} PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
)

# Installation
install(TARGETS ${EXECUTABLE_NAME} DESTINATION bin)

# Print configuration summary
message(STATUS "")
message(STATUS "========================================")
message(STATUS "OTX Styller Server Configuration")
message(STATUS "========================================")
message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")
message(STATUS "Compiler: ${CMAKE_CXX_COMPILER_ID}")
message(STATUS "Platform: ${CMAKE_SYSTEM_NAME}")
message(STATUS "Binary name: ${EXECUTABLE_NAME}")
message(STATUS "========================================")
message(STATUS "")
