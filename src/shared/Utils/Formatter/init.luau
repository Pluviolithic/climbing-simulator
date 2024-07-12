local suffixes = require(script.Suffixes)
local Formatter = {}

export type tweenBufferConfig = {
	["startValue"]: number,
	["endValue"]: number,
	["duration"]: number,
	["formatter"]: ((number) -> string)?,
}

local function getPower(n: number): number
	return math.floor(math.log(math.abs(n) + 1) / math.log(10))
end

function Formatter.formatNumberWithSuffix(n: number): string
	local power = math.floor(getPower(n) / 3)

	if power < 1 then
		return tostring(math.round(n))
	end

	local nString = tostring(n / 10 ^ (power * 3))
	local truncatedString = nString:match("%.") and nString:sub(1, 4) or nString:sub(1, 3)

	return truncatedString:gsub("%.0*$", "") .. (suffixes[power] or "")
end

function Formatter.formatCash(n: number): string
	return "$" .. Formatter.formatNumberWithSuffix(n)
end

function Formatter.truncateMultiplier(n: number): string
	return string.format("%.2f", n):gsub("%.?0+$", "")
end

-- taken from https://stackoverflow.com/questions/10989788/format-integer-in-lua
function Formatter.formatNumberWithCommas(n: number, decimalDigits: number?): string
	local _, _, minus, int, fraction = tostring(n):find("([-]?)(%d+)([.]?%d*)")
	if typeof(minus) ~= "string" or typeof(int) ~= "string" or typeof(fraction) ~= "string" then
		warn("Failed to format string correctly.")
		return ""
	end
	int = int:reverse():gsub("(%d%d%d)", "%1,")
	return minus
		.. int:reverse():gsub("^,", "")
		.. fraction:sub(1, if decimalDigits then decimalDigits + 1 else 2)
end

local tweenBuffers: { [TextLabel]: tweenBufferConfig | boolean } = {}
function Formatter.tweenFormattedTextNumber(textLabel: TextLabel, config: tweenBufferConfig)
	if tweenBuffers[textLabel] then
		tweenBuffers[textLabel] = table.clone(config)
		return
	end
	tweenBuffers[textLabel] = true

	local startTime = os.clock()
	local difference = config.endValue - config.startValue

	task.spawn(function()
		repeat
			local timePassed = os.clock() - startTime
			local progress = timePassed / config.duration
			local currentNumber = config.startValue + difference * progress

			if config.startValue > config.endValue then
				currentNumber = math.clamp(currentNumber, config.endValue, config.startValue)
			else
				currentNumber = math.clamp(currentNumber, config.startValue, config.endValue)
			end
			if config.formatter then
				textLabel.Text = config.formatter(currentNumber)
			else
				textLabel.Text = Formatter.formatNumberWithSuffix(currentNumber)
			end
			task.wait()
		until timePassed >= config.duration

		if config.formatter then
			textLabel.Text = config.formatter(config.endValue)
		else
			textLabel.Text = Formatter.formatNumberWithSuffix(config.endValue)
		end

		local bufferData = tweenBuffers[textLabel]
		tweenBuffers[textLabel] = nil
		if typeof(bufferData) == "table" then
			Formatter.tweenFormattedTextNumber(textLabel, bufferData)
		end
	end)
end

return Formatter
