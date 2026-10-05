include(cmake/FetchUpstream.cmake)
add_custom_target(aio-files ALL
  COMMAND ${CMAKE_COMMAND} -E make_directory "${AC_PLUGINS_OUTPUT_DIR}/aio/client/addons"
  COMMAND ${CMAKE_COMMAND} -E copy_directory "${module}/AIO_Server" "${AC_PLUGINS_OUTPUT_DIR}/aio/lua"
  COMMAND ${CMAKE_COMMAND} -E copy_directory "${module}/AIO_Client" "${AC_PLUGINS_OUTPUT_DIR}/aio/client/addons/AIO_Client"
  COMMAND ${CMAKE_COMMAND} -E copy_if_different "${CMAKE_CURRENT_SOURCE_DIR}/plugin.json" "${AC_PLUGINS_OUTPUT_DIR}/aio/plugin.json"
  COMMAND ${CMAKE_COMMAND} -E copy_if_different "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE" "${AC_PLUGINS_OUTPUT_DIR}/aio/LICENSE"
  COMMAND ${CMAKE_COMMAND} -E copy_if_different "${CMAKE_CURRENT_SOURCE_DIR}/README.md" "${AC_PLUGINS_OUTPUT_DIR}/aio/README.md"
  VERBATIM)
set_property(GLOBAL APPEND PROPERTY LONELYICE_PACKAGE_TARGETS aio-files)
