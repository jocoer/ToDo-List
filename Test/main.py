from box import Box
from task import Task

import sys
from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine

if __name__ == "__main__":
    # tb = Box ()
    # tb.add_task (Task ("task"))

    app = QGuiApplication (sys.argv)

    engine = QQmlApplicationEngine ()
    engine.quit.connect (app.quit)
    engine.load ("../qml/interface.qml")

    sys.exit (app.exec_ ())
