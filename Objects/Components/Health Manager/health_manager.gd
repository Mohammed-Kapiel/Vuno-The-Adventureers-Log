class_name Health_Manager extends Area2D

signal death(Health_Manager)

@onready var health_bar = $"Health Bar"

var faction = Unit_Manager.factions.Player 

var health : float = 100
var max_health : float = 100

func setup_stats(faction, stats:Unit_Stats):
	self.faction = faction
	
	health_bar.modulate = Unit_Manager.faction_colors[faction]
	
	max_health = stats.max_health
	health = max_health

func _ready():
	health_bar.value = 1

func recieve_damage(damage:float):
	health -= damage
	health_bar.value = health / max_health
	
	if health <= 0:
		death.emit(self)
		
func recieve_healing(healing:float):
	health += healing
	health_bar.value = health / max_health
	
	if health > max_health:
		health = max_health

