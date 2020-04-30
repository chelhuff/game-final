extends Label

var coins = 0

func _ready():
	text = String(coins)


func _on_Burger_foodConsumed():
	coins += 1
	_ready()
	if coins == 9 and get_tree().get_current_scene().get_name() == "Level":
		get_tree().change_scene("res://Level2.tscn")
	if coins == 9 and get_tree().get_current_scene().get_name() == "Level2":
		get_tree().change_scene("res://End.tscn")
