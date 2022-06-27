extends Node2D
class_name Portal

#TODO: setting for multiple portals to one
#TODO: move stuff to base portal script for less repeated code

#@export_enum("null", "all", "side", "up", "down", "dash", "air jump", "spin", "bash", "grapple") var ability
@export_enum("null", "side", "up", "down", "any") var dashDirection

@onready var portal1: Area2D = $Portal1
@onready var portal2: Area2D = $Portal2
@onready var lockTimer: Timer = $Lock

var lock1: bool = false
var lock2: bool = false
var lockTime: float = 0.7

func _ready():
	lockTimer.wait_time = lockTime
	
	if dashDirection == 0:
		print("null Portal")
	elif dashDirection == 1:
		self.modulate = Globals.dashSideColor
		add_to_group("PortalDashSide")
	elif dashDirection == 2:
		self.modulate = Globals.dashUpColor
		add_to_group("PortalDashUp")
	elif dashDirection == 3:
		self.modulate = Globals.dashDownColor
		add_to_group("PortalDashDown")
	elif dashDirection == 4:
		add_to_group("PortalAny")


func do_thing(body, portalNumber):
	if portalNumber == 1:
		body.global_position = portal2.global_position
		lock_portal(1)
		lock2 = true
	elif portalNumber == 2:
		body.global_position = portal1.global_position
		lock_portal(2)
		lock1 = true


func lock_portal(portalNumber):
	lockTimer.start()
	if portalNumber == 1:
		portal2.monitoring = false
	elif portalNumber == 2:
		portal1.monitoring = false


func _on_portal_1_body_entered(body):
	if !lock1:
		if dashDirection == 1 and body.fsm.currentState == body.fsm.dashSide:
			do_thing(body, 1)
		elif dashDirection == 2 and body.fsm.currentState == body.fsm.dashUp:
			do_thing(body, 1)
		elif dashDirection == 3 and body.fsm.currentState == body.fsm.dashDown:
			do_thing(body, 1)
		elif dashDirection == 4:
			do_thing(body, 1)


func _on_portal_2_body_entered(body):
	if !lock2:
		if dashDirection == 1 and body.fsm.currentState == body.fsm.dashSide:
			do_thing(body, 2)
		elif dashDirection == 2 and body.fsm.currentState == body.fsm.dashUp:
			do_thing(body, 2)
		elif dashDirection == 3 and body.fsm.currentState == body.fsm.dashDown:
			do_thing(body, 2)
		elif dashDirection == 4:
			do_thing(body, 2)


func _on_lock_timeout():
	portal1.monitoring = true
	portal2.monitoring = true


func _on_portal_1_body_exited(body):
	lock1 = false
	


func _on_portal_2_body_exited(body):
	lock2 = false

