#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <Controllers/system.h>


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

    engine.loadFromModule("Tesla_Infotainment", "Main");
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
