extends PanelContainer

@onready var label = $MarginContainer/Label

var card_data = {}
var is_black_card := false

var selected := false

var base_position := Vector2.ZERO
var base_rotation := 0.0


func _ready():
	label = $MarginContainer/Label


func setup(data: Dictionary, black := false):
	card_data = data
	is_black_card = black

	if label:
		label.text = data.get("text", "")

	call_deferred("_apply_data")


func update_style():
	if label == null:
		push_error("Label no inicializado todavía")
		return

	var style = StyleBoxFlat.new()

	style.set_corner_radius_all(24)

	style.shadow_color = Color(0, 0, 0, 0.3)
	style.shadow_size = 8

	# Borde amarillo al seleccionar
	if selected:
		style.set_border_width_all(6)
		style.border_color = Color(1.0, 0.85, 0.2)

	if is_black_card:
		style.bg_color = Color(0.08, 0.08, 0.08)
		label.add_theme_color_override("font_color", Color.WHITE)
	else:
		style.bg_color = Color.WHITE
		label.add_theme_color_override("font_color", Color.BLACK)

	add_theme_stylebox_override("panel", style)


func _apply_data():
	if label == null:
		push_error("Label no listo en _apply_data")
		return

	label.text = card_data.get("text", "")
	update_style()


func _gui_input(event):
	if is_black_card:
		return

	# PC
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			toggle_selected()

	# Móvil
	elif event is InputEventScreenTouch:
		if event.pressed:
			toggle_selected()


func toggle_selected():
	selected = !selected

	if selected:
		z_index = 999
	else:
		z_index = 0

	update_style()


func _process(delta):
	if is_black_card:
		return

	if selected:
		position = position.lerp(base_position + Vector2(0, -120), 12 * delta)
		scale = scale.lerp(Vector2.ONE * 1.25, 12 * delta)
		rotation = lerp(rotation, 0.0, 12 * delta)
	else:
		position = position.lerp(base_position, 12 * delta)
		scale = scale.lerp(Vector2.ONE, 12 * delta)
		rotation = lerp(rotation, base_rotation, 12 * delta)
