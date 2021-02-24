import subprocess
from libqtile.widget import base

__all__ = ["Tidal"]


class Tidal(base.ThreadedPollText):
    """Displays Tidal current play

    """

    orientations = base.ORIENTATION_HORIZONTAL
    defaults = [
        ("update_interval", 1.0, "Update interval for the text"),
    ]

    def __init__(self, scriptPath = None, **config):
        super().__init__(**config)
        self.scriptPath = scriptPath
        self.add_defaults(Tidal.defaults)

    def tick(self):
        self.update(self.poll())
        return self.update_interval

    def poll(self):
        if self.scriptPath == None:
            return ""
        try:
            processResult = subprocess.run(self.scriptPath, stdout=subprocess.PIPE)
        except:
            processResult = None

        if processResult != None:
            return processResult.stdout.decode("utf-8").strip()
        return ""
