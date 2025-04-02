extends Node

var time_elapsed:int = 0

#gouv
var gouv_color = Color(0.117647, 0.564706, 1, 1)
var gouv_time = 0

#belle
var belle_color = Color(1, 0.0784314, 0.576471, 1)
var belle_time = 0

#Fanatic
var Fanatic_color = Color(0.545098, 0, 0, 1)
var Fanatic_time = 0

var played_messages = {}  # Dictionnaire pour stocker les messages déjà joués

var ones: bool = false

func _process(delta):
	if ones == false:
		if Radio.getValue() > 54 and Radio.getValue() < 64 :
			Tools.start_the_day()
			ones = true

func _on_timer_timeout():
	time_elapsed += 1  # Incrémente le temps écoulé chaque seconde
	check_radio_conditions()

func play_radio_message(file_path, text, duration, color, sender, what_cd):
	if text in played_messages:  # Vérifie si le message a déjà été joué
		return  # Si oui, on ne le rejoue pas
	
	radio_event_adv(file_path, text, duration, color, sender, what_cd)  # Joue le message
	played_messages[text] = true  # Marque ce message comme "joué"


func radio_event_adv(sound, text, time_text, color_ok, what_fm, what_cd):
	Tools.set_radio_sound(1,load(sound))
	Tools.radio_text(text,time_text,color_ok)
	Tools.add_journal(text, color_ok)
	Tools.unlock_fm(what_fm)
	if what_fm == "gouv":
		if what_cd != 0:
			gouv_time = time_elapsed + what_cd
	elif what_fm == "belle":
		if what_cd != 0:
			belle_time = time_elapsed + what_cd
	elif what_fm == "fanatic":
		if what_cd != 0:
			Fanatic_time = time_elapsed + what_cd

func check_radio_conditions():
	var radio_value = Radio.getValue()
	#gouv radio ==>
	#change voice ALL !!
	if time_elapsed >= 0 and time_elapsed <= 70:
		if Radio.getFrequency() == 1 :
			play_radio_message("res://voice/day1/gov/1. Official government communication.wav", "Alert! An attack has taken place on one of our gas reserve sites.", 5, gouv_color, "gouv", 6)
		if Radio.getFrequency() == 1 and time_elapsed > gouv_time:
			play_radio_message("res://voice/day1/gov/2. Accident.wav", "Poisonous gases have invaded the streets, stay at home", 5, gouv_color, "gouv", 6)
		if Radio.getFrequency() == 1 and time_elapsed > gouv_time:
			play_radio_message("res://voice/day1/gov/3. Citizens stay home.wav", "To communicate with us, access the secure room using the button at the end of the corridor.", 5, gouv_color,"gouv", 0)
	if time_elapsed >= 90 and time_elapsed <= 120:
		if Radio.getFrequency() == 1 :
			play_radio_message("res://voice/day1/gov/4. Stay tuned.wav", "Information on how to proceed will be sent to you shortly", 5, gouv_color,"gouv", 0)
	if time_elapsed >= 135 and time_elapsed <= 230:
		if Radio.getFrequency() == 1 :
			play_radio_message("res://voice/day1/gov/5. Blue light.wav", "To signal your presence, activate the blue button and see if it works through your door." , 5, gouv_color,"gouv", 6)
		if Radio.getFrequency() == 1 and time_elapsed > gouv_time:
			play_radio_message("res://voice/day1/gov/6. Rations.wav", "Rations will be delivered to your secure room as soon as possible." , 5, gouv_color,"gouv", 0)
	if time_elapsed >= 250 and time_elapsed <= 310:
		if Radio.getFrequency() == 1 :
			play_radio_message("res://voice/day1/gov/7. Stay home citizens.wav", "Please stay at home, the army will be deployed to secure the area." , 5, gouv_color,"gouv", 6)
		if Radio.getFrequency() == 1 and time_elapsed > gouv_time:
			play_radio_message("res://voice/day1/gov/8. More Info to follow.wav", "Stay at home, we'll be in touch soon." , 5, gouv_color,"gouv", 0)

	#belle radio ==>
	if time_elapsed >= 70 and time_elapsed <= 170:
		if Radio.getFrequency() == 2 :
			play_radio_message("res://voice/day1/belle/hello !.mp3", "Hello...? Is anyone out there? Please, if you can hear me, respond...",5, belle_color, "belle", 6)
		if Radio.getFrequency() == 2 and time_elapsed > belle_time:
			play_radio_message("res://voice/day1/belle/You too .mp3", "You too... You've discovered that room, haven't you? What does all this mean?",5, belle_color, "belle", 6)
		if Radio.getFrequency() == 2 and time_elapsed > belle_time:
			play_radio_message("res://voice/day1/belle/This is insane.mp3", "This is insane... Everything feels so strange. I must admit, I'm starting to get worried.",5, belle_color, "belle", 0)
	if time_elapsed >= 160 and time_elapsed <= 190:
		if Radio.getFrequency() == 2 :
			play_radio_message("res://voice/day1/belle/Hopeok.mp3", "I hope you're holding up... I just received my ration. We have to stay strong. You're not alone.",5, belle_color, "belle", 6)
		if Radio.getFrequency() == 2 and time_elapsed > belle_time:
			play_radio_message("res://voice/day1/belle/Others.mp3", "There are other people who communicate on the radio, try to get as much information as possible!",5, belle_color, "belle", 0)


	#Fanatic Radio ==>
	if  time_elapsed >= 50 and time_elapsed <= 90:
		if Radio.getFrequency() == 3 :
			play_radio_message("res://voice/day1/complot/1. Just an excuse.mp3",
			"Wake up! The attack is just an excuse! They’re trying to control us!",
			5, Fanatic_color, "fanatic", 6)
		if Radio.getFrequency() == 3 and time_elapsed > Fanatic_time:
			play_radio_message("res://voice/day1/complot/2. Don't trust.mp3",
			"Don’t trust their broadcasts! They feed you nothing but lies. Think for yourself!",
			5, Fanatic_color, "fanatic", 0)

	if time_elapsed >= 110 and time_elapsed <= 200:
		if Radio.getFrequency() == 3 :
			play_radio_message("res://voice/day1/complot/3. GONE.mp3",
			"They’re trying to isolate us! If you listen to them, you’ll end up like the others… gone.",
			5, Fanatic_color, "fanatic", 0)

	if time_elapsed >= 210 and time_elapsed <= 260:
		if Radio.getFrequency() == 3 :
			play_radio_message("res://voice/day1/complot/4. An other way.mp3",
			"I found a way out. The blue button? It’s a trick. There’s another way… but I can’t say it here.",
			5, Fanatic_color, "fanatic", 6)
		if Radio.getFrequency() == 3 and time_elapsed > Fanatic_time:
			play_radio_message("res://voice/day1/complot/5. Food problem.mp3",
			"Did they bring you food? DON’T TOUCH IT! It’s poisoned to keep you weak!",
			5, Fanatic_color, "fanatic", 0)

	if time_elapsed >= 270 and time_elapsed <= 320:
		if Radio.getFrequency() == 3 :
			play_radio_message("res://voice/day1/complot/6. Resist.mp3",
			"You feel it too, don’t you? Something’s wrong. They don’t want us to resist.",
			5, Fanatic_color, "fanatic", 6)
		if Radio.getFrequency() == 3 and time_elapsed > Fanatic_time:
			play_radio_message("res://voice/day1/complot/7. Dont be a sheep.mp3",
			"Trust me… when the time comes, you’ll have to make a choice. Don't be a sheep.",
			5, Fanatic_color, "fanatic", 0)
