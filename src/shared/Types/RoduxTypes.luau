export type ReplicationRule = "None" | "All" | "List" | "Single"

export type RoduxAction = {
	["meta"]: {
		["shouldSave"]: boolean,
		["replicationRule"]: ReplicationRule,
	},
	[string]: any,
}
