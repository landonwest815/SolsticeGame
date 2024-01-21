extends CharacterBody2D

var speed = 50
var is_fleeing = false
var player = null

# the animation to run
var animated_sprite
var direction = Vector2.ZERO
var normalized_direction = Vector2.ZERO
var last_direction = Vector2.ZERO

var cooldown_timer = Timer.new()

# called when the node is added to the scene (initializer)
func _ready():
	
	# set the animation
	animated_sprite = $AnimatedSprite2D
	
	# Configure and add the cooldown timer
	cooldown_timer.set_wait_time(0.1)  # Set the timer to 1 second for cooldown
	cooldown_timer.set_one_shot(true)
	add_child(cooldown_timer)

func _physics_process(delta):
	if is_fleeing or not cooldown_timer.is_stopped():
		if player != null:
			direction = player.position - position
			normalized_direction = direction.normalized()
			position -= normalized_direction * speed * delta
	else:
		normalized_direction = Vector2.ZERO
		
	if normalized_direction != Vector2.ZERO:
		last_direction = normalized_direction
			
	# Check horizontal direction
	if normalized_direction.x > 0:
		animated_sprite.play("run_left")  # Assuming positive x is left in your coordinate system
	elif normalized_direction.x < 0:
		animated_sprite.play("run_right")  # Assuming negative x is right

	# Idle animation if no significant movement
	else:
		if last_direction.x < 0:
			animated_sprite.play("idle_right")
		elif last_direction.x > 0:
			animated_sprite.play("idle_left")
			
	move_and_slide()

func _on_detection_area_body_entered(body):
	player = body
	is_fleeing = true
	cooldown_timer.stop()

func _on_detection_area_body_exited(body):
	player = null
	is_fleeing = false
	cooldown_timer.start()

