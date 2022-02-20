extends Item

class_name Tool

enum ToolResource {
	BRONZE,
	IRON,
	SILVER,
	GOLD,
	PLATINUM,
	URANIUM,
	UNOBTAINIUM
}

var tool_resource_dict = {
	ToolResource.BRONZE : "Bronze",
	ToolResource.IRON: "Iron",
	ToolResource.SILVER: "Silver",
	ToolResource.GOLD : "Gold",
	ToolResource.PLATINUM: "Platinum",
	ToolResource.URANIUM: "Uranium",
	ToolResource.UNOBTAINIUM: "Unobtainium"
	
}

var tool_resource
