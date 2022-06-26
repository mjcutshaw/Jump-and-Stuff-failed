extends Area2D

#TODO: not tested
@export_enum ("null", "game", "player") var whoPlaced


#func _ready():
#	Signals.checkpoint.connect(self._entered_checkpoint)
#
#
#func _process(delta):
#	pass
#
#
#
#func _on_checkpoint_body_entered(body):
#	Signals.emit_signal("checkpoint", self)
#
#
#
#func _entered_checkpoint():
#	if Checkpoints.get_spawn() != self:
#		self.modulate = Color.DARK_RED
#	else:
#		self.modulate = Color.DARK_GREEN
