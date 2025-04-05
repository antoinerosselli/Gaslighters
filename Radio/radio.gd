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
