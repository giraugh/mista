extends RigidBody2D

# Is projected with force by the cannon
# Has ability to be redirected by dragging with mouse and releasing
# like sex pistols from Jojo p5

# Has height property that is visually represented by scale
# From 0 (ground) to 10 (max height)
# height is affected by "gravity"
# once it hits zero then the ball will stop

var parent_cannon
var height = 0
var max_height = 10
var motion = Vector2(0, 0)
var vertical_velocity = 0
var idle_timer = 0
var idle_timer_max = 1

const GROUND_FRICTION = .8
const GROUND_DAMP = 2
const GRAVITY = 4

func _ready():
	set_can_sleep(false)

func _physics_process(delta):
	# Height affected by vertical velocity will slowly fall
	height += delta * vertical_velocity
	vertical_velocity -= delta * GRAVITY
	height = clamp(height, 0, max_height)
	
	# Has no friction + damp when in the air
	# Has high friction + damp when on ground
	if height > 0:
		set_friction(0)
		set_linear_damp(0)
	else:
		vertical_velocity = 0
		set_linear_damp(GROUND_DAMP)
		set_friction(GROUND_FRICTION)
	
	# Scale cannonball by height
	var ball = get_node('Ball')
	ball.scale = Vector2(1, 1) * lerp(1, 2, height / max_height)
	
	# Count how long idle on ground
	if height == 0 && linear_velocity.length() < 1:
		idle_timer += delta
		if idle_timer >= idle_timer_max:
			queue_free()
			parent_cannon.relocate(position)

# Knocks the cannonball into the air
func apply_vertical_impulse(amount):
	vertical_velocity = max(vertical_velocity, 0)
	vertical_velocity += amount

# Change the cannonballs direction
# Direction is a vector2 and amount is a 0-1 scalar
func knock(direction, amount):
	apply_impulse(
		-1 * direction.normalized(),
		amount * linear_velocity.length()
	)
