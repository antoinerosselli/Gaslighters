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
	print(steam_name)
	
func unlock_achievement(ach):
	var status = Steam.getAchievement(ach)
	if status.has("achieved") and status["achieved"]:
		print("Succès déjà débloqué :", ach)
		return

	Steam.setAchievement(ach)
	Steam.storeStats() 
	print("Succès débloqué :", ach)


	
