#!/usr/bin/lua5.1
input1 = arg[1]
input2 = arg[2]

function read(filename)
  local f = assert(io.open(filename, "r"))
  local t = f:read("*all")
  f:close()
  return t
end

input1_raw = read(input1)
input2_raw = read(input2)

if #input1_raw ~= #input2_raw then
  print("inputs don't match in size")
end

for i = 1,string.len(input1_raw) do
  local char1 = string.sub(input1_raw,i,i)
  local char2 = string.sub(input2_raw,i,i)
  if char1 == char2 then
    io.write(char1)
  elseif char1 == "0" then
    io.write(char2)
  elseif char2 == "0" then
    io.write(char1)
  else
    error("conflict: ["..char1.." <> "..char2.."]@"..i)
  end
end
