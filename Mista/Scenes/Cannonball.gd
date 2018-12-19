extends RigidBody2D

# Is projected with force by the cannon
# Has ability to be redirected by dragging with mouse and releasing
# like sex pistols from Jojo p5

# Has height property that is visually represented by scale
# From 0 (ground) to 10 (max height)
# height is affected by "gravity"
# once it hits zero then the ball will stop

var height = 0
var motion = Vector2(0, 0)
var vertical_velocity = 0

const GROUND_FRICTION = .85
const GRAVITY = 0.5

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):
	# Height affected by vertical velocity will slowly fall
	height += delta * vertical_velocity
	height -= delta * GRAVITY
	height = clamp(height, 0, 10)
	
	# Has no friction when in the air
	# Has high friction when on ground
	if height > 0:
		set_friction(0)
	else:
		set_friction(GROUND_FRICTION)
