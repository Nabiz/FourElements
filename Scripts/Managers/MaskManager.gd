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
	else:
		picked_masks.append(mask)

static func change_element(new_element: Element):
	current_element = new_element
	Player.instance.change_element(current_element)
