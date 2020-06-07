add_library(ExTotoSQL SHARED libmain.cpp)

add_executable(fsmgr fsmgr_main.cpp)
target_link_libraries(fsmgr ExTotoSQL -lmysqlpp)
