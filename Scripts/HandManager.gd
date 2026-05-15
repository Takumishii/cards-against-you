extends Node

@onready var hand_container = $"../VBoxContainer/Hand"

var card_scene = preload("res://Scenes/card.tscn")

var hand = []

# Ajustes del abanico
@export var spread := 60.0
@export var curve := 12.0

func _ready():
	draw_hand()


func draw_hand():
	for i in range(7):
		add_card()


func add_card():
	var card_data = CardDatabase.get_random_white()
	hand.append(card_data)

	var new_card = card_scene.instantiate()
	new_card.setup(card_data, false)

	hand_container.add_child(new_card)

	update_hand_layout()
	
func update_hand_layout():
	var n = hand_container.get_child_count()

	if n == 0:
		return

	var size = hand_container.size
	var center = size * 0.5

	# ancho máximo del abanico
	var max_width = size.x * 0.9

	# apertura del abanico
	var angle_range = deg_to_rad(75)

	for i in range(n):
		var card = hand_container.get_child(i)

		# NO mover cartas seleccionadas
		if card.selected:
			continue

		var t := 0.0

		if n > 1:
			t = float(i) / float(n - 1)

		# ángulo del abanico
		var angle = lerp(-angle_range, angle_range, t)

		# radio horizontal
		var radius = max_width * 0.5

		# posición curva
		var x = sin(angle) * radius
		var y = -cos(angle) * 60.0 + 60.0

		# compensar pivot inferior
		var card_offset = Vector2(card.size.x * 0.5, card.size.y)

		# posición final
		card.position = center + Vector2(x, y) - card_offset

		# guardar base para animaciones
		card.base_position = card.position
		card.base_rotation = angle * 0.6

		# aplicar rotación
		card.rotation = card.base_rotation

		# orden visual
		card.z_index = i
