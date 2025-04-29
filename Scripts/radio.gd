extends Node

enum Frequency {
	Static, #0
	Gov, #1
	Belle, #2
	Indy, #3
	Song #4
}

var value :float = 0.0
var frequency :Frequency = Frequency.Static
var display1 :String = str("0.00")
var display2 :String = str("FM")

func cmpFrequency():
	if (value > 54 && value < 64):
		frequency = Frequency.Gov
	if (value > 22 && value < 32):
		frequency = Frequency.Belle
	if (value > 76 && value < 86):
		frequency = Frequency.Indy
	if (value > 5 && value < 20):
		frequency = Frequency.Song
	else:
		frequency = Frequency.Static

func getValue():
	return value

func getFrequency():
	cmpFrequency()
	return frequency

func setValue(n):
	value = n
	setDisplay(1, str(value).pad_decimals(2))

func getDisplay(display_nb: int):
	var toReturn :String = ""
	match display_nb: # switch case en mieux!
		1:
			toReturn = display1
		2:
			toReturn = display2
	
	return toReturn

func setDisplay(nb: int, content: String):
	match nb:
		1:
			display1 = content
		2:
			display2 = content
