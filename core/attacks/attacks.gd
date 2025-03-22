class_name Attack
extends Resource


var damage_min: int = 5
var damage_max: int = 10
var type: String

func attack(target: Entity):
   target.apply_damage(range(damage_min, damage_max).pick_random())


class MultiTargetAttack:
   extends Attack
   
   var target_count = 4
   func multi_target_attack(targets: Array[Entity]):
      for target in targets:
         super.attack(target)

class MultiCountAttack:
   extends Attack
   
   var attack_count = 3
   func attack(target: Entity):
      for i in range(0, attack_count):
         super(target)
