cmake_minimum_required(VERSION 3.16)
project(qt_wallet_poc LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Zapne AUTOMOC/AUTORCC/AUTOUIC + nastaví moderní Qt CMake policy (vč. QTP0001)
find_package(Qt6 6.5 COMPONENTS Quick Qml REQUIRED)
qt_standard_project_setup()  # <- klíčové

qt_add_executable(qt_wallet_poc
    src/main.cpp
    src/WalletSimulator.cpp
    src/WalletSimulator.h
)

# Pro jistotu ještě přímo na targetu (někdy CI tvrdohlavé)
set_target_properties(qt_wallet_poc PROPERTIES
    AUTOMOC ON
    AUTORCC ON
    AUTOUIC ON
)

# QML modul zabalený do stejného targetu
qt_add_qml_module(qt_wallet_poc
    URI WalletPoc
    VERSION 1.0
    # volitelně: sjednotíme prefix, ať je to stejné všude
    RESOURCE_PREFIX /
    QML_FILES
        qml/Main.qml
        qml/components/SeedGrid.qml
)

target_link_libraries(qt_wallet_poc
    PRIVATE Qt6::Quick Qt6::Qml
)
