local m = Map("nbtverify", translate("nbtverify Client"), translate("Configure nbtverify client."))
m:section(SimpleSection).template = "nbtverify_status"

local s = m:section(TypedSection, "server", "")
s.addremove = false
s.anonymous = true

local enabled = s:option(Flag, "enabled", translate("Enable"))
enabled.default = enabled.disabled

local username = s:option(Value, "username", translate("Username"))
username.rmempty = false

local password = s:option(Value, "password", translate("Password"))
password.password = true
password.rmempty = false

local mobile = s:option(Flag, "mobile", translate("Mobile mode"))
mobile.default = mobile.enabled

local ping = s:option(Value, "ping", translate("Ping URL"))
ping.placeholder = "http://10.80.92.85/"

m.apply_on_parse = true
m.on_after_apply = function()
	require("luci.sys").call("/etc/init.d/nbtverify restart >/dev/null 2>&1")
end

return m
