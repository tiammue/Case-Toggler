# PowerShell script to create a simple ICO file
# This creates a basic bitmap that can be converted to ICO

Add-Type -AssemblyName System.Drawing

# Create a 32x32 bitmap
$bitmap = New-Object System.Drawing.Bitmap(32, 32)
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)

# Enable anti-aliasing
$graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$graphics.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAlias

# White background with light gray border
$graphics.Clear([System.Drawing.Color]::White)
$pen = New-Object System.Drawing.Pen([System.Drawing.Color]::LightGray, 1)
$graphics.DrawRectangle($pen, 0, 0, 31, 31)

# Black "Aa" text
$font = New-Object System.Drawing.Font("Segoe UI", 14, [System.Drawing.FontStyle]::Bold)
$brush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::Black)

$textSize = $graphics.MeasureString("Aa", $font)
$x = (32 - $textSize.Width) / 2
$y = (32 - $textSize.Height) / 2

$graphics.DrawString("Aa", $font, $brush, $x, $y)

# Save as PNG (can be converted to ICO later)
$bitmap.Save("icon.png", [System.Drawing.Imaging.ImageFormat]::Png)

Write-Host "Icon created as icon.png" -ForegroundColor Green
Write-Host "You can convert this to icon.ico using an online converter or image editor" -ForegroundColor Yellow

# Cleanup
$graphics.Dispose()
$bitmap.Dispose()
$font.Dispose()
$brush.Dispose()
$pen.Dispose()