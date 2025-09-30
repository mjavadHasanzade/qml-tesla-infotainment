#ifndef HVACHANDLER_H
#define HVACHANDLER_H

#include <QObject>

class HVACHandler : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int targetTemprature READ targetTemprature WRITE setTargetTemprature NOTIFY targetTempratureChanged FINAL)

public:
    explicit HVACHandler(QObject *parent = nullptr);

    int targetTemprature() const;
    void setTargetTemprature(int newTargetTemprature);

    Q_INVOKABLE void chnageTargetTemprature(const int &value);

signals:
    void targetTempratureChanged();
private:
    int m_targetTemprature;
};

#endif // HVACHANDLER_H
