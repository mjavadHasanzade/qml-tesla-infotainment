#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <Controllers/system.h>
#include <Controllers/hvachandler.h>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    System *m_system = new System(&app);
    engine.rootContext()->setContextProperty("systemHandler", m_system);

    HVACHandler *m_driverHAVCHandler = new HVACHandler(&app);
    engine.rootContext()->setContextProperty("driverHVAC", m_driverHAVCHandler);

    HVACHandler *m_passengerHAVCHandler = new HVACHandler(&app);
    engine.rootContext()->setContextProperty("passengerHVAC", m_passengerHAVCHandler);

    engine.loadFromModule("Tesla_Infotainment", "Main");
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
