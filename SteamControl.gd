extends Node

var AppId = "3628610"
var steam_name:String

func _init():
	OS.set_environment("SteamAppId", AppId)
	OS.set_environment("SteamGameId", AppId)
	
func _ready():
	Steam.steamInit()
	var isRunning = Steam.isSteamRunning()
	
	if !isRunning:
		print("ERROR : Steam not running !")
		return
	
	print("Steam is running")
	
	var id = Steam.getSteamID()
	steam_name = Steam.getFriendPersonaName(id)
	print("username : ", str(steam_name))
	
func unlock_achievement(ach):
	return
	var status = Steam.getAchievement(ach)
	if status["achieved"]:
		print("ALLREADY UNLOCK")
		return
	print("UNLOCK : ", ach)
	Steam.setAchievement(ach)
	status = Steam.getAchievement(ach)
	print(status)

	
