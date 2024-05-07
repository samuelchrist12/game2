extends CharacterBody2D
@onready var animated_sprite = $AnimatedSprite2D

const SPEED = 500.0
const JUMP_VELOCITY = -250.0
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
var player # Reference to the player node

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	player = get_node("../Player") # Adjust the path to your player node

func _physics_process(delta):

	
	if not is_on_floor():
		velocity.y += gravity * delta
	

	var direction_to_player = (player.global_position - global_position).normalized()
	print(direction_to_player.x)
	if ray_cast_left.is_colliding() and direction_to_player.x < 0 and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if ray_cast_right.is_colliding() and direction_to_player.x > 0 and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if direction_to_player.x<0 :
		animated_sprite.flip_h=true
	if direction_to_player.x>0 :
		animated_sprite.flip_h=false
	

	velocity.x = direction_to_player.x * SPEED * delta
	
	move_and_slide()
