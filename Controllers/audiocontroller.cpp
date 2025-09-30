#include "audiocontroller.h"
#include <algorithm>

AudioController::AudioController(QObject *parent)
    : QObject{parent},
    m_volume(60)
{}

int AudioController::volume() const
{
    return m_volume;
}

void AudioController::setVolume(int newVolume)
{
    if (m_volume == newVolume)
        return;
    m_volume = newVolume;
    emit volumeChanged();
}

void AudioController::changeVolume(const int &value)
{
    int volume = std::clamp(m_volume + value, 0, 100);
    setVolume(volume);
}

void AudioController::muteVolume()
{
    if(!muted){
        muted= true;
        preMuteValue = m_volume;
        setVolume(0);
    } else {
        muted= false;
        setVolume(preMuteValue);
        preMuteValue = 0;
    }
}
