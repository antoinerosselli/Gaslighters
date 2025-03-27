extends Node

@export_category("Depots Manager")
@export var DANGER_LEVEL: int
@onready var depots = []

@export_category("Events Manager")

@export_category("Radio Manager")
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

#TIMER
var time_elapsed = 0

func _ready():
	depots = get_tree().get_nodes_in_group("depot")
	activate_depots()

func _process(_delta):
	if ones == false:
		if Radio.getValue() > 54 and Radio.getValue() < 64 :
			Tools.start_the_day()
			ones = true

func activate_depots():
	var available_depots = depots.filter(func(depot): return !depot.activation) 
	if available_depots.is_empty():
		return 
	available_depots.shuffle() 
	for i in range(min(DANGER_LEVEL, available_depots.size())):
		available_depots[i].activation = true

func _on_timer_timeout():
	time_elapsed += 1
	check_event_conditions()
	check_radio_conditions()

func check_event_conditions():
	if time_elapsed == 20:
		var alarm = get_tree().get_first_node_in_group("alarm")
		alarm.stop()
	if time_elapsed == 120:
		if Tools.get_color_fd() == "blue":
			Tools.colis_departure()
			Tools.expe_status(true)
	if time_elapsed == 200: 
		Tools.door_letter()
	if time_elapsed == 230:
		UniqueTrait.unique("courant")
	if time_elapsed == 400:
		Tools.eotd()

#RADIO
func play_radio_message(file_path, text, duration, color, sender, what_cd):
	if text in played_messages:  
		return  
	
	radio_event_adv(file_path, text, duration, color, sender, what_cd) 
	played_messages[text] = true  

func radio_event_adv(sound, text, time_text, color_ok, what_fm, what_cd):
	#Tools.set_radio_sound(1,load(sound))
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
	if time_elapsed >= 0 and time_elapsed <= 30:
		if radio_value > 54 and radio_value < 64 :
			play_radio_message("res://voice/day1/gov/1. Official government communication.wav", "This is an official government message.", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://voice/day1/gov/2. Accident.wav", "A mist has settled over Rock Valley. For your safety, please remain indoors.", 5, gouv_color, "gouv", 6)
			Tools.event_journal_ok(0)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://voice/day1/gov/3. Citizens stay home.wav", "Security units are actively patrolling to maintain public order.", 5, gouv_color,"gouv", 0)
	if time_elapsed >= 40 and time_elapsed <= 90:
		if radio_value > 54 and radio_value < 64 :
			play_radio_message("res://voice/day1/gov/1. Official government communication.wav", "Residents of the new miners' district can access a security room. An access device is located at the end of the main corridor.", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://voice/day1/gov/2. Accident.wav", "Rationing trucks are currently circulating in the city. Signal your presence by pressing the blue button on your security console.", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://voice/day1/gov/2. Accident.wav", "Check the operation of your console. If the blue light is visible through your front door, the system is operating normally.", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://voice/day1/gov/2. Accident.wav", "After the rationing truck passes, your protective suit will be available for collection of your provisions.", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://voice/day1/gov/3. Citizens stay home.wav", "We will keep you informed as the situation evolves.", 5, gouv_color,"gouv", 0)
	if time_elapsed >= 100 and time_elapsed <= 130:
		if radio_value > 54 and radio_value < 64 :
			play_radio_message("res://voice/day1/gov/1. Official government communication.wav", "This is an official government message.", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://voice/day1/gov/3. Citizens stay home.wav", "Unofficial sources are spreading incorrect information. We urge you to remain vigilant and follow only government communications.", 5, gouv_color,"gouv", 0)
	if time_elapsed >= 160 and time_elapsed <= 230:
		if radio_value > 54 and radio_value < 64 :
			play_radio_message("res://voice/day1/gov/5. Blue light.wav", "This is an official government message." , 5, gouv_color,"gouv", 6)
		if radio_value > 54 and radio_value < 64  and time_elapsed > gouv_time:
			play_radio_message("res://voice/day1/gov/6. Rations.wav", "Deposits of mist, visible as white spots, may appear in your homes. It is imperative to clean them immediately." , 5, gouv_color,"gouv", 6)
			Tools.event_journal_ok(3)
		if radio_value > 54 and radio_value < 64  and time_elapsed > gouv_time:
			play_radio_message("res://voice/day1/gov/6. Rations.wav", "For residents of the new miners' quarter, an effective cleaner is provided in your bathroom." , 5, gouv_color,"gouv", 0)
	if time_elapsed >= 230 and time_elapsed <= 330:
		if radio_value > 54 and radio_value < 64 :
			play_radio_message("res://voice/day1/gov/4. Stay tuned.wav", "This is an official government message.", 5, gouv_color,"gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://voice/day1/gov/2. Accident.wav", "The evacuation plan is in place.", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://voice/day1/gov/2. Accident.wav", "Rock Valley is divided into five zones.", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://voice/day1/gov/2. Accident.wav", "Each day, teams are sent to secure the residents of the zones in the following order:", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://voice/day1/gov/2. Accident.wav", "Downtown", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://voice/day1/gov/2. Accident.wav", "Historic Quarter", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://voice/day1/gov/2. Accident.wav", "Old Miners' Quarter", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://voice/day1/gov/2. Accident.wav", "Road Quarter.", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://voice/day1/gov/2. Accident.wav", "New Miners' Quarter.", 5, gouv_color, "gouv", 0)
			Tools.event_journal_ok(2)
	
	#belle radio ==>
	if time_elapsed >= 50 and time_elapsed <= 110:
		if radio_value > 22 and radio_value < 32 :
			play_radio_message("res://voice/day1/belle/hello !.mp3", "Good evening everyone and welcome to this special edition of Belle Radio.",5, belle_color, "belle", 6)
		if radio_value > 22 and radio_value < 32  and time_elapsed > belle_time:
			play_radio_message("res://voice/day1/belle/You too .mp3", "I am alone in the studio, but I am here to share with you the latest news from Rock Valley, which is currently enveloped in a mysterious mist.",5, belle_color, "belle", 6)
		if radio_value > 22 and radio_value < 32  and time_elapsed > belle_time:
			play_radio_message("res://voice/day1/belle/You too .mp3", "Authorities say it is toxic.",5, belle_color, "belle", 6)
		if radio_value > 22 and radio_value < 32  and time_elapsed > belle_time:
			play_radio_message("res://voice/day1/belle/This is insane.mp3", "Stay tuned, I will keep you updated on any developments.",5, belle_color, "belle", 0)
	if time_elapsed >= 120 and time_elapsed <= 190:
		if radio_value > 22 and radio_value < 32 :
			play_radio_message("res://voice/day1/belle/Hopeok.mp3", "This is Belle,",5, belle_color, "belle", 6)
		if radio_value > 22 and radio_value < 32  and time_elapsed > belle_time:
			play_radio_message("res://voice/day1/belle/You too .mp3", "Reports are coming in from all over the city: a group of unidentified individuals in suits has been seen.",5, belle_color, "belle", 6)
			Tools.event_journal_ok(1)
		if radio_value > 22 and radio_value < 32  and time_elapsed > belle_time:
			play_radio_message("res://voice/day1/belle/You too .mp3", "They do not appear to be government agents.",5, belle_color, "belle", 6)
		if radio_value > 22 and radio_value < 32 and time_elapsed > belle_time:
			play_radio_message("res://voice/day1/belle/Others.mp3", "They were last spotted downtown.",5, belle_color, "belle", 0)
	if time_elapsed >= 200 and time_elapsed <= 240:
		if radio_value > 22 and radio_value < 32 :
			play_radio_message("res://voice/day1/belle/Hopeok.mp3", "This is Belle,",5, belle_color, "belle", 6)
		if radio_value > 22 and radio_value < 32  and time_elapsed > belle_time:
			play_radio_message("res://voice/day1/belle/You too .mp3", " White spots have started appearing here in the studio. I used ROCKCLEAN's EVERSPRAY and they disappeared.",5, belle_color, "belle", 6)
			Tools.event_journal_ok(3)
		if radio_value > 22 and radio_value < 32 and time_elapsed > belle_time:
			play_radio_message("res://voice/day1/belle/Others.mp3", "Do not hesitate to do the same if you see these marks in your home.",5, belle_color, "belle", 0)
	if time_elapsed >= 250 and time_elapsed <= 300:
		if radio_value > 22 and radio_value < 32 :
			play_radio_message("res://voice/day1/belle/Hopeok.mp3", "This is Belle,",5, belle_color, "belle", 6)
		if radio_value > 22 and radio_value < 32  and time_elapsed > belle_time:
			play_radio_message("res://voice/day1/belle/You too .mp3", "Our sources in the new miners' quarter report that each apartment is equipped with a cleaner.",5, belle_color, "belle", 6)
		if radio_value > 22 and radio_value < 32  and time_elapsed > belle_time:
			play_radio_message("res://voice/day1/belle/Others.mp3", "These spots are dangerous; a young girl told me her mother fainted due to prolonged exposure.",5, belle_color, "belle", 0)
			Tools.event_journal_ok(3)
	if time_elapsed >= 320 and time_elapsed <= 360:
		if radio_value > 22 and radio_value < 32 :
			play_radio_message("res://voice/day1/belle/Hopeok.mp3", "This is Belle,",5, belle_color, "belle", 6)
		if radio_value > 22 and radio_value < 32  and time_elapsed > belle_time:
			play_radio_message("res://voice/day1/belle/You too .mp3", "This enigmatic group stopped in a church before heading to the new miners' quarter.",5, belle_color, "belle", 6)
			Tools.event_journal_ok(1)
		if radio_value > 22 and radio_value < 32 and time_elapsed > belle_time:
			play_radio_message("res://voice/day1/belle/Others.mp3", "Stay cautious and informed.",5, belle_color, "belle", 0)

	#Fanatic Radio ==>
	if  time_elapsed >= 50 and time_elapsed <= 100:
		if radio_value > 66 and radio_value < 76 :
			play_radio_message("res://voice/day1/complot/1. Just an excuse.mp3","My friends,",5, Fanatic_color, "fanatic", 6)
		if radio_value > 66 and radio_value < 76  and time_elapsed > Fanatic_time:
			play_radio_message("res://voice/day1/complot/2. Don't trust.mp3","The government has lied to you, betrayed our miners, and poisoned your children.",5, Fanatic_color, "fanatic", 6)
		if radio_value > 66 and radio_value < 76  and time_elapsed > Fanatic_time:
			play_radio_message("res://voice/day1/complot/2. Don't trust.mp3","Yet, some continue to believe their sweet words.",5, Fanatic_color, "fanatic", 6)
		if radio_value > 66 and radio_value < 76  and time_elapsed > Fanatic_time:
			play_radio_message("res://voice/day1/complot/2. Don't trust.mp3","Since Rock Valley joined the United Cities, our problems have multiplied, our local decisions overshadowed by distant bureaucracies.",5, Fanatic_color, "fanatic", 6)
		if radio_value > 66 and radio_value < 76  and time_elapsed > Fanatic_time:
			play_radio_message("res://voice/day1/complot/2. Don't trust.mp3","They exploit our lands and our people without scruple.",5, Fanatic_color, "fanatic", 6)
		if radio_value > 66 and radio_value < 76  and time_elapsed > Fanatic_time:
			play_radio_message("res://voice/day1/complot/2. Don't trust.mp3","Do not be fooled by their lies.",5, Fanatic_color, "fanatic", 0)
	if time_elapsed >= 110 and time_elapsed <= 190:
		if radio_value > 66 and radio_value < 76 :
			play_radio_message("res://voice/day1/complot/1. Just an excuse.mp3","My friends,",5, Fanatic_color, "fanatic", 6)
		if radio_value > 66 and radio_value < 76  and time_elapsed > Fanatic_time:
			play_radio_message("res://voice/day1/complot/2. Don't trust.mp3","Isn't it suspicious that the new government housing was ready to handle this crisis?",5, Fanatic_color, "fanatic", 6)
		if radio_value > 66 and radio_value < 76  and time_elapsed > Fanatic_time:
			play_radio_message("res://voice/day1/complot/2. Don't trust.mp3","As if they anticipated this disaster.",5, Fanatic_color, "fanatic", 6)
		if radio_value > 66 and radio_value < 76  and time_elapsed > Fanatic_time:
			play_radio_message("res://voice/day1/complot/2. Don't trust.mp3","We have always been proud of our independence. Look at how they treat us now!",5, Fanatic_color, "fanatic", 0)
	if time_elapsed >= 200 and time_elapsed <= 260:
		if radio_value > 66 and radio_value < 76 :
			play_radio_message("res://voice/day1/complot/1. Just an excuse.mp3","My friends,",5, Fanatic_color, "fanatic", 6)
		if radio_value > 66 and radio_value < 76  and time_elapsed > Fanatic_time:
			play_radio_message("res://voice/day1/complot/2. Don't trust.mp3","I have terrible news.",5, Fanatic_color, "fanatic", 6)
		if radio_value > 66 and radio_value < 76  and time_elapsed > Fanatic_time:
			play_radio_message("res://voice/day1/complot/2. Don't trust.mp3","Near downtown, individuals have murdered a representative of our brave miners.",5, Fanatic_color, "fanatic", 6)
			Tools.event_journal_ok(4)
			Tools.event_journal_ok(1)
		if radio_value > 66 and radio_value < 76  and time_elapsed > Fanatic_time:
			play_radio_message("res://voice/day1/complot/2. Don't trust.mp3","This is the true face of this government.",5, Fanatic_color, "fanatic", 0)
	if time_elapsed >= 350 and time_elapsed <= 400:
		if radio_value > 66 and radio_value < 76 :
			play_radio_message("res://voice/day1/complot/1. Just an excuse.mp3","My friends,",5, Fanatic_color, "fanatic", 6)
		if radio_value > 66 and radio_value < 76  and time_elapsed > Fanatic_time:
			play_radio_message("res://voice/day1/complot/2. Don't trust.mp3","Neither God nor the government will save us from this scourge.",5, Fanatic_color, "fanatic", 6)
		if radio_value > 66 and radio_value < 76  and time_elapsed > Fanatic_time:
			play_radio_message("res://voice/day1/complot/2. Don't trust.mp3","Prepare yourselves. When the time comes, we will take back what belongs to us.",5, Fanatic_color, "fanatic", 0)	
