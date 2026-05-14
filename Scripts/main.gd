extends Control

@onready var card = $CenterContainer/MarginContainer/card

func _ready():
	var random_card = CardDatabase.get_random_black()
	card.setup(random_card, true)
