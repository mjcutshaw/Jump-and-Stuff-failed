extends Resource

#TODO: moved stats to here

var moveSpeed: int = 15 * Globals.TILE_SIZE
var acceleration: float = 0.3
var friction: float = 0.2
var crouchFriction: float = 0.02

var jumpHeightMax: float = 4.5 * Globals.TILE_SIZE
var jumpHeightMin: int = 10
var jumpTimeToPeak: float = 0.5
var jumpTimeToDescent: float = 0.25
var jumpTimeAtApex: float = 0.8
var jumpApexHeight: float = 40
var jumpDoubleVelocityModifier: float = 1.25
var jumpTripleVelocityModifier: float = 1.5
var jumpCrouchVelocityModifier: float = 1.75
var jumpLongVelocityModifier: float = 1.35
var dashJumpBoostVelocityModifier: float = 1.25
@onready var gravityJump: float = 2 * jumpHeightMax / pow(jumpTimeToPeak, 2)
@onready var gravityFall: float = 2 * jumpHeightMax / pow(jumpTimeToDescent, 2)
@onready var gravityApex: float = 2 * jumpHeightMax / pow(jumpTimeAtApex, 2)
@onready var gravityGlide: float = gravityFall/10
@onready var jumpVelocityMax: float = -sqrt(2 * gravityJump * jumpHeightMax)
@onready var jumpVelocityMin: float = -sqrt(2 * gravityJump * jumpHeightMin)
var terminalVelocity: int = 30 * Globals.TILE_SIZE
var moveSpeedApex: int = 13 * Globals.TILE_SIZE

var glideSpeedModifier: int = 2
var glideFallSpeedModifier: int = 6

var jumpBoostTime: float = 0.10 #DASH
var dashTime = 0.3
var dashDistance: int = 10 * Globals.TILE_SIZE

# WALL SLIDE #
var slideSpeed: int = 7 * Globals.TILE_SIZE
var quickSlideSpeed: int = 12 * Globals.TILE_SIZE
