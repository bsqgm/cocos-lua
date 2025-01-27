cmake_minimum_required(VERSION 3.6)

set(LIBNAME plugin_wechat)

set(SOURCE
    lua_wechat.cpp
    WeChat.cpp
)

set(HEADER
    lua_wechat.h
    WeChat.h
)

if(IOS)
    list(APPEND HEADER
        ios/WechatAuthSDK.h
        ios/WXApi.h
        ios/WXApiObject.h
    )
    list(APPEND SOURCE
        WeChat.mm
    )
endif()

list(APPEND SOURCE ${HEADER})

add_library(${LIBNAME} ${SOURCE})

target_include_directories(${LIBNAME}
    PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}
    PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/..
)

target_link_libraries(${LIBNAME} PRIVATE xgame)

if(IOS)
    target_link_libraries(${LIBNAME} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/ios/libWeChatSDK.a)
endif()

if(ANDROID OR IOS)
    target_compile_definitions(${LIBNAME} PUBLIC CCLUA_BUILD_WECHAT)
endif()

set_target_properties(${LIBNAME} PROPERTIES
    ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
    FOLDER "Plugins"
)

if(XCODE OR VS)
    cocos_mark_code_files(${LIBNAME} GROUPBASE "${CMAKE_CURRENT_SOURCE_DIR}")
endif()