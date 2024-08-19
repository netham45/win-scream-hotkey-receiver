$ShowWindowAsync = Add-Type -MemberDefinition '[DllImport("user32.dll")] public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);' -name Win32ShowWindowAsync -namespace Win32Functions -PassThru
$KeybdEvent = Add-Type -MemberDefinition '[DllImport("user32.dll")] public static extern void keybd_event(byte bVk, byte bScan, uint dwFlags, int dwExtraInfo);' -name Win32KeybdEvent -namespace Win32Functions -PassThru

function SendKey($keyCode) {
    $KeybdEvent::keybd_event($keyCode, 0, 0x01, 0)  # KEYEVENTF_EXTENDEDKEY
    $KeybdEvent::keybd_event($keyCode, 0, 0x03, 0)  # KEYEVENTF_EXTENDEDKEY | KEYEVENTF_KEYUP
}

$ShowWindowAsync::ShowWindowAsync((Get-Process -PID $pid).MainWindowHandle, 0) # Hide the window
$socket = New-Object System.Net.Sockets.UdpClient # Create a new UDP Client
$socket.ExclusiveAddressUse = $false # Allow multiple sockets to bind to the port
$socket.Client.Bind((New-Object System.Net.IPEndPoint([System.Net.IPAddress]::Any, 9999))) # Bind to port 9999

while ($receivedData = [System.Text.Encoding]::ASCII.GetString($socket.Receive([ref]$null))) {
    if     ($receivedData -ceq 'n') {SendKey 0xB0} # VK_MEDIA_NEXT_TRACK
    elseif ($receivedData -ceq 'p') {SendKey 0xB1} # VK_MEDIA_PREV_TRACK
    elseif ($receivedData -ceq 'P') {SendKey 0xB3} # VK_MEDIA_PLAY_PAUSE
}
