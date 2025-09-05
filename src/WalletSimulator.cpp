#include "WalletSimulator.h"
#include <QRandomGenerator>

static const char* WORDS[] = {
    "able","about","absent","abstract","access","accident","account","acid","acquire","across",
    "act","action","actor","adapt","add","adjust","admit","adult","advance","advice",
    "aerobic","affair","afford","afraid","again","age","agent","agree","ahead","aim"
};

WalletSimulator::WalletSimulator(QObject* parent) : QObject(parent) {
    generateDummySeed();
    m_txTo = "bc1qexampleaddress000000000000000000000";
    m_txAmount = "0.015 BTC";
    m_txFee = "0.0002 BTC";
}

void WalletSimulator::generateDummySeed() {
    m_seed.clear();
    for (int i = 0; i < 12; ++i) {
        int idx = QRandomGenerator::global()->bounded(0, (int)(sizeof(WORDS)/sizeof(WORDS[0])));
        m_seed << WORDS[idx];
    }
    emit seedChanged();
}

void WalletSimulator::regenerateSeed() { generateDummySeed(); }

void WalletSimulator::setTxTo(const QString& v) { if (m_txTo == v) return; m_txTo = v; emit txChanged(); }
void WalletSimulator::setTxAmount(const QString& v) { if (m_txAmount == v) return; m_txAmount = v; emit txChanged(); }
void WalletSimulator::setTxFee(const QString& v) { if (m_txFee == v) return; m_txFee = v; emit txChanged(); }

QString WalletSimulator::txTotal() const {
    // naive parser: extract number before space
    auto parse = [](const QString& t) {
        bool ok=false; double val = t.split(' ').value(0).toDouble(&ok); return ok ? val : 0.0; };
    double total = parse(m_txAmount) + parse(m_txFee);
    QString unit = m_txAmount.split(' ').value(1, "BTC");
    return QString::number(total, 'f', 6) + " " + unit;
}

bool WalletSimulator::confirmTransaction() {
    // Always succeed in demo
    emit signedOk();
    return true;
}