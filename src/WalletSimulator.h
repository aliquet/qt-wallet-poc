#pragma once
#include <QObject>
#include <QStringList>

class WalletSimulator : public QObject {
    Q_OBJECT
    Q_PROPERTY(QStringList seedWords READ seedWords NOTIFY seedChanged)
    Q_PROPERTY(QString txTo READ txTo WRITE setTxTo NOTIFY txChanged)
    Q_PROPERTY(QString txAmount READ txAmount WRITE setTxAmount NOTIFY txChanged)
    Q_PROPERTY(QString txFee READ txFee WRITE setTxFee NOTIFY txChanged)
    Q_PROPERTY(QString txTotal READ txTotal NOTIFY txChanged)
public:
    explicit WalletSimulator(QObject* parent = nullptr);

    Q_INVOKABLE void regenerateSeed();
    Q_INVOKABLE bool confirmTransaction();

    QStringList seedWords() const { return m_seed; }

    QString txTo() const { return m_txTo; }
    void setTxTo(const QString& v);

    QString txAmount() const { return m_txAmount; }
    void setTxAmount(const QString& v);

    QString txFee() const { return m_txFee; }
    void setTxFee(const QString& v);

    QString txTotal() const; // amount + fee (string math kept simple for demo)

signals:
    void seedChanged();
    void txChanged();
    void signedOk();
    void signedRejected();

private:
    void generateDummySeed();

    QStringList m_seed;
    QString m_txTo;
    QString m_txAmount; // text for simplicity (e.g. "0.015 BTC")
    QString m_txFee;    // e.g. "0.0002 BTC"
};