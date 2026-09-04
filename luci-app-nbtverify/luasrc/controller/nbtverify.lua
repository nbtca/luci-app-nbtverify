module("luci.controller.nbtverify", package.seeall)

local http = require "luci.http"
local jsonc = require "luci.jsonc"
local sys = require "luci.sys"

local status_file = "/var/run/nbtverify/status.json"

function index()
	local page = entry({"admin", "services", "nbtverify"}, cbi("nbtverify"), _("NBT Verify"), 60)
	page.dependent = true

	page = entry({"admin", "services", "nbtverify_status"}, call("act_status"))
	page.leaf = true
end

local function read_status()
	local file = io.open(status_file, "r")
	if not file then
		return nil
	end

	local raw = file:read(65536)
	file:close()

	local ok, status = pcall(jsonc.parse, raw or "")
	if not ok or type(status) ~= "table" then
		return nil
	end

	local result = type(status.result) == "table" and status.result or {}
	local detail = type(status.detail) == "table" and status.detail or {}

	-- Only expose fields used by the page. The upstream status also contains
	-- session cookies and the complete login/logout forms.
	return {
		result = {
			success = result.success == true,
			baseUrl = result.baseUrl,
			message = result.message
		},
		detail = {
			welcome = detail.welcome,
			account = detail.account,
			userIp = detail.userIp,
			userMac = detail.userMac,
			userName = detail.userName,
			deviceIp = detail.deviceIp
		}
	}
end

function act_status()
	local response = {
		running = sys.call("pidof nbtverify >/dev/null 2>&1") == 0,
		status = read_status()
	}

	http.prepare_content("application/json")
	http.write_json(response)
end
