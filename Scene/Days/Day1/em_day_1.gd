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

func _process(_delta):
	if ones == false:
		if Radio.getValue() > 54 and Radio.getValue() < 64 :
			Tools.start_the_day()
			activate_depots()
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
	Tools.set_radio_sound(1,load(sound))
	if what_cd == 0:
		Tools.radio_text(text,time_text,color_ok)
	elif what_cd != 0:
		Tools.radio_text(text, what_cd - 1, color_ok)
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
	
	##MISSED 
	if time_elapsed == 31:
		Tools.event_journal_ok(0,true)
	if time_elapsed == 261:
		Tools.event_journal_ok(4,true)
	if time_elapsed == 301:
		Tools.event_journal_ok(3,true)
	if time_elapsed == 331:
		Tools.event_journal_ok(2,true)
	if time_elapsed == 361:
		Tools.event_journal_ok(1,true)
		
	if time_elapsed == 91 && Tools.get_color_fd() != "blue":
		Tools.timer_event_action(false)
		
	#gouv radio ==>
	if time_elapsed >= 0 and time_elapsed <= 90:
		if radio_value > 54 and radio_value < 64 :
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "This is an official government message.", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/2. The mist.wav", "A mist has settled over Rock Valley. For your safety, please remain indoors.", 5, gouv_color, "gouv", 6)
			Tools.event_journal_ok(0,false)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/3. Security units.wav", "Security units are actively patrolling to maintain public order.", 5, gouv_color,"gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/4. The security room.wav", "Residents of the new miners' district can access a security room. An access device is located at the end of the main corridor.", 5, gouv_color, "gouv", 9)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/5. The food rations.wav", "Rationing trucks are currently circulating in the city. Signal your presence by pressing the blue button on your security console.", 5, gouv_color, "gouv", 9)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/6. The console.wav", "Check the operation of your console. If the blue light is visible through your front door, the system is operating normally.", 5, gouv_color, "gouv", 8)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/7. The protective suit.wav", "After the rationing truck passes, your protective suit will be available for collection of your provisions.", 5, gouv_color, "gouv", 8)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/8. We will keep you informed.wav", "We will keep you informed as the situation evolves.", 5, gouv_color,"gouv", 0)
	if time_elapsed >= 100 and time_elapsed <= 130:
		if radio_value > 54 and radio_value < 64 :
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "This is an official government message !", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/9. Misinformation.wav", "Unofficial sources are spreading incorrect information. We urge you to remain vigilant and follow only government communications.", 5, gouv_color,"gouv", 0)
	if time_elapsed >= 160 and time_elapsed <= 230:
		if radio_value > 54 and radio_value < 64 :
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "This is an official government message" , 5, gouv_color,"gouv", 6)
		if radio_value > 54 and radio_value < 64  and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/10. The mist deposits.wav", "Deposits of mist, visible as white spots, may appear in your homes. It is imperative to clean them immediately." , 5, gouv_color,"gouv", 10)
			Tools.event_journal_ok(3,false)
		if radio_value > 54 and radio_value < 64  and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/11. How to clean.wav", "For residents of the new miners' quarter, an effective cleaner is provided in your bathroom." , 5, gouv_color,"gouv", 0)
	if time_elapsed >= 230 and time_elapsed <= 330:
		if radio_value > 54 and radio_value < 64 :
			play_radio_message("res://Voice/day1/gov/1. Official Government Message.wav", "This is an official government message .", 5, gouv_color,"gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/evacplan.mp3", "The evacuation plan is in place, Rock Valley is divided into five zones, Each day, teams are sent to secure the residents of the zones in the following order: ", 5, gouv_color, "gouv", 15)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/downtown.mp3", "Downtown", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/historicquarter.mp3", "Historic Quarter", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/oldminersquarter.mp3", "Old Miners' Quarter", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/roadquarter.mp3", "Road Quarter.", 5, gouv_color, "gouv", 6)
		if radio_value > 54 and radio_value < 64 and time_elapsed > gouv_time:
			play_radio_message("res://Voice/day1/gov/newminersquarter.mp3", "New Miners' Quarter.", 5, gouv_color, "gouv", 0)
			Tools.event_journal_ok(2, false)
	
	#belle radio ==>
	if time_elapsed >= 50 and time_elapsed <= 110:
		if radio_value > 22 and radio_value < 32 :
			play_radio_message("res://Voice/day1/belle/goodevening.mp3", "Good evening everyone and welcome to this special edition of Belle Radio.",5, belle_color, "belle", 6)
		if radio_value > 22 and radio_value < 32  and time_elapsed > belle_time:
			play_radio_message("res://Voice/day1/belle/imaalone.mp3", "I am alone in the studio, but I am here to share with you the latest news from Rock Valley, which is currently enveloped in a mysterious mist.",5, belle_color, "belle", 9)
		if radio_value > 22 and radio_value < 32  and time_elapsed > belle_time:
			play_radio_message("res://Voice/day1/belle/authsayitstoxic.mp3", "Authorities say it is toxic.",5, belle_color, "belle", 6)
		if radio_value > 22 and radio_value < 32  and time_elapsed > belle_time:
			play_radio_message("res://Voice/day1/belle/staytuned.mp3", "Stay tuned, I will keep you updated on any developments.",5, belle_color, "belle", 0)
	if time_elapsed >= 120 and time_elapsed <= 190:
		if radio_value > 22 and radio_value < 32 :
			play_radio_message("res://Voice/day1/belle/thisisbelle.mp3", "This is Belle,",5, belle_color, "belle", 4)
		if radio_value > 22 and radio_value < 32  and time_elapsed > belle_time:
			play_radio_message("res://Voice/day1/belle/agroupof.mp3", "Reports are coming in from all over the city: a group of unidentified individuals in suits has been seen.",5, belle_color, "belle", 9)
			Tools.event_journal_ok(1,false)
		if radio_value > 22 and radio_value < 32  and time_elapsed > belle_time:
			play_radio_message("res://Voice/day1/belle/theydonotappear.mp3", "They do not appear to be government agents.",5, belle_color, "belle", 6)
		if radio_value > 22 and radio_value < 32 and time_elapsed > belle_time:
			play_radio_message("res://Voice/day1/belle/spawteddowntown.mp3", "They were last spotted downtown.",5, belle_color, "belle", 0)
	if time_elapsed >= 200 and time_elapsed <= 240:
		if radio_value > 22 and radio_value < 32 :
			play_radio_message("res://Voice/day1/belle/thisisbelle.mp3", "This is Belle.",5, belle_color, "belle", 6)
		if radio_value > 22 and radio_value < 32  and time_elapsed > belle_time:
			play_radio_message("res://Voice/day1/belle/whitespots.mp3", " White spots have started appearing here in the studio. I used ROCKCLEAN's EVERSPRAY and they disappeared.",5, belle_color, "belle", 10)
			Tools.event_journal_ok(3, false)
		if radio_value > 22 and radio_value < 32 and time_elapsed > belle_time:
			play_radio_message("res://Voice/day1/belle/donothesitate.mp3", "Do not hesitate to do the same if you see these marks in your home.",5, belle_color, "belle", 0)
	if time_elapsed >= 250 and time_elapsed <= 300:
		if radio_value > 22 and radio_value < 32 :
			play_radio_message("res://Voice/day1/belle/thisisbelle.mp3", "This is Belle ! ",5, belle_color, "belle", 6)
		if radio_value > 22 and radio_value < 32  and time_elapsed > belle_time:
			play_radio_message("res://Voice/day1/belle/Oursources.mp3", "Our sources in the new miners' quarter report that each apartment is equipped with a cleaner.",5, belle_color, "belle", 8)
		if radio_value > 22 and radio_value < 32  and time_elapsed > belle_time:
			play_radio_message("res://Voice/day1/belle/These spots are dangerous; a young girl told me her mother fainted due to prolonged exposure.mp3", "These spots are dangerous; a young girl told me her mother fainted due to prolonged exposure.",5, belle_color, "belle", 0)
			Tools.event_journal_ok(3, false)
	if time_elapsed >= 320 and time_elapsed <= 360:
		if radio_value > 22 and radio_value < 32 :
			play_radio_message("res://Voice/day1/belle/thisisbelle.mp3", "This is Belle ,",5, belle_color, "belle", 6)
		if radio_value > 22 and radio_value < 32  and time_elapsed > belle_time:
			play_radio_message("res://Voice/day1/belle/This enigmatic group stopped in a church before heading to the new miners quarter.mp3", "This enigmatic group stopped in a church before heading to the new miners' quarter.",5, belle_color, "belle", 6)
			Tools.event_journal_ok(1, false)
		if radio_value > 22 and radio_value < 32 and time_elapsed > belle_time:
			play_radio_message("res://Voice/day1/belle/Stay cautious and informed.mp3", "Stay cautious and informed.",5, belle_color, "belle", 0)

	#Fanatic Radio ==>
	if  time_elapsed >= 50 and time_elapsed <= 100:
		if radio_value > 66 and radio_value < 76 :
			play_radio_message("res://Voice/day1/complot/myfriend.mp3","My friends,",5, Fanatic_color, "fanatic", 4)
		if radio_value > 66 and radio_value < 76  and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/complot/thisgovhasliedtoyou.mp3","The government has lied to you, betrayed our miners, and poisoned your children.",5, Fanatic_color, "fanatic", 8)
		if radio_value > 66 and radio_value < 76  and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/complot/yetsomecontinue.mp3","Yet, some continue to believe their sweet words.",5, Fanatic_color, "fanatic", 6)
		if radio_value > 66 and radio_value < 76  and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/complot/SinceRockValley.mp3","Since Rock Valley joined the United Cities, our problems have multiplied, our local decisions overshadowed by distant bureaucracies.",5, Fanatic_color, "fanatic", 12)
		if radio_value > 66 and radio_value < 76  and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/complot/Theyexploitourland.mp3","They exploit our lands and our people without scruple.",5, Fanatic_color, "fanatic", 6)
		if radio_value > 66 and radio_value < 76  and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/complot/Donotbefooled.mp3","Do not be fooled by their lies.",5, Fanatic_color, "fanatic", 0)
	if time_elapsed >= 110 and time_elapsed <= 190:
		if radio_value > 66 and radio_value < 76 :
			play_radio_message("res://Voice/day1/complot/myfriend.mp3","My friends !",5, Fanatic_color, "fanatic", 6)
		if radio_value > 66 and radio_value < 76  and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/complot/Isntitsuspicious.mp3","Isn't it suspicious that the new government housing was ready to handle this crisis?",5, Fanatic_color, "fanatic", 8)
		if radio_value > 66 and radio_value < 76  and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/complot/asiftheyanticipated.mp3","As if they anticipated this disaster.",5, Fanatic_color, "fanatic", 6)
		if radio_value > 66 and radio_value < 76  and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/complot/Wehavealwaysbeenproud.mp3","We have always been proud of our independence. Look at how they treat us now!",5, Fanatic_color, "fanatic", 0)
	if time_elapsed >= 200 and time_elapsed <= 260:
		if radio_value > 66 and radio_value < 76 :
			play_radio_message("res://Voice/day1/complot/myfriend.mp3","My friends ,",5, Fanatic_color, "fanatic", 4)
		if radio_value > 66 and radio_value < 76  and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/complot/terriblenews.mp3","I have terrible news.",5, Fanatic_color, "fanatic", 6)
		if radio_value > 66 and radio_value < 76  and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/complot/neardowntown.mp3","Near downtown, individuals have murdered a representative of our brave miners.",5, Fanatic_color, "fanatic", 8)
			Tools.event_journal_ok(4, false)
			Tools.event_journal_ok(1, false)
		if radio_value > 66 and radio_value < 76  and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/complot/thetruefaceofthegouv.mp3","This is the true face of this government.",5, Fanatic_color, "fanatic", 0)
	if time_elapsed >= 350 and time_elapsed <= 400:
		if radio_value > 66 and radio_value < 76 :
			play_radio_message("res://Voice/day1/complot/myfriend.mp3","My friends",5, Fanatic_color, "fanatic", 4)
		if radio_value > 66 and radio_value < 76  and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/complot/neithergodnor.mp3","Neither God nor the government will save us from this scourge.",5, Fanatic_color, "fanatic", 6)
		if radio_value > 66 and radio_value < 76  and time_elapsed > Fanatic_time:
			play_radio_message("res://Voice/day1/complot/prepareyourself.mp3","Prepare yourselves. When the time comes, we will take back what belongs to us.",5, Fanatic_color, "fanatic", 0)	
