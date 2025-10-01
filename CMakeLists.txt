cmake_minimum_required(VERSION 3.16)

project(Tesla_Infotainment VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Location Core5Compat)
find_package(Qt6 REQUIRED COMPONENTS Core)

qt_standard_project_setup(REQUIRES 6.9)

qt_add_executable(appTesla_Infotainment
    main.cpp
)

qt_add_qml_module(appTesla_Infotainment
    URI Tesla_Infotainment
    VERSION 1.0

    QML_FILES
        Main.qml
        ui/BottomBar/BottomBar.qml
        ui/RightScreen/RightScreen.qml
        ui/LeftScreen/LeftScreen.qml
        ui/RightScreen/NavigationSearchBox.qml
        ui/BottomBar/HVACComponent.qml
        ui/BottomBar/VolumeComponent.qml
        ui/RightScreen/BottomSheet.qml

    RESOURCES
        assets.qrc

    SOURCES
        Controllers/system.h
        Controllers/system.cpp
        Controllers/hvachandler.h
        Controllers/hvachandler.cpp
        Controllers/audiocontroller.h
        Controllers/audiocontroller.cpp
)


# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appTesla_Infotainment PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appTesla_Infotainment
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appTesla_Infotainment
    PRIVATE Qt6::Quick
    Qt6::Location
    Qt6::Core5Compat
)
target_link_libraries(appTesla_Infotainment PRIVATE Qt6::Core )

include(GNUInstallDirs)
install(TARGETS appTesla_Infotainment
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
