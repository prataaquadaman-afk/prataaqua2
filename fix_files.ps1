# ── PATCH index (10).html  ── Robust v2
$f = 'c:\Users\SMIT\OneDrive\Desktop\PA\index (10).html'
$c = [System.IO.File]::ReadAllText($f, [System.Text.Encoding]::UTF8)

Write-Host "File length: $($c.Length) chars"
Write-Host "Has BULK ORDERS comment: $($c.Contains('BULK ORDERS'))"
Write-Host "Has WHY SECTION comment: $($c.Contains('WHY SECTION'))"
Write-Host "Has logo-mark: $($c.Contains('logo-mark'))"
Write-Host "Has old phone 8160485641: $($c.Contains('8160485641'))"
Write-Host "Has new phone 8160485641: $($c.Contains('8160485641'))"

# 1. Phone & WA number
$c = $c.Replace('8160485641', '8160485641')
$c = $c.Replace('81604 85641', '81604 85641')

# 2. Remove Bulk Orders nav link
$c = $c.Replace('<a href="#bulk">Bulk Orders</a>', '')

# 3. Remove hero Bulk Orders button
$c = $c.Replace('<a class="btn-outline" href="#bulk">Bulk Orders</a>', '')

# 4. Remove bulk section HTML - try different marker combos
$removed = $false
$markers = @(
    @('<!-- BULK ORDERS -->', '<!-- WHY SECTION -->'),
    @('<!-- BULK ORDERS-->', '<!-- WHY SECTION -->'),
    @('<!--BULK ORDERS-->', '<!--WHY SECTION-->'),
    @('<section class="bulk-section"', '<section class="why-section"')
)
foreach ($m in $markers) {
    $bStart = $c.IndexOf($m[0])
    $wStart = $c.IndexOf($m[1])
    if ($bStart -ge 0 -and $wStart -gt $bStart) {
        $c = $c.Substring(0, $bStart) + $c.Substring($wStart)
        Write-Host "Bulk section removed using markers: '$($m[0])'"
        $removed = $true
        break
    }
}
if (-not $removed) { Write-Host "WARNING: Could not find bulk section markers" }

# 5. Replace header logo-mark with hexagonal logo
$hexLogo = '<div style="width:44px;height:44px;background:linear-gradient(135deg,#1a7a99,#2bbcd4);clip-path:polygon(50% 0%,100% 25%,100% 75%,50% 100%,0% 75%,0% 25%);display:flex;align-items:center;justify-content:center;font-weight:700;font-size:10px;color:white;text-align:center;line-height:1.1;letter-spacing:.5px;">PRATA<br>AQUA</div>'
$c = $c.Replace('<div class="logo-mark"></div>', $hexLogo)

# 6. Replace old logo text spans (header)
$c = $c.Replace('<span>Prata Aqua</span>', '<span style="font-size:1rem;letter-spacing:2px;">PRATA <span style="color:var(--aqua)">AQUA</span></span>')

# 7. Replace footer logo text
$c = $c.Replace('<span style="color:white">Prata Aqua</span>', '<span style="color:white;font-size:1rem;letter-spacing:2px;">PRATA <span style="color:var(--aqua)">AQUA</span></span>')

# 8. Remove footer Bulk Orders link
$c = $c.Replace('<li><a href="#bulk">Bulk Orders</a></li>', '')

# Save
[System.IO.File]::WriteAllText($f, $c, [System.Text.Encoding]::UTF8)
Write-Host ""
Write-Host "After patching:"
Write-Host "  Has logo-mark: $($c.Contains('logo-mark'))"
Write-Host "  Has old phone: $($c.Contains('8160485641'))"
Write-Host "  Has new phone: $($c.Contains('8160485641'))"
Write-Host "  Has bulk-section: $($c.Contains('bulk-section'))"
Write-Host "  Has hex logo: $($c.Contains('clip-path:polygon'))"
Write-Host "Done!"
