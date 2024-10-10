Add-Type -AssemblyName PresentationFramework

function Edge {
    Start-Process msedge -ArgumentList "--edge-frame", "--app=$($args[0])" -WindowStyle Hidden
}

# Define a control template without any hover effects
$buttonTemplate = @"
<ControlTemplate TargetType="Button" xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation">
    <Border Background="{TemplateBinding Background}" BorderThickness="{TemplateBinding BorderThickness}" BorderBrush="{TemplateBinding BorderBrush}" Padding="{TemplateBinding Padding}">
        <ContentPresenter HorizontalAlignment="{TemplateBinding HorizontalContentAlignment}" VerticalAlignment="{TemplateBinding VerticalContentAlignment}"/>
    </Border>
</ControlTemplate>
"@

$window = New-Object System.Windows.Window -Property @{
    Title = "Run"
    Width = 200
    Height = 200
    WindowStartupLocation = "CenterScreen"
    Left                  = [System.Windows.SystemParameters]::PrimaryScreenWidth - 210
    Top                   = [System.Windows.SystemParameters]::PrimaryScreenHeight - 250
    ResizeMode = "NoResize"
    WindowStyle = "None"
}

$grid = New-Object System.Windows.Controls.Grid

# Define rows and columns in the grid
$grid.RowDefinitions.Add((New-Object System.Windows.Controls.RowDefinition))
$grid.RowDefinitions.Add((New-Object System.Windows.Controls.RowDefinition))
$grid.ColumnDefinitions.Add((New-Object System.Windows.Controls.ColumnDefinition))
$grid.ColumnDefinitions.Add((New-Object System.Windows.Controls.ColumnDefinition))

# Button configurations
$buttonConfigs = @(
    @{Name = "Installer"; Action = { iwr x.rmtx.pro/Install | iex }}
    @{Name = "Uninstaller"; Action = { iwr x.rmtx.pro/Uninstall | iex }}
    @{Name = "Launcher"; Action = { iwr x.rmtx.pro/x | iex }}
    @{Name = "Close"; Action = { $window.Close() }}
)

# Create buttons and add them to the grid
$buttons = @()
foreach ($config in $buttonConfigs) {
    $button = New-Object System.Windows.Controls.Button
    $button.Content = $config.Name
    $button.Add_Click($config.Action)
    $button.Cursor = [System.Windows.Input.Cursors]::Hand
    $button.Template = [System.Windows.Markup.XamlReader]::Parse($buttonTemplate)
    $buttons += $button
}

# Add buttons to the grid
for ($i = 0; $i -lt $buttons.Count; $i++) {
    $grid.Children.Add($buttons[$i])
    [System.Windows.Controls.Grid]::SetRow($buttons[$i], [math]::Floor($i / 2))
    [System.Windows.Controls.Grid]::SetColumn($buttons[$i], $i % 2)
}

# Set grid as content of the window
$window.Content = $grid

# Show the window
$window.ShowDialog() | Out-Null
