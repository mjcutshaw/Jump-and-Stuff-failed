extends CanvasLayer


#TODO: very finicky and grabs inputs i don't wont
var PlayerAbilities: Resource = preload ("res://Actor/Player/Resources/PlayerAbilities.tres")
@export var input: NodePath
@export var output: NodePath

var consoleInput: Control
var consoleOutput: Control
var history = [""]

var showhide: bool = false

func help() -> void:
	consoleOutput.text = "Find a way to list all functions"

func clear() -> void:
	consoleOutput.text = ""

func test() -> void:
	consoleOutput.text = "Hello World"

func unlock_abilities() -> void:
	PlayerAbilities.unlock_ability(PlayerAbilities.abiliyList.All)
	consoleOutput.text = "All abilities unlocked"



func _ready() -> void:
#	consoleInput.connect(_on_input)
	consoleInput = get_node(input)
	consoleOutput = get_node(output)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("dev_console"):
		if !showhide:
			visible = true
			showhide = true
			consoleInput.grab_focus()
			_on_input(event)
		else:
			visible = false
			showhide = false
		
	
	if Input.is_action_just_pressed("ui_accept"):
			if event is InputEventWithModifiers:
				var expression = Expression.new()
				
				history.push_front(consoleInput.text)
				
				var parseError = expression.parse(consoleInput.text)
				if parseError != OK:
					consoleOutput.text += expression.get_error_text() + "\n"
				
				var executeResult = expression.execute([], self )
				if expression.has_execute_failed():
					consoleOutput.text += expression.get_error_text() + "\n"
				elif executeResult != null:
					if not executeResult is Object:
						consoleOutput.text += String(executeResult) + "\n"
						
				consoleInput.text = ""
				
				consoleOutput.scroll_vertical = INF

func _on_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if Input.is_action_just_pressed("ui_up"):
			consoleInput.text = history[0]
			consoleOutput.scroll_vertical = 0
		
