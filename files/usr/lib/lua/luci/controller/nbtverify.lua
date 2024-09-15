module("luci.controller.nbtverify", package.seeall)

function index()
    entry({"admin", "services", "nbtverify"}, cbi("nbtverify"), "NBT Verify", 60)
end

