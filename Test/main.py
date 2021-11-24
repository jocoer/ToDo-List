from box import Box
from task import Task
from listModel import BoxModel, TaskModel, Backend

import sys
from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtCore import QObject, QStringListModel,Slot, Signal, QAbstractListModel, QModelIndex, Qt

"""边界类"""
# class MainWindow (QObject):
#     def __init__ (self):
#         QObject.__init__ (self)

#         self.boxes = []

#     def addBox (self, b):
#         self.boxes.append (b)
        
if __name__ == "__main__":
    # data
    my_model = BoxModel ()
    b = Box ()
    # task = Task ("chong")
    # b.add_task (task)
    b.name = "Box1"
    b.add_task (Task ("task1"))
    my_model._data.append (b)
    b1 = Box ()
    b1.name = "box2"
    my_model._data.append (b1)

    tasks = TaskModel ()
    tasks._data = b.tasks

    back = Backend ()
    back.taskModel = tasks
    back.boxModel = my_model
    # tasks._data = my_model.getData (0)
    # tasks = b.tasks[0]


    app = QGuiApplication (sys.argv)

    engine = QQmlApplicationEngine ()

    # Expose
    engine.rootContext().setContextProperty ("myModel", back.boxModel)
    engine.rootContext().setContextProperty ("tasks", back.taskModel)
    engine.rootContext().setContextProperty ("backend", back)
    
    engine.quit.connect (app.quit)
    engine.load ("../qml/interface.qml")

    sys.exit (app.exec_ ())
