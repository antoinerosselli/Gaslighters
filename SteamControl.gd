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
		return

	var id = Steam.getSteamID()
	steam_name = Steam.getFriendPersonaName(id)
	
func unlock_achievement(ach):
	var status = Steam.getAchievement(ach)
	if status["achieved"]:
		return
	Steam.setAchievement(ach)
	status = Steam.getAchievement(ach)
	(status)

	
