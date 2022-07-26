from PySide2.QtCore import QObject,Slot, Signal, QTimer
import requests
# from bs4 import BeautifulSoup
from playsound import playsound

import json
import requests
import vlc, time

class Clock (QObject):
    def __init__ (self):
        QObject.__init__ (self)
        self.min = 0
        self.second = 0
        self.isRunning = False
        self.timer = QTimer ()
        self.timer.timeout.connect (lambda: self.updateClock ())
        self.englishSentence = "" 
        self.chineseSentence = ""
        self.catchSen ()

    printClock = Signal (str, str)
    def updateClock (self):
        self.second = (self.second + 59) % 60
        if (self.second == 59):
            self.min = self.min - 1
        if (self.min == -1):
            # 结束计时
            self.pause ()
            self.warning ()
            return
        secondStr = ""
        if self.second < 10:
            secondStr = "0" + str (self.second)
        else:
            secondStr = str (self.second)
        self.printClock.emit (str(self.min), secondStr)

    @Slot ()
    def start (self):
        self.timer.start (1000) # ms
        self.isRunning = True

    @Slot ()
    def pause (self):
        self.timer.stop ()
        self.isRunning = False

    @Slot (str, str)
    def setClock (self, min:str, second:str):
        self.min = int (min)
        self.second = int (second)

    setState = Signal (int)
    @Slot ()
    def getState (self): 
        self.setState.emit (int (self.isRunning))

    setSentence = Signal (str, str)
    @Slot ()
    def getSentence (self):
        self.setSentence.emit (self.englishSentence, self.chineseSentence)

    # 爬取爱词霸每日鸡汤
    def catchSen (self):
        url = 'http://open.iciba.com/dsapi/' # 词霸免费开放的jsonAPI接口
        r = requests.get(url) 
        all = json.loads(r.text) # 获取到json格式的内容，内容很多
        # print(all) # json内容，通过这行代码来确定每日一句的键名
        Englis = all['content'] # 提取json中的英文鸡汤
        Chinese = all['note'] # 提取json中的中文鸡汤
        self.englishSentence = Englis
        self.chineseSentence = Chinese
 
    # 倒计时结束，响声
    def warning (self):
        print ("播放开始")
        player = vlc.MediaPlayer("../music/alarm.mp3")
        player.play ()
        time.sleep (3)
        player.stop ()