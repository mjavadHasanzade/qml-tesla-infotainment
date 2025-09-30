#ifndef AUDIOCONTROLLER_H
#define AUDIOCONTROLLER_H

#include <QObject>

class AudioController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int volume READ volume WRITE setVolume NOTIFY volumeChanged FINAL)
public:
    explicit AudioController(QObject *parent = nullptr);

    int volume() const;
    void setVolume(int newVolume);

    Q_INVOKABLE void changeVolume(const int &value);
    Q_INVOKABLE void muteVolume();


signals:
    void volumeChanged();
private:
    int m_volume;
    bool muted =false;
    int preMuteValue;
};

#endif // AUDIOCONTROLLER_H
