from box import Box
from task import Task
from listModel import BoxModel, TaskModel, Backend
from fileop import FileOp

import sys
from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtCore import QObject, QStringListModel,Slot, Signal, QAbstractListModel, QModelIndex, Qt

if __name__ == "__main__":

    f = FileOp ()
    model = f.createBox ()
    back = Backend ()
    back.boxModel = model

    app = QGuiApplication (sys.argv)

    engine = QQmlApplicationEngine ()

    # Expose
    engine.rootContext().setContextProperty ("myModel", back.boxModel)
    engine.rootContext().setContextProperty ("tasks", back.taskModel)
    engine.rootContext().setContextProperty ("backend", back)
    
    engine.quit.connect (app.quit)
    engine.load ("../qml/interface.qml")

    returnState = app.exec_ ()
    f.save (back.boxModel)
    sys.exit (returnState)
