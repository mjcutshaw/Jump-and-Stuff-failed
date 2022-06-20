extends Node2D

@onready var dashSideTracker: ColorRect = $DashSide
@onready var dashUpTracker: ColorRect = $DashUp
@onready var dashDownTracker: ColorRect = $DashDown
@onready var player: Player = get_parent().get_parent()

var abilities: Resource = preload ("res://Actor/Player/Resources/PlayerAbilities.tres")


func _ready() -> void:
	if !abilities.unlockedDashSide:
		dashSideTracker.visible = false
	if !abilities.unlockedDashUp:
		dashUpTracker.visible = false
	if !abilities.unlockedDashDown:
		dashDownTracker.visible = false
	EventBus.ability_check.connect(self.tracker_update)
	EventBus.ability_unlocked.connect(self.tracker_visible)


func tracker_visible(ability) -> void:
	if ability == abilities.abiliyList.All:
		dashSideTracker.visible = true
		dashUpTracker.visible = true
		dashDownTracker.visible = true
	if ability == abilities.abiliyList.Dash:
		dashSideTracker.visible = true
		dashUpTracker.visible = true
		dashDownTracker.visible = true
	if ability == abilities.abiliyList.DashSide:
		dashSideTracker.visible = true
	if ability == abilities.abiliyList.DashUp:
		dashUpTracker.visible = true
	if ability == abilities.abiliyList.DashDown:
		dashDownTracker.visible = true


func tracker_update() -> void:
	if dashSideTracker.visible:
		color_dash_side()
	if dashUpTracker.visible:
		color_dash_up()
	if dashDownTracker.visible:
		color_dash_down()


func color_dash_side() -> void:
	if player.remainingDashSide > 0:
		dashSideTracker.color = Globals.dashSideColor
	else:
		dashSideTracker.color = Globals.dashUsedColor


func color_dash_up() -> void:
	if player.remainingDashUp > 0:
		dashUpTracker.color = Globals.dashUpColor
	else:
		dashUpTracker.color = Globals.dashUsedColor


func color_dash_down() -> void:
	if player.remainingDashDown > 0:
		dashDownTracker.color = Globals.dashDownColor
	else:
		dashDownTracker.color = Globals.dashUsedColor
