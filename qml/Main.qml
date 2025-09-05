import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: win
    visible: true
    width: 960
    height: 600
    title: "Wallet PoC (Qt/QML)"

    header: ToolBar {
        contentHeight: 48
        RowLayout {
            anchors.fill: parent
            spacing: 12
            ToolButton { text: "Onboarding"; onClicked: stack.currentIndex = 0 }
            ToolButton { text: "Podepsat"; onClicked: stack.currentIndex = 1 }
            Item { Layout.fillWidth: true }
            Label { text: "Demo pouze pro UI – žádné skutečné klíče"; color: "#cccccc" }
        }
    }

    StackLayout {
        id: stack
        anchors.fill: parent

        // === Onboarding (seed) ===
        Page {
            background: Rectangle { color: "#121212" }
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 24
                spacing: 16

                Label { text: "Záloha seedu (DEMO)"; font.pixelSize: 24; color: "white" }
                Label { text: "Zapiš si 12 slov v pořadí. Nikomu je neukazuj."; color: "#cfcfcf" }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "#181818"
                    radius: 8
                    border.width: 1; border.color: "#2c2c2c"

                    Flickable {
                        anchors.fill: parent
                        contentWidth: parent.width
                        contentHeight: seedCol.implicitHeight
                        clip: true

                        Column {
                            id: seedCol
                            width: parent.width
                            spacing: 16
                            padding: 24

                            Loader {
                                source: "qrc:/WalletPoc/qml/components/SeedGrid.qml"
                                onLoaded: { item.words = wallet.seedWords }
                            }

                            Row {
                                spacing: 12
                                Button { text: "Znovu vygenerovat"; onClicked: wallet.regenerateSeed() }
                                Button { text: "Mám zapsáno"; onClicked: stack.currentIndex = 1 }
                            }
                            Label { text: "UPOZORNĚNÍ: Toto je pouze DEMO, slova nejsou skutečný seed."; color: "#aaaaaa" }
                        }
                    }
                }
            }
        }

        // === Sign transaction ===
        Page {
            background: Rectangle { color: "#121212" }
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 24
                spacing: 16

                Label { text: "Potvrzení transakce (DEMO)"; font.pixelSize: 24; color: "white" }

                GridLayout {
                    columns: 2
                    columnSpacing: 24
                    rowSpacing: 12

                    Label { text: "Příjemce:"; color: "#cfcfcf" }
                    TextField { text: wallet.txTo; onTextChanged: wallet.txTo = text }

                    Label { text: "Částka:"; color: "#cfcfcf" }
                    TextField { text: wallet.txAmount; onTextChanged: wallet.txAmount = text }

                    Label { text: "Poplatek:"; color: "#cfcfcf" }
                    TextField { text: wallet.txFee; onTextChanged: wallet.txFee = text }

                    Label { text: "Celkem:"; color: "#cfcfcf" }
                    Label { text: wallet.txTotal; color: "#eaeaea" }
                }

                RowLayout {
                    spacing: 12
                    Button {
                        text: "Odmítnout"
                        onClicked: popup.text = "Transakce odmítnuta (simulace)", popup.open()
                    }
                    Button {
                        text: "Potvrdit"
                        onClicked: {
                            if (wallet.confirmTransaction()) {
                                popup.text = "Transakce podepsána (simulace)"; popup.open()
                            }
                        }
                    }
                }

                Label { text: "Pozn.: V reálném zařízení by zde probíhalo bezpečné podepisování PSBT/EIP-712 bez dotyku seedu v UI vrstvě."; color: "#999999" }
            }
        }
    }

    Dialog {
        id: popup
        modal: false
        x: win.width - width - 24
        y: 72
        property string text: ""
        title: "Výsledek"
        standardButtons: Dialog.Ok
        contentItem: Label { text: popup.text; padding: 12 }
    }
}