# List of URLs and names for 10 different Linux distributions
$distributions = @{
    "Debian" = "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-10.9.0-amd64-netinst.iso";
    "Ubuntu" = "http://releases.ubuntu.com/20.04/ubuntu-20.04.2-desktop-amd64.iso";
    "Fedora" = "https://dl.fedoraproject.org/pub/fedora/linux/releases/32/Workstation/x86_64/iso/Fedora-Workstation-Live-x86_64-32-1.9.iso";
    "OpenSUSE" = "https://download.opensuse.org/distribution/leap/15.2/iso/openSUSE-Leap-15.2-NET-x86_64.iso";
    "CentOS" = "http://isoredirect.centos.org/centos/8/isos/x86_64/CentOS-8.3.2011-x86_64-boot.iso";
    "Manjaro" = "https://manjaro.org/downloads/official/xfce/202211/manjaro-xfce-202211-stable-x86_64.iso";
    "Kali" = "https://cdimage.kali.org/2022.2/kali-linux-2022.2-installer-amd64.iso";
    "Arch" = "https://mirrors.tuna.tsinghua.edu.cn/archlinux/iso/2022.01.01/archlinux-2022.01.01-x86_64.iso";
    "Elementary" = "https://mirror.pnl.gov/releases/elementary/os/5.2/elementaryos-5.2-stable.20221130.iso";
    "Parrotsec" = "https://downloads.parrotsec.org/iso/parrot-security-6.0.0.iso";
}

# Display the list of distributions
Write-Host "Select a distribution:"
for ($i = 0; $i -lt $distributions.Count; $i++) {
  Write-Host "  $($i + 1). $($distributions.Keys[$i])"
}

# Ask the user to select a distribution
$index = Read-Host "Enter your selection (1-$($distributions.Count)):"

# Validate the user's selection
if ($index -lt 1 -or $index -gt $distributions.Count) {
  Write-Host "Invalid selection."
  exit
}

# Set the URL for the selected distribution
$url = $distributions.Values[$index - 1]

# Set the name for the ISO file
$filename = [System.IO.Path]::GetFileName($url)

# Download the ISO file
Invoke-WebRequest -Uri $url -OutFile $filename

# Display a message indicating that the download has completed
Write-Host "Download of $filename complete."

# Ask the user to specify the letter of the USB drive
$driveLetter = Read-Host "Enter the letter of the USB drive to image:"

# Validate the user's input
if ($driveLetter -notmatch '^[a-zA-Z]$') {
  Write-Host "Invalid drive letter."
exit
}

# Set the path to the USB drive
$drivePath = "$driveLetter`:`\"

# Image the ISO file to the USB drive
Write-Host "Imaging $filename to $drivePath. This may take several minutes."
Get-ChildItem $drivePath | Remove-Item -Recurse -Force
& 'C:\Program Files\Windows AIK\Tools\x64\OSCDIMG.EXE' /n /b $filename $drivePath

# Display a message indicating that the imaging has completed
Write-Host "Imaging complete."
