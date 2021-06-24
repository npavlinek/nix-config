#!/usr/bin/env python3

def get_total_seconds():
    with open('/proc/uptime') as f:
        uptime = f.read().split(' ')[0]
    return float(uptime)

if __name__ == '__main__':
    seconds_in_day = 86400
    seconds_in_hour = 3600
    seconds_in_minute = 60

    total_seconds_uptime = get_total_seconds()

    days = int(total_seconds_uptime / seconds_in_day)
    if days > 0:
        total_seconds_uptime -= days * seconds_in_day

    hours = int(total_seconds_uptime / seconds_in_hour)
    if hours > 0:
        total_seconds_uptime -= hours * seconds_in_hour

    minutes = int(total_seconds_uptime / seconds_in_minute)
    if minutes > 0:
        total_seconds_uptime -= minutes * seconds_in_minute

    seconds = int(total_seconds_uptime)

    if days > 0:
        print("+{} {:02}:{:02}:{:02}".format(days, hours, minutes, seconds))
    else:
        print("{:02}:{:02}:{:02}".format(hours, minutes, seconds))
