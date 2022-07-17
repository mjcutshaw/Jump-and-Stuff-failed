extends Node2D

#TODO: get ground color for particles

@onready var particleDashSide: GPUParticles2D = $ParticlesDashSide
@onready var particleDashUp: GPUParticles2D = $ParticlesDashUp
@onready var particleDashDown: GPUParticles2D = $ParticlesDashDown

func _ready() -> void:
	particleDashSide.process_material.color = Globals.dashSideColor
	particleDashUp.process_material.color = Globals.dashUpColor
	particleDashDown.process_material.color = Globals.dashDownColor
