#ifndef AUDIO_HDL_HPP
#define AUDIO_HDL_HPP

#include <QObject>
#include <QAudioInput>
#include <QIODevice>
#include <QtDebug>

namespace quarre
{
class audio_hdl : public QIODevice
{
    Q_OBJECT
    Q_PROPERTY  ( qreal rms READ rms )

    public:
    audio_hdl ( );

    virtual qint64 readData         ( char *data, qint64 maxlen ) override;
    virtual qint64 writeData        ( const char* data, qint64 len ) override;
    virtual qint64 bytesAvailable   ( ) const override;

    qreal rms ( ) const { return m_rms; }

    public slots:
    void activate_input      ( ) { m_input->start(this); }
    void deactivate_input    ( ) { m_input->stop(); }
    void monitor_input_state ( QAudio::State state ) { qDebug() << state; }

    private:
    QAudioInput* m_input;
    qreal m_rms;
};
}

#endif // AUDIO_HDL_HPP
