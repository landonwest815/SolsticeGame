# gets us methods we can use
extends CharacterBody2D

# changeable speed for our character
var speed = 50

# keep track of last direction for idle animation
var last_direction = Vector2.ZERO

# the animation to run
var animated_sprite

# called when the node is added to the scene (initializer)
func _ready():
	
	# set the animation
	animated_sprite = $AnimatedSprite2D

# called every physics frame (60 fps)
func _physics_process(delta):
	
	# gets us the direction of the user input
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# applies that to the speed of the character
	# velocity is a built in variable that we are setting
	velocity = direction * speed
	
	# remember last direction
	if direction != Vector2.ZERO:
		last_direction = direction

	# Diagonal movements
	if direction.x > 0 and direction.y < 0:
		animated_sprite.play("run_upright")
	elif direction.x > 0 and direction.y > 0:
		animated_sprite.play("run_downright")
	elif direction.x < 0 and direction.y < 0:
		animated_sprite.play("run_upleft")
	elif direction.x < 0 and direction.y > 0:
		animated_sprite.play("run_downleft")
	
	# Straight movements
	elif direction.x > 0:
		animated_sprite.play("run_right")
	elif direction.x < 0:
		animated_sprite.play("run_left")
	elif direction.y < 0:
		animated_sprite.play("run_up")
	elif direction.y > 0:
		animated_sprite.play("run_down")
	else:
		
		# Diagonal idles
		if last_direction.x > 0 and last_direction.y < 0:
			animated_sprite.play("idle_upright")
		elif last_direction.x > 0 and last_direction.y > 0:
			animated_sprite.play("idle_downright")
		elif last_direction.x < 0 and last_direction.y < 0:
			animated_sprite.play("idle_upleft")
		elif last_direction.x < 0 and last_direction.y > 0:
			animated_sprite.play("idle_downleft")
		
		# Straight idles
		elif last_direction.x > 0:
			animated_sprite.play("idle_right")
		elif last_direction.x < 0:
			animated_sprite.play("idle_left")
		elif last_direction.y < 0:
			animated_sprite.play("idle_up")
		elif last_direction.y > 0:
			animated_sprite.play("idle_down")
	
	
	# helps during collisions
	move_and_slide()
