from box import Box
from listModel import Backend
from fileop import FileOp
from clock import Clock

import sys
from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine



if __name__ == "__main__":

    f = FileOp ()
    model = f.createBox ()
    back = Backend ()
    back.boxModel = model
    clock = Clock ()

    app = QGuiApplication (sys.argv)

    engine = QQmlApplicationEngine ()

    # Expose
    engine.rootContext().setContextProperty ("myModel", back.boxModel)
    engine.rootContext().setContextProperty ("tasks", back.taskModel)
    engine.rootContext().setContextProperty ("backend", back)
    engine.rootContext().setContextProperty ("clock", clock)
    
    engine.quit.connect (app.quit)
    engine.load ("../qml/interface.qml")

    returnState = app.exec_ ()
    f.save (back.boxModel)
    sys.exit (returnState)
