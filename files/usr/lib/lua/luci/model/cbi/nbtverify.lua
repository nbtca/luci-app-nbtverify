require("luci.sys")

m = Map("nbtverify", translate("nbtverify Client"), translate("Configure nbtverify client."))

s = m:section(TypedSection, "server", "")
s.addremove = false
s.anonymous = true

enable = s:option(Flag, "enable", translate("Enable"))
username = s:option(Value, "username", translate("Username"))
pass = s:option(Value, "password", translate("Password"))
is_mobile = s:option(Flag, "is_mobile", translate("Mobile"))
-- o = s:option(Value, "delay", translate("Delayed Start (seconds)"))
-- o.datatype = "and(uinteger,min(0))"
-- o.default = "60"

pass.password = true
m.apply_on_parse = true
m.on_after_apply = function(self, map)
    luci.sys.exec("/etc/init.d/nbtverify restart")
end
return m
