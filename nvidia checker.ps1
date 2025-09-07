# Detect all NVIDIA GPUs
$gpus = Get-PnpDevice -Class Display | Where-Object {$_.Manufacturer -like "*NVIDIA*"}

if ($gpus.Count -eq 0) {
    Write-Host "No NVIDIA GPU detected."
} else {
    foreach ($gpu in $gpus) {
        Write-Host "GPU Name: $($gpu.FriendlyName)"

        try {
            # Get the hardware IDs of the GPU
            $id = (Get-PnpDeviceProperty -InstanceId $gpu.InstanceId -KeyName "DEVPKEY_Device_HardwareIds").Data
            $printed = @{}

            foreach ($hardwareId in $id) {
                if ($hardwareId -match "VEN_10DE&DEV_([0-9A-F]{4})&SUBSYS_([0-9A-F]{8})") {
                    $devId = $matches[1]
                    $subsys = $matches[2]

                    if (-not $printed.ContainsKey("$devId-$subsys")) {
                        Write-Host "Device ID: $devId"
                        Write-Host "Subsystem ID: $subsys"

                        # Determine template based on GPU type
                        $template = "Desktop" # default
                        if ($gpu.FriendlyName -match "Notebook|Laptop|Mobile|Max-Q") { $template = "Notebook" }
                        elseif ($gpu.FriendlyName -match "Quadro|RTX A") { $template = "Quadro" }
                        elseif ($gpu.FriendlyName -match "Tesla|A100|V100|H100") { $template = "Tesla" }

                        Write-Host "Template NvCleanInstall to use: $template"
                        Write-Host "----------------------------"

                        $printed["$devId-$subsys"] = $true
                    }
                }
            }
        } catch {
            Write-Host "Unable to retrieve IDs for this GPU."
        }
    }
}

# Keep the window open to view results
Read-Host -Prompt "Press Enter to exit"
