import task

class Box():
    def __init__(self):
        self.tasks = []
        self.name = "box"

    def add_task (self, t):
        """添加任务到任务盒中"""
        self.tasks.append (t)

    def del_task (self, index):
        """按照索引删除对应的任务"""
        del self.tasks [index]

    def getName (self):
        return self.name
