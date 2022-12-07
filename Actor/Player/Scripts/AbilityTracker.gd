extends Node2D

@onready var dashSideTracker: Line2D = $DashSide
@onready var dashUpTracker: Line2D = $DashUp
@onready var dashDownTracker: Line2D = $DashDown
@onready var player: Player = get_parent().get_parent()

var Abilities: Resource = preload("res://Actor/Player/Resources/PlayerInfo.tres")


func _ready() -> void:
	if !Abilities.unlockedDashSide:
		dashSideTracker.visible = false
	if !Abilities.unlockedDashUp:
		dashUpTracker.visible = false
	if !Abilities.unlockedDashDown:
		dashDownTracker.visible = false
	EventBus.ability_check.connect(self.tracker_update)
	EventBus.ability_unlocked.connect(self.tracker_visible)


func tracker_visible(ability) -> void:
	if ability == Abilities.abiliyList.All:
		dashSideTracker.visible = true
		dashUpTracker.visible = true
		dashDownTracker.visible = true
	if ability == Abilities.abiliyList.Dash:
		dashSideTracker.visible = true
		dashUpTracker.visible = true
		dashDownTracker.visible = true
	if ability == Abilities.abiliyList.DashSide:
		dashSideTracker.visible = true
	if ability == Abilities.abiliyList.DashUp:
		dashUpTracker.visible = true
	if ability == Abilities.abiliyList.DashDown:
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
		dashSideTracker.default_color = AbilityColor.dashSideColor
	else:
		dashSideTracker.default_color = AbilityColor.dashUsedColor


func color_dash_up() -> void:
	if player.remainingDashUp > 0:
		dashUpTracker.default_color = AbilityColor.dashUpColor
	else:
		dashUpTracker.default_color = AbilityColor.dashUsedColor


func color_dash_down() -> void:
	if player.remainingDashDown > 0:
		dashDownTracker.default_color = AbilityColor.dashDownColor
	else:
		dashDownTracker.default_color = AbilityColor.dashUsedColor
