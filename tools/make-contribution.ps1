# Regenerates assets/contribution.svg from the public GitHub contribution calendar.
# No token needed: it reads the same public HTML GitHub serves for the profile graph.
# Usage:  powershell -ExecutionPolicy Bypass -File tools/make-contribution.ps1 [-User s9ss]

param(
    [string]$User = "s9ss",
    [string]$Out = "assets/contribution.svg"
)

$ErrorActionPreference = "Stop"

$resp = Invoke-WebRequest -Uri "https://github.com/users/$User/contributions" -UseBasicParsing `
    -Headers @{ "User-Agent" = "Mozilla/5.0"; "Accept" = "text/html" }
$html = $resp.Content

$days = @()
foreach ($td in [regex]::Matches($html, '<td[^>]*data-date="(\d{4}-\d{2}-\d{2})"[^>]*>')) {
    $days += [pscustomobject]@{ Date = [datetime]$td.Groups[1].Value; Count = 0 }
}
$tips = [regex]::Matches($html, '<tool-tip[^>]*>([^<]*)</tool-tip>')
if ($tips.Count -ne $days.Count) { throw "date/tooltip mismatch: $($days.Count) vs $($tips.Count)" }

for ($i = 0; $i -lt $days.Count; $i++) {
    $txt = $tips[$i].Groups[1].Value
    if ($txt -match '^(\d+) contribution') { $days[$i].Count = [int]$Matches[1] } else { $days[$i].Count = 0 }
}

# last 12 calendar months, oldest first
$lastDay = ($days | Sort-Object Date | Select-Object -Last 1).Date
$months = @()
for ($k = 11; $k -ge 0; $k--) {
    $m = $lastDay.AddMonths(-$k)
    $sum = ($days | Where-Object { $_.Date.Year -eq $m.Year -and $_.Date.Month -eq $m.Month } |
            Measure-Object -Property Count -Sum).Sum
    if (-not $sum) { $sum = 0 }
    $months += [pscustomobject]@{ Label = $m.ToString("MMM").ToLower(); Total = [int]$sum }
}

$max = ($months | Measure-Object -Property Total -Maximum).Maximum
if ($max -le 0) { $max = 1 }

$left = 64; $right = 946; $top = 46; $base = 196
$step = ($right - $left) / ($months.Count - 1)
$pts = for ($i = 0; $i -lt $months.Count; $i++) {
    $x = [math]::Round($left + $i * $step, 1)
    $y = [math]::Round($base - ($months[$i].Total / $max) * ($base - $top), 1)
    [pscustomobject]@{ X = $x; Y = $y; M = $months[$i] }
}

# catmull-rom to cubic bezier, so the line reads as a curve rather than a polyline
$line = "M $($pts[0].X) $($pts[0].Y)"
for ($i = 0; $i -lt $pts.Count - 1; $i++) {
    $p0 = if ($i -eq 0) { $pts[0] } else { $pts[$i - 1] }
    $p1 = $pts[$i]; $p2 = $pts[$i + 1]
    $p3 = if ($i + 2 -lt $pts.Count) { $pts[$i + 2] } else { $pts[$pts.Count - 1] }
    $c1x = [math]::Round($p1.X + ($p2.X - $p0.X) / 6, 1); $c1y = [math]::Round($p1.Y + ($p2.Y - $p0.Y) / 6, 1)
    $c2x = [math]::Round($p2.X - ($p3.X - $p1.X) / 6, 1); $c2y = [math]::Round($p2.Y - ($p3.Y - $p1.Y) / 6, 1)
    $line += " C $c1x $c1y, $c2x $c2y, $($p2.X) $($p2.Y)"
}
$area = "$line L $($pts[$pts.Count - 1].X) $base L $($pts[0].X) $base Z"

$dots = ($pts | ForEach-Object { "    <circle cx=""$($_.X)"" cy=""$($_.Y)"" r=""3.5"" fill=""#E6EDF3"" stroke=""#0B0E13"" stroke-width=""2""/>" }) -join "`n"
$labels = ($pts | ForEach-Object { "    <text x=""$($_.X)"" y=""220"" text-anchor=""middle"" font-size=""11"" fill=""#68788A"" font-family=""'JetBrains Mono', Consolas, monospace"">$($_.M.Label)</text>" }) -join "`n"
$grid = ""
foreach ($frac in 0.25, 0.5, 0.75) {
    $y = [math]::Round($base - $frac * ($base - $top), 1)
    $grid += "    <line x1=""$left"" y1=""$y"" x2=""$right"" y2=""$y"" stroke=""#1C2430"" stroke-width=""1"" stroke-dasharray=""2 6""/>`n"
}

$total = ($months | Measure-Object -Property Total -Sum).Sum

$svg = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 250" width="1000" height="250" role="img" aria-label="$User contributions over the last twelve months: $total total.">
  <defs>
    <linearGradient id="fill" x1="0" y1="0" x2="0" y2="1">
      <stop offset="0" stop-color="#5B9DFF" stop-opacity="0.32"/>
      <stop offset="1" stop-color="#5B9DFF" stop-opacity="0"/>
    </linearGradient>
  </defs>

  <rect width="1000" height="250" fill="#0B0E13"/>
  <rect x="0.5" y="0.5" width="999" height="249" fill="none" stroke="#1C2430"/>

  <text x="64" y="30" font-size="12" fill="#68788A" font-family="'JetBrains Mono', Consolas, monospace" letter-spacing="1.5">$User  /  last twelve months  /  $total contributions</text>

  <g>
$grid    <line x1="$left" y1="$base" x2="$right" y2="$base" stroke="#2A3646" stroke-width="1.2"/>
  </g>

  <path d="$area" fill="url(#fill)"/>
  <path d="$line" fill="none" stroke="#E6EDF3" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round"/>

  <g>
$dots
  </g>

  <g>
$labels
  </g>
</svg>
"@

$dir = Split-Path -Parent $Out
if ($dir -and -not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }
[System.IO.File]::WriteAllText((Join-Path (Get-Location) $Out), $svg, (New-Object System.Text.UTF8Encoding($false)))

"wrote $Out  months=$($months.Count)  total=$total  max=$max"
$months | ForEach-Object { "  $($_.Label)  $($_.Total)" }
