extends Node3D

@export var mesh_size : Vector2

var is_mouse_inside = false
var is_mouse_held = false # Track if the button is currently down
var last_event_pos2D = null
var last_event_time: float = -1.0

@onready var node_viewport = $SubViewport
@onready var node_quad = $tablet
@onready var node_area = $tablet/Area3D

func _ready():
	node_area.mouse_entered.connect(_mouse_entered_area)
	node_area.mouse_exited.connect(_mouse_exited_area)
	# We will still use input_event for the initial click/hover
	node_area.input_event.connect(_mouse_input_event)

func _mouse_entered_area():
	is_mouse_inside = true

func _mouse_exited_area():
	is_mouse_inside = false

func _input(event):
	# Handle the "Release" event even if the mouse is outside the mesh
	if event is InputEventMouseButton:
		if not event.pressed:
			is_mouse_held = false
			# If we released outside, we must send one final event to the viewport 
			# to let it know the button is up.
			if not is_mouse_inside:
				_handle_external_mouse(event)
		else:
			if is_mouse_inside:
				is_mouse_held = true

	# Handle dragging while mouse is held, even if it leaves the bounds
	if event is InputEventMouseMotion and is_mouse_held and not is_mouse_inside:
		_handle_external_mouse(event)

func _handle_external_mouse(event):
	# This processes events when the mouse is NOT over the mesh but is still interacting
	# We use the last known 2D position so the UI doesn't "jump" to a corner
	_send_to_viewport(event, last_event_pos2D if last_event_pos2D else Vector2.ZERO)

func _mouse_input_event(_camera, event, event_position, _normal, _shape_idx):
	# Convert 3D position to 2D relative to mesh
	var event_pos3D = node_quad.global_transform.affine_inverse() * event_position
	
	# Calculate 2D coordinates (Standard Godot 3D-to-2D mapping)
	var event_pos2D = Vector2(event_pos3D.z, -event_pos3D.x)
	event_pos2D /= mesh_size
	event_pos2D += Vector2(0.5, 0.5)
	event_pos2D *= Vector2(node_viewport.size)

	_send_to_viewport(event, event_pos2D)

func _send_to_viewport(event, pos2D):
	var now: float = Time.get_ticks_msec() / 1000.0
	
	# Update event positions
	event.position = pos2D
	if event is InputEventMouse:
		event.global_position = pos2D

	# Calculate relative motion
	if event is InputEventMouseMotion or event is InputEventScreenDrag:
		if last_event_pos2D != null:
			event.relative = pos2D - last_event_pos2D
			var time_delta = now - last_event_time
			if time_delta > 0:
				event.velocity = event.relative / time_delta
		else:
			event.relative = Vector2.ZERO

	last_event_pos2D = pos2D
	last_event_time = now
	
	node_viewport.push_input(event)

func _unhandled_input(event):
	# Pass non-mouse events (keyboard/joypad) directly to viewport
	if not (event is InputEventMouse or event is InputEventScreenTouch or event is InputEventScreenDrag):
		node_viewport.push_input(event, true)
