extends CanvasLayer

#TODO: clean up, to much in process
#FIXME: change to a margin to add to normal gui, 

var stats = []

func add_stat(stat_name, object, stat_ref):
	stats.append([stat_name, object, stat_ref])

func _process(delta):
	var label_text = ""
	
	var fps = Engine.get_frames_per_second()
	label_text += str("FPS: ", fps)
	label_text += "\n"
	
	var mem = OS.get_static_memory_usage()
	label_text += str("Static Memory: ", String.humanize_size(mem))
	label_text += "\n"
	
	for s in stats:
		var value = null
		
		value = s[1].get(s[2])
		label_text += str(s[0], ": ", value)
		label_text += "\n"
	
	$%Label.text = label_text


#class Property:
#	var num_format = "%4.2f"
#	var object  # The object being tracked.
#	var property  # The property to display (NodePath).
#	var label_ref  # A reference to the Label.
#	var display  # Display option (rounded, etc.)
#
#	func _init(_object, _property, _label, _display):
#		object = _object
#		property = _property
#		label_ref = _label
#		display = _display
#
#	func set_label():
#		# Sets the label's text.
#		var s = object.name + "/" + property + " : "
#		var p = object.get_indexed(property)
#		match display:
#			"":
#				s += str(p)
#			"length":
#				s += num_format % p.length()
#			"round":
#				match typeof(p):
#					TYPE_INT, TYPE_FLOAT:
#						s += num_format % p
#					TYPE_VECTOR2, TYPE_VECTOR3:
#						s += str(p.round())
#		label_ref.text = s
#
#var props = []  # An array of the tracked properties.
#
#func _process(_delta):
#	if not visible:
#		return
#	for prop in props:
#		prop.set_label()
#
#
#func add_property(object, property, display):
#	var label = Label.new()
#	label.set("custom_fonts/font", load("res://debug/roboto_16.tres"))
#	$MarginContainer/VBoxContainer.add_child(label)
#	props.append(Property.new(object, property, label, display))
#
#func remove_property(object, property):
#	for prop in props:
#		if prop.object == object and prop.property == property:
#			props.erase(prop)
