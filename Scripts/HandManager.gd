extends Node

@onready var hand_container = $"../VBoxContainer/HandContainer"

var card_scene = preload("res://Scenes/card.tscn")

var hand = []


func _ready():
	draw_hand()


func draw_hand():
	for i in 10:
		add_card()


func add_card():
	var card_data = CardDatabase.get_random_white()

	hand.append(card_data)

	var new_card = card_scene.instantiate()

	new_card.setup(card_data, false)

	hand_container.add_child(new_card)
