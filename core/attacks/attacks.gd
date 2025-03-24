class_name Attack
extends Resource

#TODO add status effect resources

var damage_min: int = 5
var damage_max: int = 10
var type: String
var name: String = "Base"

func attack(targets: Array[Entity]):
   targets[0].apply_damage(range(damage_min, damage_max).pick_random())


class MultiTargetAttack:
   extends Attack
   
   var target_count = 4
   func _init() -> void:
      name = "MultiTarget"
   
   func attack(targets: Array[Entity]):
      for target in targets:
         super.attack([target])

class MultiCountAttack:
   extends Attack
   
   var attack_count = 3
   func _init() -> void:
      name = "MultiCount"
   
   func attack(targets: Array[Entity]):
      for i in range(0, attack_count):
         super([targets[0]])
