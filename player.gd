# gets us methods we can use
extends CharacterBody2D

# changeable speed for our character
var speed = 100

# called every physics frame (60 fps)
func _physics_process(delta):
	
	# gets us the direction of the user input
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# applies that to the speed of the character
	# velocity is a built in variable that we are setting
	velocity = direction * speed
	
	# helps during collisions
	move_and_slide()
