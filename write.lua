local arguments = {...}
local name = arguments[1]

local drives = {peripheral.find("drive")}

assert(name,"No file given.")
assert(fs.exists(name),"File does not exist.")

local input = io.open(name,"r")
local data = {}

for line in input:lines() do
    table.insert(data,line)
end

for _,drive in pairs(drives) do
    if drive.isDiskPresent() then
        local path = drive.getMountPath()
        local copy = io.output(string.format("%s/%s",path,name))
        
        copy:write(table.concat(data,"\n"))
        copy:close()
        
        drive.ejectDisk()
        print(path)
    end
end

input:close()
