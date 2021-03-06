# Standard includes and utils to compile into all tests.
SET (util_SRCS)


#####################################################
# Don't forget to include output directory, otherwise
# the UI file won't be wrapped!
INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR}
  ${CMAKE_CURRENT_BINARY_DIR}
  ${CMAKE_CURRENT_BINARY_DIR}/../../../src/ui
  ${CMAKE_CURRENT_SOURCE_DIR}/../core #for render checker class
  ${CMAKE_CURRENT_SOURCE_DIR}/../../../src/gui
  ${CMAKE_CURRENT_SOURCE_DIR}/../../../src/gui/editorwidgets
  ${CMAKE_CURRENT_SOURCE_DIR}/../../../src/gui/editorwidgets/core
  ${CMAKE_CURRENT_SOURCE_DIR}/../../../src/gui/symbology-ng
  ${CMAKE_CURRENT_SOURCE_DIR}/../../../src/gui/raster
  ${CMAKE_CURRENT_SOURCE_DIR}/../../../src/core
  ${CMAKE_CURRENT_SOURCE_DIR}/../../../src/core/auth
  ${CMAKE_CURRENT_SOURCE_DIR}/../../../src/core/geometry
  ${CMAKE_CURRENT_SOURCE_DIR}/../../../src/core/raster
  ${CMAKE_CURRENT_SOURCE_DIR}/../../../src/core/symbology-ng
  ${CMAKE_CURRENT_SOURCE_DIR}/../../../src/test
  ${CMAKE_BINARY_DIR}/src/core
  ${CMAKE_BINARY_DIR}/src/gui
)
INCLUDE_DIRECTORIES(SYSTEM
  ${QT_INCLUDE_DIR}
  ${GDAL_INCLUDE_DIR}
  ${PROJ_INCLUDE_DIR}
  ${GEOS_INCLUDE_DIR}
  ${QWT_INCLUDE_DIR}
  ${QCA_INCLUDE_DIR}
  ${QTKEYCHAIN_INCLUDE_DIR}
  ${QSCINTILLA_INCLUDE_DIR}
)

#note for tests we should not include the moc of our
#qtests in the executable file list as the moc is
#directly included in the sources
#and should not be compiled twice. Trying to include
#them in will cause an error at build time
#############################################################
# Tests:

#
# QgsQuickPrint test
#
#SET(qgis_quickprinttest_SRCS testqgsquickprint.cpp ${util_SRCS})
#SET(qgis_quickprinttest_MOC_CPPS testqgsquickprint.cpp)
#QT5_WRAP_CPP(qgis_quickprinttest_MOC_SRCS ${qgis_quickprinttest_MOC_CPPS})
#ADD_CUSTOM_TARGET(qgis_quickprinttestmoc ALL DEPENDS ${qgis_quickprinttest_MOC_SRCS})
#ADD_EXECUTABLE(qgis_quickprinttest ${qgis_quickprinttest_SRCS})
#ADD_DEPENDENCIES(qgis_quickprinttest qgis_quickprinttestmoc)
#TARGET_LINK_LIBRARIES(qgis_quickprinttest ${QT_LIBRARIES} qgis_core qgis_gui)
#SET_TARGET_PROPERTIES(qgis_quickprinttest
#  PROPERTIES INSTALL_RPATH ${QGIS_LIB_DIR}
#  INSTALL_RPATH_USE_LINK_PATH true)
#IF (APPLE)
#  # For Mac OS X, the executable must be at the root of the bundle's executable folder
#  INSTALL(TARGETS qgis_quickprinttest RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX})
#  ADD_TEST(qgis_quickprinttest ${CMAKE_INSTALL_PREFIX}/qgis_quickprinttest)
#ELSE (APPLE)
#  INSTALL(TARGETS qgis_quickprinttest RUNTIME DESTINATION ${QGIS_BIN_DIR})
#  ADD_TEST(qgis_quickprinttest ${CMAKE_INSTALL_PREFIX}/bin/qgis_quickprinttest)
#ENDIF (APPLE)

SET(IMAGE_RCCS ../../../images/images.qrc)
QT5_ADD_RESOURCES(IMAGE_RCC_SRCS ${IMAGE_RCCS})

MACRO (ADD_QGIS_TEST testname testsrc)
  SET(qgis_${testname}_SRCS ${testsrc} ${util_SRCS})
  SET(qgis_${testname}_MOC_CPPS ${testsrc})
  ADD_EXECUTABLE(qgis_${testname} ${qgis_${testname}_SRCS} ${IMAGE_RCC_SRCS})
  SET_TARGET_PROPERTIES(qgis_${testname} PROPERTIES AUTOMOC TRUE)
  TARGET_LINK_LIBRARIES(qgis_${testname}
    ${QT_QTXML_LIBRARY}
    ${QT_QTCORE_LIBRARY}
    ${QT_QTSVG_LIBRARY}
    ${QT_QTTEST_LIBRARY}
    ${QT_QTNETWORK_LIBRARY}
    ${OPTIONAL_QTWEBKIT}
    ${PROJ_LIBRARY}
    ${GEOS_LIBRARY}
    ${GDAL_LIBRARY}
    ${QWT_LIBRARY}
    qgis_core
    qgis_gui)
  ADD_TEST(qgis_${testname} ${CMAKE_CURRENT_BINARY_DIR}/../../../output/bin/qgis_${testname} -maxwarnings 10000)
  #SET_TARGET_PROPERTIES(qgis_${testname} PROPERTIES
  #  INSTALL_RPATH ${CMAKE_INSTALL_PREFIX}/${QGIS_LIB_DIR}
  #  INSTALL_RPATH_USE_LINK_PATH true )
ENDMACRO (ADD_QGIS_TEST)

ADD_QGIS_TEST(zoomtest testqgsmaptoolzoom.cpp)
ADD_QGIS_TEST(edittooltest testqgsmaptooledit.cpp)

# a simple app for testing GUI of renderers
# These tests are old and are never run so removed for now.
#SET(rendererv2gui_SRCS testrenderergui.cpp)
#SET(rendererv2gui_HDRS testrenderergui.h)
#QT5_WRAP_CPP(rendererv2gui_MOC_SRCS ${rendererv2gui_HDRS})
#ADD_EXECUTABLE(qgis_rendererv2gui ${rendererv2gui_SRCS} ${rendererv2gui_MOC_SRCS})

#ADD_QGIS_TEST(histogramtest testqgsrasterhistogram.cpp)
ADD_QGIS_TEST(doublespinbox testqgsdoublespinbox.cpp)
ADD_QGIS_TEST(dualviewtest testqgsdualview.cpp)
ADD_QGIS_TEST(attributeformtest testqgsattributeform.cpp)
ADD_QGIS_TEST(dockwidget testqgsdockwidget.cpp)
ADD_QGIS_TEST(fieldexpressionwidget testqgsfieldexpressionwidget.cpp)
ADD_QGIS_TEST(filewidget testqgsfilewidget.cpp)
ADD_QGIS_TEST(focuswatcher testqgsfocuswatcher.cpp)
ADD_QGIS_TEST(mapcanvastest testqgsmapcanvas.cpp)
ADD_QGIS_TEST(projectionissues testprojectionissues.cpp)
ADD_QGIS_TEST(qgsguitest testqgsgui.cpp)
ADD_QGIS_TEST(rubberbandtest testqgsrubberband.cpp)
ADD_QGIS_TEST(scalecombobox testqgsscalecombobox.cpp)
ADD_QGIS_TEST(spinbox testqgsspinbox.cpp)
ADD_QGIS_TEST(sqlcomposerdialog testqgssqlcomposerdialog.cpp)
ADD_QGIS_TEST(editorwidgetregistrytest testqgseditorwidgetregistry.cpp)
ADD_QGIS_TEST(keyvaluewidgettest testqgskeyvaluewidget.cpp)
ADD_QGIS_TEST(listwidgettest testqgslistwidget.cpp)
ADD_QGIS_TEST(filedownloader testqgsfiledownloader.cpp)
