cmake_minimum_required(VERSION 3.16)
project(qt_wallet_poc LANGUAGES CXX)

# Qt: zapni automoc/autouic/autorcc (řeší metatype generation error)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt6 6.5 COMPONENTS Quick Qml REQUIRED)

# Qt policy: nastav prefix pro QML moduly (umlčí warning QTP0001)
qt_policy(SET QTP0001 NEW)

qt_add_executable(qt_wallet_poc
    src/main.cpp
    src/WalletSimulator.cpp
    src/WalletSimulator.h
)

# QML modul uvnitř stejného targetu
qt_add_qml_module(qt_wallet_poc
    URI WalletPoc
    VERSION 1.0
    RESOURCE_PREFIX /
    QML_FILES
        qml/Main.qml
        qml/components/SeedGrid.qml
)

target_link_libraries(qt_wallet_poc
    PRIVATE Qt6::Quick Qt6::Qml
)
