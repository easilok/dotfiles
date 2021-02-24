import os
import socket
import psutil

from libqtile import layout, bar, widget
from libqtile.config import Screen
from libqtile.widget import Spacer
from libqtile.widget.memory import Memory
from libqtile.widget.windowname import WindowName
from os.path import expanduser
from tidal import Tidal
home = expanduser("~")
textFont = "Roboto"
textFontsize = 10
iconFont = "FontAwesome"
iconFontsize = 10
# Separator Height in Percentage 
separatorHeight = 80
separatorPadding = 7
separatorLineWidth = 1

from theme import colors

class MyMemory(Memory):
    def poll(self):
        mem = psutil.virtual_memory()
        # swap = psutil.swap_memory()
        val = {}
        val["MemUsed"] = mem.used // 1024 // 1024
        val["MemTotal"] = mem.total // 1024 // 1024
        val["MemFree"] = mem.free // 1024 // 1024
        # val["Buffers"] = mem.buffers // 1024 // 1024
        # val["Active"] = mem.active // 1024 // 1024
        # val["Inactive"] = mem.inactive // 1024 // 1024
        # val["Shmem"] = mem.shared // 1024 // 1024
        # val["SwapTotal"] = swap.total // 1024 // 1024
        # val["Swapfree"] = swap.free // 1024 // 1024
        # val["SwapUsed"] = swap.used // 1024 // 1024
        # val["MemPerc"] = (mem.total - mem.free) * 100 // mem.total
        val["MemPerc"] = mem.used * 100 // mem.total
        return self.format.format(**val)

class MyWindowsCount(WindowName):
    def __init__(self, width=bar.CALCULATED, **config):
        WindowName.__init__(self, width, **config)
        self.text = "0"

    def update(self, *args):
        try:
            self.text = str(len(self.bar.screen.group.windows))
        except:
            self.text = "0"
        self.bar.draw()

def ComputerHasBattery():
    try:
        return psutil.sensors_battery() != None
    except:
        return False

def init_widgets_defaults():
    return dict(font=textFont,
                fontsize = textFontsize,
                padding = 1,
                background=colors[0])

def init_default_widget():
    widgets_list = [
        widget.CurrentLayout(),
        widget.GroupBox(),
        widget.Prompt(),
        widget.WindowName(),
        widget.Chord(
            chords_colors={
                'launch': ("#ff0000", "#ffffff"),
            },
            name_transform=lambda name: name.upper(),
        ),
        widget.TextBox("default config", name="default"),
        widget.TextBox("Press &lt;M-r&gt; to spawn", foreground="#d75f5f"),
        widget.Systray(),
        widget.Clock(format='%Y-%m-%d %a %I:%M %p'),
        widget.QuickExit(),
    ]
    return widgets_list

def init_widgets_list():
    prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())
    widgets_list = [
        widget.GroupBox(font=iconFont,
                        fontsize = iconFontsize,
                        margin_y = 2,
                        margin_x = 0,
                        padding_y = 1,
                        padding_x = 3,
                        borderwidth = 0,
                        active = colors[6],
                        inactive = colors[3],
                        # selected = colors[4],
                        disable_drag = True,
                        rounded = False,
                        highlight_method = "text",
                        use_mouse_wheel= False,
                        urgent_alert_method = "line",
                        urgent_border = colors[4],
                        urgent_text = colors[4],
                        this_current_screen_border = colors[1],
                        this_screen_border = colors [4],
                        #other_current_screen_border = colors[0],
                        #other_screen_border = colors[0],
                        foreground = colors[2],
                        background = colors[0]
                        ),
        widget.Sep(
            linewidth = separatorLineWidth,
            padding = separatorPadding,
            size_percent = separatorHeight,
            foreground = colors[2],
            background = colors[0]
        ),
        widget.CurrentLayout(
            font=textFont,
            fontsize=textFontsize,
            foreground = colors[2],
            background = colors[0],
        ),
        widget.Sep(
            linewidth = separatorLineWidth,
            padding = separatorPadding,
            size_percent = separatorHeight,
            foreground = colors[2],
            background = colors[0]
        ),
        MyWindowsCount(
            font=textFont,
            fontsize=textFontsize,
            foreground = colors[2],
            background = colors[0],
        ),
        widget.Sep(
            linewidth = separatorLineWidth,
            padding = separatorPadding,
            size_percent = separatorHeight,
            foreground = colors[2],
            background = colors[0]
        ),
        widget.WindowName(
            width=bar.STRETCH,
            font=textFont,
            fontsize=textFontsize,
            foreground = colors[2],
            background = colors[0],
        ),
        Tidal(
            scriptPath='/home/luis/.config/qtile/scripts/get-playing',
            font=textFont,
            fontsize=textFontsize,
            foreground = colors[2],
            background = colors[0],
            update_interval = 2,
        ),
        widget.Sep(
            linewidth = separatorLineWidth,
            padding = separatorPadding,
            size_percent = separatorHeight,
            foreground = colors[2],
            background = colors[0]
        ),
    ]
    # Check if battery exists
    hasBattery = ComputerHasBattery()

    if hasBattery:
        widgets_list = widgets_list + [
            widget.Battery(
                font=iconFont,
                fontsize=iconFontsize,
                charge_char='',
                discharge_char='',
                empty_char='',
                full_char='',
                format="{char} {percent:2.0%}",
                update_interval = 10,
                foreground=colors[2],
                background=colors[0],
            ),
            widget.Sep(
                linewidth = separatorLineWidth,
                padding = separatorPadding,
                size_percent = separatorHeight,
                foreground = colors[2],
                background = colors[0]
            ),
        ]

    widgets_list = widgets_list + [
        widget.TextBox(
            font=iconFont,
            fontsize=iconFontsize,
            text=" ",
            foreground=colors[2],
            background=colors[0],
        ),
        widget.Volume(
            font=textFont,
            fontsize=textFontsize,
            foreground = colors[2],
            background = colors[0],
        ),
        widget.Sep(
            linewidth = separatorLineWidth,
            padding = separatorPadding,
            size_percent = separatorHeight,
            foreground = colors[2],
            background = colors[0]
        ),
        widget.KeyboardLayout(
            configured_keyboards = "[us, pt]",
            font=textFont,
            fontsize=textFontsize,
            foreground = colors[2],
            background = colors[0],
        ),
        widget.Sep(
            linewidth = separatorLineWidth,
            padding = separatorPadding,
            size_percent = separatorHeight,
            foreground = colors[2],
            background = colors[0]
        ),
        widget.TextBox(
            font=iconFont,
            fontsize=iconFontsize,
            text=" ",
            foreground=colors[2],
            background=colors[0],
        ),
        widget.CPU(
            font=textFont,
            fontsize=textFontsize,
            format = '{load_percent}%',
            update_interval = 5,
            foreground = colors[2],
            background = colors[0],
        ),
        widget.TextBox(
            font=iconFont,
            fontsize=iconFontsize,
            text=" ",
            foreground=colors[2],
            background=colors[0],
        ),
        MyMemory(
            font=textFont,
            fontsize=textFontsize,
            format = '{MemPerc}%',
            update_interval = 5,
            foreground = colors[2],
            background = colors[0],
        ),
        widget.TextBox(
            font=iconFont,
            fontsize=iconFontsize,
            text=" ",
            foreground=colors[2],
            background=colors[0],
        ),
        widget.ThermalSensor(
            font=textFont,
            fontsize=textFontsize,
            format = '',
            # tag_sensor = 'temp0',
            update_interval = 5,
            foreground = colors[2],
            background = colors[0],
        ),
        widget.Sep(
            linewidth = separatorLineWidth,
            padding = separatorPadding,
            size_percent = separatorHeight,
            foreground = colors[2],
            background = colors[0]
        ),
        widget.Clock(
            font = textFont,
            fontsize = textFontsize,
            foreground = colors[2],
            background = colors[0],
            format="%d/%b - %H:%M"
        ),
        widget.Sep(
            linewidth = separatorLineWidth,
            padding = separatorPadding,
            size_percent = separatorHeight,
            foreground = colors[2],
            background = colors[0]
        ),
        widget.Systray(
            background=colors[0],
        ),
        ]
    return widgets_list

def init_screens():
    # return [Screen(top=bar.Bar(widgets=init_default_widget(), opacity=0.95, size=20))]
    return [Screen(top=bar.Bar(widgets=init_widgets_list(), opacity=0.95, size=18))]
