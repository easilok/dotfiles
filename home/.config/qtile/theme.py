##### BAR COLORS #####
colors =    [["#292D3E", "#292D3E"], # panel background
            ["#434758", "#434758"], # background for current screen tab
            ["#D0D0D0", "#D0D0D0"], # font color for group names
            ["#F07178", "#F07178"], # background color for layout widget
            ["#000000", "#000000"], # background for other screen tabs
            ["#AD69AF", "#AD69AF"], # dark green gradiant for other screen tabs
            ["#C3E88D", "#C3E88D"], # background color for network widget
            ["#C792EA", "#C792EA"], # background color for pacman widget
            ["#9CC4FF", "#9CC4FF"], # background color for cmus widget
            ["#000000", "#000000"], # background color for clock widget
            ["#434758", "#434758"]] # background color for systray widget


def init_layout_theme():
    return {"border_width": 2,
            "margin": 1,
            "border_focus": "8581a0",
            "border_normal": "000000"
           }

def init_border_args():
    return {"border_width": 2}
