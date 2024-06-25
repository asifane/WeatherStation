#ifndef WEATHER_H
#define WEATHER_H

#include <QObject>
#include <QtSerialPort/QSerialPort>
#include <QtSerialPort/QSerialPortInfo>
#include <QDebug>

class weather : public QObject
{
    Q_OBJECT
    Q_PROPERTY(float m_temperature READ m_temperature WRITE setM_temperature NOTIFY m_temperatureChanged)
    Q_PROPERTY(float m_humid READ m_humid WRITE setM_humid NOTIFY m_humidChanged)
    Q_PROPERTY(int m_winddir READ m_winddir WRITE setM_winddir NOTIFY m_winddirChanged)
    Q_PROPERTY(float m_windspeed READ m_windspeed WRITE setM_windspeed NOTIFY m_windspeedChanged)
    Q_PROPERTY(float m_rainfall READ m_rainfall WRITE setM_rainfall NOTIFY m_rainfallChanged)
    Q_PROPERTY(float m_uv READ m_uv WRITE setM_uv NOTIFY m_uvChanged)
    Q_PROPERTY(float m_lux READ m_lux WRITE setM_lux NOTIFY m_luxChanged)
    Q_PROPERTY(QString m_systemMsg READ m_systemMsg WRITE setM_systemMsg NOTIFY m_systemMsgChanged)
public:
    explicit weather(QObject *parent = nullptr);
    ~weather();

    float m_temperature() const;
    void setM_temperature(float newM_temperature);

    float m_humid() const;
    void setM_humid(float newM_humid);

    int m_winddir() const;
    void setM_winddir(int newM_winddir);

    float m_rainfall() const;
    void setM_rainfall(float newM_rainfall);

    float m_uv() const;
    void setM_uv(float newM_uv);

    float m_lux() const;
    void setM_lux(float newM_lux);

    QString m_systemMsg() const;
    void setM_systemMsg(const QString &newM_systemMsg);

    float m_windspeed() const;
    void setM_windspeed(float newM_windspeed);

private:
    void handleReadyRead();
    static unsigned char CalcSum(unsigned char *pkg, int len);
    void parsePackage(unsigned char *Buffer);

    QSerialPort* m_serialPort;
    unsigned char readBuff[20];  //raw data buffer
    unsigned char Buffer[17];
    QByteArray buff;

    float m_m_temperature;

    float m_m_humid;

    int m_m_winddir;

    float m_m_rainfall;

    float m_m_uv;

    float m_m_lux;

    QString m_m_systemMsg;

    float m_m_windspeed;

signals:

    void m_temperatureChanged();

    void m_humidChanged();

    void m_winddirChanged();

    void m_rainfallChanged();

    void m_uvChanged();

    void m_luxChanged();

    void m_systemMsgChanged();

    void m_windspeedChanged();

public slots:

};



#endif // WEATHER_H
