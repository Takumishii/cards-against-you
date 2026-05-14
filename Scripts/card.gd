extends PanelContainer

@onready var label = $MarginContainer/Label

var card_data = {}
var is_black_card := false

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
