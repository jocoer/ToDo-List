from listModel import BoxModel
import shelve
import pickle

class FileOp:
    def __init__(self) -> None:
        self.filePath = "/home/joco/.Todo/data"
        pass

    def createBox (self, filePath:str="") -> BoxModel:
        """从文件中读取数据生成一个Box"""
        if (filePath == ""):
            filePath = self.filePath
        f = open (filePath, 'rb')
        obj = pickle.load (f)
        f.close ()
        model = BoxModel ()
        model._data = obj
        return model

    def save (self, b:BoxModel, filePath:str="") -> None:
        """保存box对象到本地"""
        if (filePath == ""):
            filePath = self.filePath
        f = open (filePath, 'wb')
        pickle.dump (b._data, f)
        print ("保存")
        f.close ()
"""
[
    {
        name: box1,
        tasks: [
            {
                name: task1,
                finish: False,
                desc: xxxxxxxx,
            }
            {
                name: task2
                finish: True,
                desc: xxxxxxxx,
            }
        ] 
    }
    {
        name: box2,
        tasks: [
            {
                name: task1,
                finish: False,
                desc: xxxxxxxx,
            }
            {
                name: task2
                finish: True,
                desc: xxxxxxxx,
            }
        ] 

    }
]

"""