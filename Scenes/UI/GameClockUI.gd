extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var year_label = $MarginContainer/VBoxContainer/HBoxContainer/Year
onready var month_label = $MarginContainer/VBoxContainer/HBoxContainer/Month
onready var day_label = $MarginContainer/VBoxContainer/HBoxContainer/Day
onready var weekd_label = $MarginContainer/VBoxContainer/HBoxContainer2/Weekday
onready var time_label = $MarginContainer/VBoxContainer/HBoxContainer2/Time


# Called when the node enters the scene tree for the first time.
func _ready():
	var error = []
	error.append(GameClock.connect("minute_tick", self, "_update_ui"))
	error.append(GameClock.connect("hour_tick", self, "_update_ui"))
	error.append(GameClock.connect("day_end", self, "_update_ui"))
	error.append(GameClock.connect("month_end", self, "_update_ui"))
	error.append(GameClock.connect("year_end",self, "_update_ui"))
	for e in error:
		if e:
			print_debug(e)
	_update_ui()

func _update_ui():
	var current_date = GameClock._get_current_date(false)
	year_label.set_text(str(current_date["Year"]))
	month_label.set_text(GameClock.Months[current_date["Month"]].left(3))
	day_label.set_text(str(current_date["Day"]))
	weekd_label.set_text(GameClock.Days[current_date["Weekday"]].left(3))
	time_label.set_text(GameClock._get_time(true))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
