

extends CharacterBody3D
const speed = 0.15

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x += direction.x * speed
		velocity.z += direction.z * speed

	if Input.is_action_pressed("rotate_left"):
		rotation_degrees.y += 2.0
	if Input.is_action_pressed("rotate_right"):
		rotation_degrees.y -= 2.0
	var v_range = $Node3D/Camera3D.rotation_degrees.x
	if Input.is_action_pressed("rotate_up") and $Node3D/Camera3D.rotation_degrees.x < 70:
		$Node3D/Camera3D.rotation_degrees.x += 2.0
	if Input.is_action_pressed("rotate_down") and $Node3D/Camera3D.rotation_degrees.x > -70:
		$Node3D/Camera3D.rotation_degrees.x -= 2.0
	velocity *= 0.95
	move_and_slide()
	if Input.is_action_just_pressed("exit"):
		get_tree().change_scene_to_file("res://menu.tscn")

var sensitivity = 0.15
func _unhandled_input(event):
	var v_range = $Node3D/Camera3D.rotation_degrees.x
	if event is InputEventMouseMotion:
		if sensitivity <= 0.15 and abs(v_range) > 40:
			sensitivity = 0.15 /((abs(v_range)-25)/15)
		else: sensitivity = 0.149
		rotation_degrees.y -= event.relative.x * sensitivity
		if event.relative.y > 0 and v_range > -70:
			$Node3D/Camera3D.rotation_degrees.x -= event.relative.y * sensitivity
		elif event.relative.y <= 0 and v_range < 70:
			$Node3D/Camera3D.rotation_degrees.x -= event.relative.y * sensitivity
		rotation_degrees.z = 0.0
