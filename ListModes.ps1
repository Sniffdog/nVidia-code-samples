###############################################################################
# Copyright (c) 2016 NVIDIA Corporation
###############################################################################
# Permission is hereby granted, free of charge, to any person obtaining a copy 
# of this software and associated documentation files (the "Software"), 
# to deal in the Software without restriction, including without limitation 
# the rights to use, copy, modify, merge, publish, distribute, sublicense, 
# and/or sell copies of the Software, and to permit persons to whom 
# the Software is furnished to do so, subject to the following conditions:
# The above copyright notice and this permission notice shall be included in 
# all copies or substantial portions of the Software.
###############################################################################
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, 
# DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
# OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE 
# OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
###############################################################################
#
# simple script to list display modes, 
# demonstrates how to access WMI objects by references
#
###############################################################################

$namespace = "root\CIMV2\NV"     # namespace of NVIDIA WMI provider

if($computer -eq $null)          # if not set globally
{
    $computer  = "localhost"     # substitute with remote machine names or IP of the machine
}

$class = "Display"
$instances = Get-WmiObject -Class $class -Namespace $namespace -ComputerName $computer
foreach($obj in $instances)
{
    $obj.uname, $obj.id
    "---"
    $modes = $obj.displayModes

    foreach($modeRef in $modes)
    {
        $modeObj=[wmi]("\\$computer\$namespace"+":"+$modeRef)
        "mode id={4} {0}x{1}, {2} bpp @ {3} Hz" -f $modeObj.width, $modeObj.height, $modeObj.colorDepth, $modeObj.refreshRate, $modeObj.id
    }
    "==="
}
