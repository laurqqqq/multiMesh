extends CharacterBody3D
const SPEED = 20
const JUMP_VELOCITY = 20
const SENS = .3
@onready var camera: Camera3D = $Camera

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func look_around(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation_degrees.y = rotation_degrees.y - event.relative.x * SENS
		camera.rotation_degrees.x = camera.rotation_degrees.x - event.relative.y * SENS
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x,-80.0 , 80.0)

func _unhandled_input(event: InputEvent) -> void:
	look_around(event)
	if event.is_action_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else: 
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		
func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
		
	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		velocity.y += JUMP_VELOCITY
	elif Input.is_action_just_pressed("shift"):
		velocity.y -=   JUMP_VELOCITY
	elif Input.is_action_just_released("jump") and velocity.y > 0.0:
		velocity.y = 0.0
		

	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	
	var direction : Vector3 = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	

	
	move_and_slide()
