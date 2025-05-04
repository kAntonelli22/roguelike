class_name Effect
extends Resource

var effect_name: String = "effect"
var duration: int = 2      # number of turns it lasts
func _init(p_effect_name: String, p_duration: int) -> void:
   effect_name = p_effect_name
   duration = p_duration

func effect(entity: Entity):
   print("base effect applied to ", entity.name)

class Healing extends Effect:
   
   var healing_percent: float = 0.20
   func _init(p_effect_name: String, p_duration: int, p_healing_percent: float) -> void:
      super(p_effect_name, p_duration)
      healing_percent = p_healing_percent
   
   func effect(entity: Entity):
      @warning_ignore("narrowing_conversion")
      entity.health *= healing_percent

class Damage extends Effect:
   var damage_min: int
   var damage_max: int
   func _init(p_effect_name: String, p_duration: int, p_dam_min: int, p_dam_max: int) -> void:
      super(p_effect_name, p_duration)
      damage_min = p_dam_min
      damage_max = p_dam_max
   
   func effect(entity: Entity):
      entity.health -= range(damage_min, damage_max).pick_random()
   
