# List of URLs and names for 10 different Linux distributions
$distributions = @{
  "Ubuntu 20.04" = "https://cdimage.ubuntu.com/releases/20.04/release/ubuntu-20.04-desktop-amd64.iso";
  "Arch Linux 2021.06.01" = "https://mirror.downloadvn.com/archlinux/iso/2021.06.01/archlinux-2021.06.01-x86_64.iso";
  "Fedora 34" = "https://download.fedoraproject.org/pub/fedora/linux/releases/34/Workstation/x86_64/iso/Fedora-Workstation-34-1.21.iso";
  "Kali Linux 2022.3" = "https://cdimage.kali.org/kali-2022.3/kali-linux-2022.3-live-amd64.iso";
  "Deepin 2021" = "https://cdimage.deepin.com/releases/2021/03/25/2021_03_25_deepin_2021_technical_Preview_AMD64.iso";
  "Ubuntu Focal" = "https://cdimage.ubuntu.com/focal/daily-live/20210211/focal-desktop-amd64.iso";
  "Slackware Current" = "https://downloads.slackware.com/slackware/slackware64-current/slackware64-current-iso/slackware64-current-install.iso";
  "CentOS 8.3.2011" = "https://people.centos.org/centos/8/isos/x86_64/CentOS-8.3.2011-x86_64-boot.iso";
  "openSUSE Leap 15.2" = "https://downloads.opensuse.org/distribution/leap/15.2/iso/openSUSE-Leap-15.2-NET-x86_64.iso";
  "Manjaro Xfce 21.0" = "https://ftp.fau.de/manjaro/releases/21.0/xfce/manjaro-xfce-21.0-stable-x86_64.iso"
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
$drivePath = "$driveLetter:"

# Image the ISO file to the USB drive
Write-Host "Imaging $filename to $drivePath. This may take several minutes."
Get-ChildItem $drivePath | Remove-Item -Recurse -Force
& 'C:\Program Files\Windows AIK\Tools\x64\OSCDIMG.EXE' /n /b $filename $drivePath

# Display a message indicating that the imaging has completed
Write-Host "Imaging complete."
