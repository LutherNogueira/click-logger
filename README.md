# Click Logger

A minimal clicker game built with Godot that records every player action to a [JSON Lines](https://jsonlines.org/) file. The game is meant to be used as a data source for event-processing pipelines.

## Gameplay

- **Click** button: adds points.
- **+1 per click** upgrade: costs 10 points and increases the points earned per click.

## Event log

Every action is appended as one JSON object per line to `user://events.jsonl`:

```json
{"evento":"click","timestamp":"2026-10-26T14:09:34Z","valor":3}
```

| Field | Description |
|---|---|
| `timestamp` | UTC time in ISO 8601 format |
| `evento` | Event type (see below) |
| `valor` | Event value, or `null` |

| `evento` | Fired when | `valor` |
|---|---|---|
| `session_start` | the game starts | `null` |
| `click` | the Click button is pressed | score after the click |
| `upgrade` | the upgrade is purchased | new points per click |
| `session_end` | the window is closed | final score |

On Windows the file is located at `%APPDATA%\Godot\app_userdata\Click Logger\events.jsonl`. The path is also shown in the game window.

```powershell
Get-Content "$env:APPDATA\Godot\app_userdata\Click Logger\events.jsonl" -Tail 5
```

## Running

1. Install [Godot 4.7](https://godotengine.org/) (tested with 4.7.2).
2. In the project manager, click **Import** and select `project.godot`.
3. Press F5.

## Project structure

| File | Purpose |
|---|---|
| `project.godot`, `main.tscn` | Project settings and main scene (a single `Control` with a script) |
| `main.gd` | UI built in code, score and upgrade logic |
| `event_logger.gd` | `EventLogger` class: appends one JSON line per event |

## Built with

- [Godot Engine](https://godotengine.org/) 4.7 (GDScript, GL Compatibility renderer)
- [Claude Code](https://claude.com/claude-code)
