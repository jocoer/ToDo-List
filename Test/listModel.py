from PySide2.QtCore import QAbstractListModel, QModelIndex, QObject, Qt, Signal, Slot
from task import Task
from box import Box

"""任务数据类"""
class TaskModel (QAbstractListModel):
    _name = Qt.UserRole + 1
    _description = Qt.UserRole + 2
    _finish = Qt.UserRole + 3

    def __init__ (self):
        QAbstractListModel.__init__ (self)
        self._data = []
        self._role_names = {}

    def rowCount (self, parent = None) -> int:
        return len (self._data)

    def data (self, index, role):
        if not index.isValid():
            return Task ()
        t = self._data[index.row()]
        if (role == self._name):
            return t.name
        elif (role == self._description):
            return t.describe
        elif role == self._finish:
            return t.finished
        else:
            return ""

    def roleNames(self):
        return {
            self._name: b'taskName',
            self._description: b'taskDesc',
            self._finish: b'finish'
        }


    # @Slot ()
    # def taskCount (self):
    #     count = 0
    #     for t in self._data:
    #         count += 1
    #     print (f"task count: {count}")

    # @Slot (str)
    # def addTask (self, name):
    #     self.beginInsertRows (QModelIndex (), self.rowCount(), self.rowCount())
    #     t = Task (name)
    #     self._data.append (t)
    #     self.endInsertRows ()

    # @Slot() 
    # def clearTask(self): 
    #     self.beginRemoveRows(QModelIndex(), 0, self.rowCount()) 
    #     self._data.clear ()
    #     self.endRemoveRows() 

    # @Slot (str, int)
    # def editTaskName (self, name, index):
    #     ix = self.index (index, 0)
    #     self._data[index].name = name
    #     self.dataChanged.emit (ix, ix, self.roleNames())

"""任务盒数据类"""
class BoxModel (QAbstractListModel):
    Name_Role = Qt.UserRole + 1
    def __init__ (self):
        QAbstractListModel.__init__ (self)
        self._data= [] 
        self._role_names = {}
        # role-names
        self._role_names[self.Name_Role] = "dmBox"

    def rowCount (self, parent = None) -> int:
        return len (self._data)

    def data (self, index, role):
        if not index.isValid():
            return Box ()
        b = self._data[index.row()]
        if (role == self.Name_Role):
            return b.getName ()

    def roleNames(self):
        return {
            self.Name_Role: b'dmBox',
        }


"""顶层数据类"""
class Backend (QObject):
    def __init__ (self):
        QObject.__init__ (self)
        self.boxModel = BoxModel ()
        self.taskModel = TaskModel ()

    # 改变当前选中的任务盒
    @Slot (int)
    def changeBox (self, index:int):
        self.taskModel.beginResetModel ()
        self.taskModel._data = self.boxModel._data[index].tasks
        self.taskModel.endResetModel ()

    # 添加任务盒
    @Slot (str)
    def addBox (self, name):
        self.boxModel.beginInsertRows (QModelIndex (), self.boxModel.rowCount(), self.boxModel.rowCount())
        newBox = Box ()
        newBox.name = name
        self.boxModel._data.append (newBox)
        self.boxModel.endInsertRows ()

    # 添加任务
    @Slot (int, str)
    def addTask (self, boxIndex:int, name:str):
        self.taskModel.beginInsertRows (QModelIndex(), self.taskModel.rowCount (), self.taskModel.rowCount ())
        newTask = Task (name)
        self.boxModel._data[boxIndex].tasks.append (newTask)
        self.taskModel.endInsertRows ()

    # 修改任务盒名称
    @Slot (int, str)
    def editBox (self, boxIndex:int, name:str):
        ix = self.boxModel.index (boxIndex, 0)
        self.boxModel._data[boxIndex].name = name
        self.boxModel.dataChanged.emit (ix, ix, self.boxModel.roleNames())

    # 修改任务相关信息
    """
        flag:
            0 -> 修改任务名称
            1 -> 修改任务完成情况
    """
    @Slot (int, int, str, int)
    def editTask (self, boxIndex:int, taskIndex:int, text:str, flag:int):
        ix = self.taskModel.index (taskIndex, 0)
        if flag == 0:
            self.boxModel._data[boxIndex].tasks[taskIndex].name = text
        elif flag == 1:
            finish = eval (text)
            self.boxModel._data[boxIndex].tasks[taskIndex].finished = bool (finish)

        self.taskModel.dataChanged.emit (ix, ix, self.taskModel.roleNames())

    # 删除任务
    @Slot (int, int)
    def removeTask (self, boxIndex:int, taskIndex:int):
        print (f"boxIndex:{boxIndex}, taskIndex: {taskIndex}")
        self.taskModel.beginRemoveRows (QModelIndex(), taskIndex, taskIndex)
        del self.boxModel._data[boxIndex].tasks[taskIndex]
        self.taskModel.endRemoveRows ()
