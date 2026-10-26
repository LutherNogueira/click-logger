class_name EventLogger
extends RefCounted
## Grava um evento por linha (JSON Lines): {"timestamp", "evento", "valor"}.

const LOG_PATH := "user://events.jsonl"


func log_event(evento: String, valor: Variant = null) -> void:
	var line := JSON.stringify({
		"timestamp": Time.get_datetime_string_from_system(true) + "Z",
		"evento": evento,
		"valor": valor,
	})
	var file := FileAccess.open(LOG_PATH, FileAccess.READ_WRITE if FileAccess.file_exists(LOG_PATH) else FileAccess.WRITE)
	if file == null:
		push_error("Não consegui abrir %s (erro %d)" % [LOG_PATH, FileAccess.get_open_error()])
		return
	file.seek_end()
	file.store_line(line)


func absolute_path() -> String:
	return ProjectSettings.globalize_path(LOG_PATH)
