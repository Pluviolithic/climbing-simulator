local players = require(script.Players)

export type SharedState = {
	Players: players.PlayersState,
}

export type SharedActions = players.PlayersActions

return {
	Players = players.PlayersSlice,
}
