Add-Type -AssemblyName PresentationFramework

[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Select Programs to Uninstall" Height="300" Width="400" ResizeMode="NoResize" WindowStyle="None" WindowStartupLocation="CenterScreen">
    <Window.Resources>
        <Style TargetType="CheckBox">
            <Setter Property="Foreground" Value="White"/>
            <Style.Resources>
                <Style TargetType="Path">
                    <Setter Property="Fill" Value="White"/>
                </Style>
            </Style.Resources>
        </Style>
    </Window.Resources>
    <Grid Background="#2E2E2E">
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto" />
            <RowDefinition Height="*" />
            <RowDefinition Height="Auto" />
        </Grid.RowDefinitions>
        <ScrollViewer Grid.Row="1" Margin="0" VerticalScrollBarVisibility="Hidden">
            <StackPanel x:Name="SoftwareList" Background="#2E2E2E"/>
        </ScrollViewer>
        <TextBox Grid.Row="2" Name="SearchBar" Width="295" Height="25" Margin="5" HorizontalAlignment="Left" Background="#3E3E3E" Foreground="White" BorderBrush="#3E3E3E"/>
        <Button Grid.Row="2" Content="Uninstall" Name="UninstallButton" Width="75" Height="25" Margin="5" HorizontalAlignment="Right" Background="#3E3E3E" Foreground="White" BorderBrush="#3E3E3E"/>
        <Button Grid.Row="1" Content="X" Name="closeButton" Width="25" Height="25" Margin="0" HorizontalAlignment="Right" VerticalAlignment="Top" Background="#3E3E3E" Foreground="White" BorderBrush="#3E3E3E">
            <Button.Style>
                <Style TargetType="Button">
                    <Setter Property="Cursor" Value="Hand"/>
                    <Style.Triggers>
                        <Trigger Property="IsMouseOver" Value="True">
                            <Setter Property="Background" Value="#FF8B0000"/> <!-- Red color -->
                        </Trigger>
                    </Style.Triggers>
                </Style>
            </Button.Style>
        </Button>
    </Grid>
</Window>
"@

$reader = [System.Xml.XmlNodeReader]::new($xaml)
$window = [Windows.Markup.XamlReader]::Load($reader)
$searchBar = $window.FindName('SearchBar')
$softwareList = $window.FindName('SoftwareList')
$uninstallButton = $window.FindName('UninstallButton')
$closeButton = $window.FindName('closeButton')

function Get-InstalledSoftware {
    $softwarePaths = @(
        'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*',
        'HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
    )

    $softwarePaths | ForEach-Object {
        Get-ItemProperty -Path $_ -ErrorAction SilentlyContinue |
        Where-Object { $_.DisplayName } |
        Select-Object DisplayName, UninstallString, @{Name='IdentifyingNumber'; Expression={$_.PSChildName}}
    } | Sort-Object -Property DisplayName
}

function Update-SoftwareList {
    $searchQuery = $searchBar.Text
    $softwareList.Children.Clear()

    Get-InstalledSoftware | Where-Object { $_.DisplayName -like "*$searchQuery*" } | ForEach-Object {
        $checkbox = New-Object System.Windows.Controls.CheckBox
        $checkbox.Content = $_.DisplayName
        $checkbox.Tag = $_.IdentifyingNumber
        $checkbox.Background = "#2E2E2E"
        $checkbox.FontSize = 14
        $softwareList.Children.Add($checkbox)
    }
}


function Uninstall-SelectedSoftware {
    $softwareList.Children | Where-Object { $_.IsChecked } | ForEach-Object {
        $guid = $_.Tag
        $name = $_.Content
        Write-Host "Uninstalling $name..."

        $software = Get-InstalledSoftware | Where-Object { $_.IdentifyingNumber -eq $guid }
        if ($software -and $software.UninstallString) {
            $uninstallString = $software.UninstallString -replace '/I', '/X' -replace '/i', '/x'
            
            if ($uninstallString -match 'msiexec.exe') {
                $uninstallArgs = $uninstallString.Split(' ', 2)[1] + " /qn /norestart"
                Start-Process "msiexec.exe" -ArgumentList $uninstallArgs -Wait -NoNewWindow
            }
        }
    }
}

$searchTimer = New-Object System.Windows.Threading.DispatcherTimer
$searchTimer.Interval = [TimeSpan]::FromMilliseconds(300)
$searchTimer.Add_Tick({
    $searchTimer.Stop()
    Update-SoftwareList
})

# TextChanged event handler with a delay
$searchBar.Add_TextChanged({
    $searchTimer.Stop()
    $searchTimer.Start()
})

# Add event handlers
$uninstallButton.Add_Click({ Uninstall-SelectedSoftware })
$closeButton.Add_Click({$window.Close()})

# Populate the software list
Update-SoftwareList

# Run the GUI
$window.ShowDialog()
