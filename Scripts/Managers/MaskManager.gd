class_name MaskManager
extends Node

enum Element { BLANK, FIRE, WATER, EARTH, AIR }
static var picked_masks: Array[MaskPickup]
static var current_element: Element = Element.BLANK
static var ammo: int = 0


static func on_mask_picked(mask: MaskPickup):
	if mask.element != current_element:
		for picekd_mask in picked_masks:
			picekd_mask.enable_mask()
		picked_masks.clear()
		picked_masks.append(mask)
		change_element(mask.element)
		ammo = 1
	else:
		ammo += 1
		picked_masks.append(mask)
	GUI.instance.update_ammo(ammo)

static func change_element(new_element: Element):
	current_element = new_element
	Player.instance.change_element(current_element)
	GUI.instance.change_element(current_element)
	if current_element != Element.WATER:
		WaterPathManager.instance.disable_all_water_paths()
	else:
		WaterPathManager.instance.enable_all_water_paths()

static func use_ammo():
	ammo -= 1
	GUI.instance.update_ammo(ammo)
	if ammo == 0:
		WaterPathManager.instance.disable_all_water_paths()
		change_element(Element.BLANK)
		for picekd_mask in picked_masks:
			picekd_mask.enable_mask()
