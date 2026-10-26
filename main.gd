extends Control

const UPGRADE_COST := 10

var logger := EventLogger.new()
var score := 0
var per_click := 1

var score_label: Label
var upgrade_button: Button


func _ready() -> void:
	var box := VBoxContainer.new()
	box.set_anchors_preset(Control.PRESET_CENTER)
	box.alignment = BoxContainer.ALIGNMENT_CENTER
	box.add_theme_constant_override("separation", 16)
	box.custom_minimum_size = Vector2(320, 0)
	box.grow_horizontal = Control.GROW_DIRECTION_BOTH
	box.grow_vertical = Control.GROW_DIRECTION_BOTH
	add_child(box)

	score_label = Label.new()
	score_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	score_label.add_theme_font_size_override("font_size", 48)
	box.add_child(score_label)

	var click_button := Button.new()
	click_button.text = "Clicar"
	click_button.custom_minimum_size = Vector2(0, 120)
	click_button.pressed.connect(_on_click)
	box.add_child(click_button)

	upgrade_button = Button.new()
	upgrade_button.pressed.connect(_on_upgrade)
	box.add_child(upgrade_button)

	var path_label := Label.new()
	path_label.text = "Log: " + logger.absolute_path()
	path_label.autowrap_mode = TextServer.AUTOWRAP_ARBITRARY
	path_label.add_theme_font_size_override("font_size", 11)
	box.add_child(path_label)

	logger.log_event("session_start")
	_refresh()


func _on_click() -> void:
	score += per_click
	logger.log_event("click", score)
	_refresh()


func _on_upgrade() -> void:
	if score < UPGRADE_COST:
		return
	score -= UPGRADE_COST
	per_click += 1
	logger.log_event("upgrade", per_click)
	_refresh()


func _refresh() -> void:
	score_label.text = str(score)
	upgrade_button.text = "+1 por clique (custa %d) — atual: %d" % [UPGRADE_COST, per_click]
	upgrade_button.disabled = score < UPGRADE_COST


func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		logger.log_event("session_end", score)
