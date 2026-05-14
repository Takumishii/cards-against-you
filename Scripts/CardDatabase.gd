extends Node

var loaded_packs = []
var black_cards = []
var white_cards = []

func _ready():
	print("=== CardDatabase iniciado ===")

	load_pack("res://Cards/base-set.json")

	print("Packs cargados: ", loaded_packs.size())
	print("Cartas negras: ", black_cards.size())
	print("Cartas blancas: ", white_cards.size())


func load_pack(path: String):
	print("")
	print("Cargando pack: ", path)

	if !FileAccess.file_exists(path):
		push_error("El archivo no existe: " + path)
		return

	var file = FileAccess.open(path, FileAccess.READ)

	if file == null:
		push_error("No se pudo abrir pack: " + path)
		return

	var text = file.get_as_text()

	print("JSON leído correctamente")

	var data = JSON.parse_string(text)

	if data == null:
		push_error("JSON inválido en: " + path)
		return

	print("Pack encontrado: ", data.get("name", "Sin nombre"))

	loaded_packs.append(data)

	for card in data.get("blackCards", []):
		black_cards.append(card)

	for card in data.get("whiteCards", []):
		white_cards.append({
			"text": card
		})

	print("Cartas negras cargadas: ", data.get("blackCards", []).size())
	print("Cartas blancas cargadas: ", data.get("whiteCards", []).size())


func get_random_black():
	if black_cards.is_empty():
		push_error("No hay cartas negras")
		return null

	return black_cards.pick_random()


func get_random_white():
	if white_cards.is_empty():
		push_error("No hay cartas blancas")
		return null

	return white_cards.pick_random()
