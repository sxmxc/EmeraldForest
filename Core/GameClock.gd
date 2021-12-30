extends Node

var Months = {
	1: "January",
	2: "February", 
	3: "March",
	4: "April", 
	5: "May",
	6: "June", 
	7: "July", 
	8: "August",
	9: "September", 
	10: "October", 
	11: "November", 
	12: "December"	
}

var Days = {
	1: "Monday",
	2: "Tuesday",
	3: "Wednesday",
	4: "Thursday",
	5: "Friday", 
	6: "Saturday", 
	7: "Sunday"
}

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var game_clock = null
var time_paused = true

var second_scale = 8.6
var minute_interval = 10

var months_in_year = 12
var weeks_in_month = 4
var days_in_week =  7
var days_in_month = 28
var hours_in_day = 24
var mins_in_hour = 60
var secs_in_min = 60

var current_date = {"Year" : 2021, "Month": 1, "Week": 1, "Day": 1 ,"Weekday": 1, "Hour" : 7, "Minutes": 0, "Seconds":0 }


signal tick
signal minute_tick
signal hour_tick
signal midnight
signal day_end
signal month_end
signal year_end
signal safety_meeting
signal four_twenty_bb


# Called when the node enters the scene tree for the first time.
func _ready():
	Console.add_command('pause_gameclock', self, '_set_gameclock_pause')\
		.set_description('Pauses and unpauses gameclock')\
		.add_argument('value', TYPE_BOOL)\
		.register()
	pause_mode = Node.PAUSE_MODE_PROCESS
	game_clock = Timer.new()
	add_child(game_clock)
	
	var error = game_clock.connect("timeout", self, "_on_gameclock_tick")
	if error: 
		print_debug(error)
	game_clock.set_wait_time(1.0)
	game_clock.set_one_shot(false)
	game_clock.start()
	_pause_game_clock()

func _set_gameclock_pause(value: bool = true):
	if value == null:
		Console.write_line("Please provide true or false as argument")
		return
	game_clock.set_paused(value)
	Console.write_line("Gameclock Paused: " + str(game_clock.is_paused()))
	
	
func _reset_game_clock():
	current_date.clear()
	current_date = {"Year" : 2021, "Month": 1, "Week": 1, "Day": 1 ,"Weekday": 1, "Hour" : 7, "Minutes": 0, "Seconds":0 }
	
func _pause_game_clock():
	game_clock.set_paused(true)
	time_paused = true

func _resume_game_clock():
	game_clock.set_paused(false)
	time_paused = false

func _get_time(format):
	if(format):
		#12hour format
		#is it midnight?
		if current_date.Hour == 24:
			var string = "%d:%02d " + "AM"
			var formatted = string % [12, current_date.Minutes]
			return formatted
		var hours
		var post
		hours = current_date.Hour  if current_date.Hour <= 12 else current_date.Hour - 12
		post = "AM" if current_date.Hour < 12 else "PM"
		var string = "%d:%02d " + post
		var formatted = string % [hours, current_date.Minutes]
		return formatted
	else:
		#24hour format
		var string = "%02d:%02d"
		return string % [current_date.Hour,current_date.Minutes]
		
func _get_current_date(stringify):
	if (stringify):
		var val = "Current Game Time \nYear: %s, Month: %s, Week %s, Day: %s\n%s %02d:%02d:%02d" 
		var val_format = val % [current_date["Year"],Months[current_date["Month"]],current_date["Week"],current_date["Day"],Days[current_date["Weekday"]],current_date["Hour"],current_date["Minutes"],current_date["Seconds"]]
		return val_format
	else:
		return current_date
	
func _on_gameclock_tick():
	emit_signal("tick")
	current_date["Seconds"] += 1 * second_scale
	
	if current_date["Seconds"] >= secs_in_min:
		current_date["Minutes"] += 1 * minute_interval
		current_date["Seconds"] = 0
		emit_signal("minute_tick")
		if current_date["Minutes"] >= mins_in_hour:
			current_date["Hour"] += 1
			current_date["Minutes"] = 0
			emit_signal("hour_tick")
			if current_date["Hour"] >= hours_in_day:
				current_date["Day"] += 1
				current_date["Weekday"] += 1
				current_date["Hour"] = 0
				emit_signal("day_end")
				if current_date["Weekday"] >= days_in_week:
					current_date["Week"] += 1
					current_date["Weekday"] = 1
					if current_date["Week"] >= weeks_in_month:
						current_date["Week"] = 1
						if current_date["Day"] >= days_in_month:
							current_date["Month"] += 1
							current_date["Day"] = 1
							emit_signal("month_end")
							if current_date["Month"] >= months_in_year:
								current_date["Year"] += 1
								current_date["Month"]= 1
								emit_signal("year_end")
		if Global.debug:
			Print.clear_console()
			Print.line(Print.BLUE,_get_current_date(true))
		if current_date.Hour == 0:
			emit_signal("midnight")
		if current_date.Day == 20 && current_date.Month == 4:
			emit_signal("four_twenty_bb")
		if current_date.Hour == 16 && current_date.Minutes == 20:
			emit_signal("safety_meeting")	
	if Global.debug:
		Print.line(Print.YELLOW,"game_clock tick")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
