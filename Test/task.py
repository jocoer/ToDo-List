class Task:
    def __init__(self, name):
        self.name = name
        self.describe = ""
        
    def set_describe (self, desc):
        self.describe = desc