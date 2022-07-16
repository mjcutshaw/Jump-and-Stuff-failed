extends Resource
class_name GameStats

#TODO: look into ori random end stats

#TODO: why do pickups have to be floats
#TODO: count the pickups set
const totalPickups: float = 100
var pickups: float

var timePlayed: float
var timeOnGround: float
var timeInAir: float
var timeInWater: float
var timeBurrowed: float
var timeLongestLife: float

var jumps: int
var jumpsWall: int
var dashes: int
var grapples: int

var deaths: int
