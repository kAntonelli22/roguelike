class_name Effect
extends Resource

var effect_name: String = "effect"
var duration: int = 2      # number of turns it lasts

func effect(entity: Entity):
   print("base effect applied to ", entity.name)

class HealingEffect extends Effect:
   
   var healing_percent: float = 0.20
   func _init():
      effect_name = "Healing Effect"
   
   func effect(entity: Entity):
      entity.health = entity.health * healing_percent
