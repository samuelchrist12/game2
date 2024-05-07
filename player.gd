extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

const SPEED = 100.0
var JUMP_VELOCITY = -300.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_limit = 2
var is_rolling = false
var roll_duration = 0.5  
var roll_timer = 0.0

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	var direction = Input.get_axis("walk_left", "walk_right")
	
	if is_on_floor() and not is_rolling:
		jump_limit = 2
		JUMP_VELOCITY = -300.0
		if direction == 0:
			animated_sprite.play("default")
		else:
			animated_sprite.play("run")
	elif not is_on_floor() and not is_rolling :
		animated_sprite.play("jump")
		
	if Input.is_action_just_pressed("jump") and jump_limit != 0:
		velocity.y = JUMP_VELOCITY
		
		jump_limit = jump_limit - 1
		JUMP_VELOCITY = JUMP_VELOCITY + 50

	if Input.is_action_just_pressed("roll") and not is_rolling:
		start_roll()

	if is_rolling:
		roll_timer += delta
		if roll_timer >= roll_duration:
			stop_roll()

	if direction < 0:
		animated_sprite.flip_h = true
	elif direction > 0:
		animated_sprite.flip_h = false

	if is_rolling:
		velocity.x = direction * SPEED * 2  # Adjust roll speed as needed
	else:
		velocity.x = direction * SPEED

	move_and_slide()

func start_roll():
	is_rolling = true
	animated_sprite.play("roll")
	roll_timer = 0.0

func stop_roll():
	is_rolling = false
	animated_sprite.play("default")
	roll_timer = 0.0

