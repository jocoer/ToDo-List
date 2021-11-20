from PySide2.QtCore import QAbstractListModel, QModelIndex, Qt, Signal, Slot
from task import Task
from box import Box

class TaskModel (QAbstractListModel):
    _name = Qt.UserRole + 1
    _description = Qt.UserRole + 2

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

        return "1"
    def roleNames(self):
        return {
            self._name: b'taskName',
            self._description: b'taskDesc'
        }

    @Slot ()
    def taskCount (self):
        count = 0
        for t in self._data:
            count += 1
        print (f"task count: {count}")

    @Slot (str)
    def addTask (self, name):
        self.beginInsertRows (QModelIndex (), self.rowCount(), self.rowCount())
        t = Task (name)
        self._data.append (t)
        self.endInsertRows ()

    @Slot() 
    def clearTask(self): 
        self.beginRemoveRows(QModelIndex(), 0, self.rowCount()) 
        self._data.clear ()
        self.endRemoveRows() 

"""数据类"""
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

    def getBoxName (self, b) -> str:
        """获取当前任务盒的名称"""
        return b.getName ()

    addtask = Signal (str, str)
    # gotTask = Signal (str, str)
    @Slot (int)
    def getTasks (self, index):
        ts = self._data [index].tasks
        count = 0
        for t in ts:
            print ("get task")
            count += 1
            self.addtask.emit (t.name, t.describe)
        print (f"count: {count}")

    def data (self, index, role):
        if not index.isValid():
            return Box ()
        b = self._data[index.row()]
        if (role == self.Name_Role):
            return self.getBoxName (b)

    def roleNames(self):
        return {
            self.Name_Role: b'dmBox'
        }

    @Slot (str)
    def addBox (self, name):
        self.beginInsertRows (QModelIndex (), self.rowCount(), self.rowCount())
        b = Box ()
        b.name = name
        self._data.append (b)
        self.endInsertRows ()

    @Slot (int, str, str)
    def addTask (self, index, name, desc):
        print ("add")
        t = Task (name)
        t.describe = desc
        self._data[index].add_task(t)

    def getData (self, index:int) -> TaskModel:
        return self._data[index]