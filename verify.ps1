$c10 = [IO.File]::ReadAllText('index (10).html')
$ci  = [IO.File]::ReadAllText('index.html')
Write-Host "=== index (10).html ===" 
Write-Host "bulk-section present:" $c10.Contains("bulk-section")
Write-Host "Old phone 8160485641:" $c10.Contains("8160485641")
Write-Host "New phone 8160485641:" $c10.Contains("8160485641")
Write-Host "Hex logo present:" $c10.Contains("clip-path:polygon")
Write-Host "Bulk nav link gone:" (-not $c10.Contains("href=""#bulk"""))
Write-Host ""
Write-Host "=== index.html ==="
Write-Host "Shop Now button:" $ci.Contains("Shop Now")
Write-Host "Order Now section:" $ci.Contains("Order Now")
Write-Host "id=shop present:" $ci.Contains('id="shop"')
Write-Host "Link to index(10):" $ci.Contains('index (10).html')
