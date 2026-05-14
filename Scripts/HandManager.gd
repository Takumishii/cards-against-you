extends Node

@onready var hand_container = $"../Hand"

var card_scene = preload("res://Scenes/card.tscn")

var hand = []

# Ajustes del abanico
@export var spread := 60.0
@export var curve := 12.0

func _ready():
	draw_hand()


func draw_hand():
	for i in range(10):
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

	var max_width = 600.0  # ancho total del abanico

	for i in range(n):
		var card = hand_container.get_child(i)

		var t = 0.0
		if n > 1:
			t = float(i) / float(n - 1)  # 0 → 1

		# centro (-1 a 1)
		var x_norm = (t - 0.5) * 2.0

		# curva tipo arco
		var y_offset = -abs(x_norm) * 40.0

		# posición final
		var x = x_norm * max_width * 0.5
		var y = y_offset

		# rotación suave en abanico
		var rot = x_norm * deg_to_rad(20)

		card.position = Vector2(x, y)
		card.rotation = rot
		card.z_index = i
