Add-Type -AssemblyName PresentationFramework,WindowsBase,System.Xaml
Add-Type -AssemblyName System.Windows.Forms, System.Drawing

$base64Icon = "AAABAAEAQEAAAAEAIABUBwAAFgAAAIlQTkcNChoKAAAADUlIRFIAAABAAAAAQAgGAAAAqmlx3gAAAAFzUkdCAK7OHOkAAAAEZ0FNQQAAsY8L/GEFAAAACXBIWXMAAA7DAAAOwwHHb6hkAAAG6UlEQVR4Xu2bS2xVRRjHu3Xpxp0rV+5csmlLkaZKSXhUFB8o+KABJIUiKI9ICTT1RSvFaEhEbEKihBg1UWNiTNWEkCjmJmhCiEQlkGiMbHRhgovj+R3OXMbp/8x8R0rta5IfvdwzM3f+33zfzJwzc1qsqbOz87b29vbVbW1tb+WcyT9fWbhwYTYdKNvSoG20kbaWzb7xlFd4FxXnP3DV/9FpztWyo+4sZdRP3d3dt85A4SG0fQQtpSxbwnJ5wXNeRTOdcx0dHXeU8uIJl59O8T1ZoAltpUyd6PnZKN6R67tU6QnESZ5pNrl9FY0FCxbcUsq+nsoBTxWYjYyUsq8lYiP/0jTad3Z0ZD1dXQVLFi/OOhYtkvlS3N11T9a1fHkBn1UeC51Lu7MlK1YV9VjbQpj/KxSsvb9rRU/29aa+7MetO7LL257LLvY/m33euylbt6Rb5lfQ4I0nXs+e/2E8G/z9TAGfe8derWWIZY+vy/YeH89Gv7ycvXbq1+Lvix99lz2yeafJEGguxLNqyr9I9v6xR9cWohUXtmzP9vaskuV86KXd33/aFB7CNQykyvo81j/QFK7YcnBMlvPBC4r1Qf5htcrgQ88r4T4YgbBQ5R394+9I4Y4Dv31T5FFlHUtXPRwV78ATVHkftCfdn5g/u7lfig7BS1QdgMsq0SEYgbyqDqB3leCQ/SdPJ0OhCIP8nzPqooNeVWIVjA+qDlh7aL8UrCCvqgOGP7sgBYfgJYYxpUEIRBc+DHBKrAJPUXUAg5wSq3jyzZdlHWBxfwdjjqrDgfYWdcGnjgcwI6g6oI4HrBnaLesARnolNsToAVnSAMQRwpTgkIOrH5J1wL0P9BTxrQSHkFfVAev3jkjBIUyRqnxI0gBAGDDKK9EO4p+FkSrvsIQBeVRZB9Nkygvo/dhA6mMyADDPVxkB8akpEPCmvk/GKj1h03tHZLkQpsIqIwzng6RlCnSYDdDa2laIZKpjsAOE4/b0PNdVOcV9258u5ntWgMDnlX29Mm8VxDfhwHSHaAzCFIlxaIu1PbUMEEOVqUKVd6j8VajyDpVfYTbAZKIaDCpvjMmo438xwHRi3gDqy7nEvAHUlzFYYLCsZb3OkjW2arvZ3L+sOzu0dUN2fGBb8feJB1fKfDHMBuDGoup+HmNYH0f50OD/0mjWHSf37cj+ev/oBE4fHiwMo8opTAZg+Rl7kgOs4uoa4dsPXshOnTggr8UYf2VAindcfHs0uSx3mAzAMzwl2oflbZ3V3M4Na7K/z48V8FnlUZBXiQ7BQ1T5kKQB6H3/AWYM1vmqjhB65+cvRpsG4LO1x3BxJTjkyokjpjqTBiD2lVgFhlJ1hIzu29gU7+A7lTcEYUqwwnKDNuUGYID68+zRCQb45fQbpgZPuQEIgYGfvpKCQywh8PGxPRPEO7imyvhYQ8A6EJoGQUZ4JTgkNQgy5SnhDjwjNS1O+SAI3HtbpkFV1odpTwn3IU9qOp3yaRAIBRZC6mlO6jEWDO16SgpWpKZFxMUWQpbYd5gN4HBLYUS7pXDqXpwGM8gpsQrLtMjvVS2F6zwbqG0AV3mIyuugoS/tWV+L1HLW/WbYDkeYv4raBrgRVEOrUOVvBvMGUF/OJeYNoL6cS9QyAJsObD6wCcFmBJsSbE6wRlD5q2BjhGWz2xjhM6vIOs8TmCbZlGFzxm3SsGlTZw0AZgPEjqVgEIyjyoVUbY3xnfWhCnuVVYc2rMd1HCYDsPhJ7csPfdhIbkdbNkdjZwOAnq8S7+AQl/XglskAuLoSHUI4qPLAbXXVpqgPeWIPWnF7JdoHA8TOKvgkDUDDracyMJSqA1g2K8GK2AEJYl2JDiEUON+k6vBJHpEhtpVYxXA+MKo6wOL+jlgYpM4p+KQGRHdEphFe8KljAAZDVQdM1iGpc33bpFhF6oYqp5E8JsfAVnUYISR2QJGBVIlVxE53xA5s+hAqqRmlOCbHYUF10YcpUAn2Gc7dn/FClXdUbaz4kEeVdeDWljCwTIVoNx+Vfebwu1I4MEhajqVgoMk4Kos4d15ZETuw6cjF/9F8lSYVBg48gfneF85pLFzWegeHwPCwNA9dGSQtx9qA32KeZ6rzvQG3xziWO8rC/V3K/8M7QkkvcJXSUI6ouxiz/KCPy4tHuLCpU4ef1x3fdwOepR56v7W19fZS/rWUXxgJM4a4it2P+IR5Y7j8N1KHI6zDUk9ugMFS9vU051+ZIfEWRW6dWf3S1ATXD1NuAN4UvaQqmMmgibGulBlPeEJeKLpCnGE0kj0fJuIkLzgyk0OC0Z4BrzLmLQlvyF2Ht7JnjCEQTptr93osMUvkFRevz+c/0phOBinb0nx9vrnCS6aWln8AP1tAzDPGgdwAAAAASUVORK5CYII="

# If -CustomConfigsUrl is not provided, use the defhault URL
$buttonConfigsUrl = "https://z.rmtx.pro/go/btn"
$buttonTemplate = @"
<ControlTemplate TargetType="Button" xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation">
    <Border Background="{TemplateBinding Background}" BorderThickness="{TemplateBinding BorderThickness}" BorderBrush="{TemplateBinding BorderBrush}" Padding="{TemplateBinding Padding}">
        <ContentPresenter HorizontalAlignment="{TemplateBinding HorizontalContentAlignment}" VerticalAlignment="{TemplateBinding VerticalContentAlignment}"/>
    </Border>
</ControlTemplate>
"@

$ProgressPreference = 'SilentlyContinue' 
function Edge {Start-Process msedge -ArgumentList "--edge-frame", "--app=$($args[0])" -WindowStyle Hidden}
function RDP {& "mstsc.exe" "$env:userprofile\Documents\RMTX\VMs\$args" }
 #  use local path also, change it to don't have to add the app to path and download the RD installer also add the KMS patches
function RDC {& "msrdc" "$env:userprofile\Documents\RMTX\VMs\BACS\$args" /u:jfernandez@bacsit.com }
function EXE {Start-Process -FilePath (Join-Path $env:userprofile\Documents $args[0])}
function Download {iwr -Uri $($args[0]) -o (Join-Path $env:userprofile\Documents $args[1]); Expand-Archive -Path (Join-Path $env:userprofile\Documents $args[1]) -DestinationPath $env:userprofile\Documents -Force; Remove-Item (Join-Path $env:userprofile\Documents $args[1]); $TargetPath = "$env:userprofile\Documents\OpenApps.exe"; $ShortcutPath = "$env:APPDATA\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\OpenApps.lnk"; $WScriptShell = New-Object -ComObject WScript.Shell; $Shortcut = $WScriptShell.CreateShortcut($ShortcutPath); $Shortcut.TargetPath = $TargetPath; $Shortcut.Save(); Write-Host "Shortcut created at: $ShortcutPath"}

$window = New-Object System.Windows.Window -Property @{
    Title                 = "Launcher"
    Width                 = 200
    Height                = 200
    WindowStartupLocation = "Manual"
    Left                  = [System.Windows.SystemParameters]::PrimaryScreenWidth - 210
    Top                   = [System.Windows.SystemParameters]::PrimaryScreenHeight - 250
    ResizeMode            = "NoResize"
    WindowStyle           = "None"
    Topmost               = $false
    AllowsTransparency    = $true
    ShowInTaskbar         = $true
}

$iconBytes = [System.Convert]::FromBase64String($base64Icon)
$stream = New-Object System.IO.MemoryStream
$stream.Write($iconBytes, 0, $iconBytes.Length)
$stream.Position = 0
$windowIcon = New-Object System.Windows.Media.Imaging.BitmapImage
$windowIcon.BeginInit()
$windowIcon.StreamSource = $stream
$windowIcon.EndInit()
$window.Icon = $windowIcon
$stream.Dispose()

$grid = New-Object System.Windows.Controls.Grid

1..4 | ForEach-Object {
    $grid.RowDefinitions.Add((New-Object System.Windows.Controls.RowDefinition)) | Out-Null
    $grid.ColumnDefinitions.Add((New-Object System.Windows.Controls.ColumnDefinition))  | Out-Null
}

# $buttonConfigs = Get-Content -Raw -Path "launcher_options.json" | ConvertFrom-Json
$buttonConfigs = (Invoke-WebRequest -Uri $buttonConfigsUrl).Content | ConvertFrom-Json
$buttons = foreach ($config in $buttonConfigs) {
    $image = New-Object System.Windows.Controls.Image -Property @{
        Stretch = "UniformToFill"
        OpacityMask = [System.Windows.Media.Brushes]::Black
        Source = if ($config.Image.Base64) {
            $bitmap = New-Object System.Windows.Media.Imaging.BitmapImage
            $memoryStream = New-Object System.IO.MemoryStream
            $memoryStream.Write([System.Convert]::FromBase64String($config.Image.Base64), 0, [System.Convert]::FromBase64String($config.Image.Base64).Length)
            $memoryStream.Position = 0
            $bitmap.BeginInit()
            $bitmap.StreamSource = $memoryStream
            $bitmap.CacheOption = "OnLoad"
            $bitmap.EndInit()
            $bitmap
        } else {$config.Image.Path}
        Opacity = 0.6
    }

    $button = New-Object System.Windows.Controls.Button -Property @{
        Content = $image
        Cursor = [System.Windows.Input.Cursors]::Hand
        Background = $config.Background
        BorderThickness = New-Object System.Windows.Thickness $config.BorderThickness
        BorderBrush = $config.BorderBrush
        ToolTip = $config.ToolTip
        Foreground = "Red"
        Template = [System.Windows.Markup.XamlReader]::Parse($buttonTemplate)
    }

    $button.Add_Click([Scriptblock]::Create($config.Action))
    $button
}

for ($i = 0; $i -lt $buttons.Count; $i++) {
    $grid.Children.Add($buttons[$i]) | Out-Null
    [System.Windows.Controls.Grid]::SetRow($buttons[$i], [math]::Floor($i / 4)) | Out-Null
    [System.Windows.Controls.Grid]::SetColumn($buttons[$i], $i % 4) | Out-Null
    # Add mouseover behavior
    $buttons[$i].Add_MouseEnter({$this.Content.Opacity = 1.0})
    $buttons[$i].Add_MouseLeave({$this.Content.Opacity = 0.6})
}

# create a system tray icon
$notifyIcon = New-Object System.Windows.Forms.NotifyIcon
$iconBytes = [System.Convert]::FromBase64String($base64Icon)
$iconStream = New-Object System.IO.MemoryStream -ArgumentList (,$iconBytes)
$loadedIcon = [System.Drawing.Icon]::FromHandle(([System.Drawing.Bitmap]::FromStream($iconStream)).GetHicon())
$notifyIcon.Icon = $loadedIcon
# $notifyIcon.Icon = [System.Drawing.SystemIcons]::Application
$notifyIcon.Visible = $true
$notifyIcon.Text = "RMTX"
$notifyIcon.ContextMenuStrip = New-Object System.Windows.Forms.ContextMenuStrip
$pinMenuItem = $notifyIcon.ContextMenuStrip.Items.Add("Pin")
$exitMenuItem = $notifyIcon.ContextMenuStrip.Items.Add("Exit")
$pinMenuItem.CheckOnClick = $true
$pinMenuItem.Add_Click({$window.Topmost = -not $window.Topmost})
$exitMenuItem.Add_Click({$window.Close()})
$notifyIcon.Add_DoubleClick({ if ($_.Button -eq 'Left') { $window.WindowState = if ($window.WindowState -eq [System.Windows.WindowState]::Normal) { [System.Windows.WindowState]::Minimized } else { [System.Windows.WindowState]::Normal } } })
$window.Add_Closed({$notifyIcon.Dispose()})
$grid.Background = "Transparent"
$window.Background = "Transparent"
$window.Content = $grid 
$window.ShowDialog() | Out-Null
