#include "weather.h"

weather::weather(QObject *parent)
    : QObject(parent)
    ,m_m_temperature(0.0)
    ,m_m_humid(0.0)
    ,m_m_winddir(0)
    ,m_m_rainfall(0.0)
    ,m_m_uv(0.0)
    ,m_m_lux(0.0)
    ,m_m_systemMsg("Test System Status")
    ,m_m_windspeed(0.0)
{
    m_serialPort = new QSerialPort();

    foreach (const QSerialPortInfo &info, QSerialPortInfo::availablePorts()) {
        qDebug() << "Name        : "<< info.portName();
        qDebug() << "Description : "<< info.description();
        qDebug() << "Manufacturer: "<< info.manufacturer();
    }

    m_serialPort->setPortName("/dev/ttyS2");
    //serial->setPortName("COM5");
    m_serialPort->setBaudRate(QSerialPort:: Baud9600);
    m_serialPort->setDataBits(QSerialPort::Data8);
    m_serialPort->setParity(QSerialPort::NoParity);
    m_serialPort->setStopBits(QSerialPort::OneStop);
    m_serialPort->setFlowControl(QSerialPort::NoFlowControl);

    if (m_serialPort->open(QIODevice::ReadWrite))
    {
        qInfo() << "Serial communication opened";
        //const char *writeBuff="hello";
        //m_serialPort->write(writeBuff);
    }
    else
    {
        //Close the serial port
        //serial->clear();
        qInfo() << "Can't open connection";
        m_serialPort->close();
    }

    connect(m_serialPort, &QSerialPort::readyRead,this,&weather::handleReadyRead);

}

weather::~weather()
{
    //delete all objects : serial ...
    m_serialPort->clear();
    m_serialPort->close();
}

void weather::handleReadyRead()
{
    static unsigned int emptyIndex = 0;
    static unsigned int parseIndex = 0;
    bool pkgisvalid = false;

    buff.append(m_serialPort->read(17));

    if (buff.length()== 17)
    {

        for (int i = 0; i < buff.length(); i++)
        {
             Buffer[emptyIndex] = buff[i];
             emptyIndex = (emptyIndex + 1) < sizeof(Buffer) ? (emptyIndex + 1) : 0;
        }
        buff.clear();

        for (int i = 0; i < sizeof(Buffer); i++)
        {
            qDebug() << hex << static_cast<quint8>(Buffer[i]);
        }

        if (CalcSum(Buffer, sizeof(Buffer)) == static_cast<quint8>(Buffer[16]))
        {
           qDebug()  <<"package is correct";
            parsePackage(Buffer);
        }
        else
            qDebug()  <<"package is incorrect";

    }

}

unsigned char weather::CalcSum(unsigned char *pkg, int len)
{
    quint8 sum = 0;
    for (int i = 0; i < len-1; ++i) {
        sum += static_cast<quint8>(pkg[i]);
    }
    sum &= 0xFF;

    return sum;

}

void weather::parsePackage(unsigned char *Buffer)
{
    float value;
    setM_winddir(Buffer[2]);
    value = ((Buffer[3] << 8) | Buffer[4]) & 0x0FFF;
    value = (value - 400)/10 ;
    setM_temperature(value);
    qDebug() << "temp: "<< value;
    //value = Buffer[5];
    setM_humid(Buffer[5]);
    value =(Buffer[6]/8)*1.12;
    setM_windspeed(value);
    qDebug() << "humid: "<< Buffer[5];
    qDebug() << "wind direction: "<< Buffer[2];
    qDebug() << "wind speed: "<< value;
    value = ((Buffer[8] << 8) | Buffer[9]);
    value =value * 0.3;
    qDebug() << "rain fall acc: "<< value;
    setM_rainfall(value);
    value = ((Buffer[10] << 8) | Buffer[11]);
    setM_uv(value);
    qDebug() << "uv: "<< value << "uW/c㎡";
    uint32_t lvalue = ((Buffer[12] << 16) | Buffer[13] << 8 |Buffer[14]);
    lvalue = lvalue /10;
    qDebug() << "lux: "<< lvalue ;
    setM_lux(lvalue);
}


float weather::m_temperature() const
{
    return m_m_temperature;
}

void weather::setM_temperature(float newM_temperature)
{
    if (m_m_temperature == newM_temperature)
        return;
    m_m_temperature = newM_temperature;
    emit m_temperatureChanged();
}

float weather::m_humid() const
{
    return m_m_humid;
}

void weather::setM_humid(float newM_humid)
{
    if (qFuzzyCompare(m_m_humid, newM_humid))
        return;
    m_m_humid = newM_humid;
    emit m_humidChanged();
}

int weather::m_winddir() const
{
    return m_m_winddir;
}

void weather::setM_winddir(int newM_winddir)
{
    if (m_m_winddir == newM_winddir)
        return;
    m_m_winddir = newM_winddir;
    emit m_winddirChanged();
}

float weather::m_rainfall() const
{
    return m_m_rainfall;
}

void weather::setM_rainfall(float newM_rainfall)
{
    if (qFuzzyCompare(m_m_rainfall, newM_rainfall))
        return;
    m_m_rainfall = newM_rainfall;
    emit m_rainfallChanged();
}

float weather::m_uv() const
{
    return m_m_uv;
}

void weather::setM_uv(float newM_uv)
{
    if (qFuzzyCompare(m_m_uv, newM_uv))
        return;
    m_m_uv = newM_uv;
    emit m_uvChanged();
}

float weather::m_lux() const
{
    return m_m_lux;
}

void weather::setM_lux(float newM_lux)
{
    if (qFuzzyCompare(m_m_lux, newM_lux))
        return;
    m_m_lux = newM_lux;
    emit m_luxChanged();
}

QString weather::m_systemMsg() const
{
    return m_m_systemMsg;
}

void weather::setM_systemMsg(const QString &newM_systemMsg)
{
    if (m_m_systemMsg == newM_systemMsg)
        return;
    m_m_systemMsg = newM_systemMsg;
    emit m_systemMsgChanged();
}

float weather::m_windspeed() const
{
    return m_m_windspeed;
}

void weather::setM_windspeed(float newM_windspeed)
{
    if (m_m_windspeed == newM_windspeed)
        return;
    m_m_windspeed = newM_windspeed;
    emit m_windspeedChanged();
}
