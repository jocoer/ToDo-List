class Task:
    def __init__(self, name):
        self.name = name
        self.describe = ""
        self.finished = False
        
    def set_describe (self, desc):
        self.describe = desc