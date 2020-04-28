extends Area

signal foodConsumed
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	rotate_y(deg2rad(3))


func _on_Burger_body_entered(body):
	if body.name == "Character":
		$Timer.start()
		$Collect.play()
		
func _on_Timer_timeout():
	$Woof.play()
	emit_signal("foodConsumed")
	queue_free()
