# Test script for scheduler-gpt.exe
# Compares generated output with expected output files

Write-Host "Testing scheduler-gpt.exe..." -ForegroundColor Cyan
Write-Host ""

$exePath = ".\scheduler-gpt.exe"
if (-not (Test-Path $exePath)) {
    Write-Host "Error: scheduler-gpt.exe not found!" -ForegroundColor Red
    Write-Host "Please compile first with: rustc scheduler-gpt.rs" -ForegroundColor Yellow
    exit 1
}

# Get all .in files
$inFiles = Get-ChildItem -Filter "*.in" | Sort-Object Name

if ($inFiles.Count -eq 0) {
    Write-Host "No .in files found!" -ForegroundColor Red
    exit 1
}

$passed = 0
$failed = 0
$failedTests = @()

foreach ($inFile in $inFiles) {
    $baseName = $inFile.BaseName
    $expectedOut = "$baseName.out"
    $generatedOut = "$baseName.out"
    
    Write-Host "Testing: $($inFile.Name)" -NoNewline
    
    # Check if expected output exists
    if (-not (Test-Path $expectedOut)) {
        Write-Host " [SKIP - No expected output]" -ForegroundColor Yellow
        continue
    }
    
    # Backup expected output
    $backupOut = "$baseName.out.expected"
    Copy-Item $expectedOut $backupOut -Force
    
    # Run the program (suppress output)
    & $exePath $inFile.Name *> $null
    $exitCode = $LASTEXITCODE
    
    if ($exitCode -ne 0) {
        Write-Host " [FAIL - Program exited with error]" -ForegroundColor Red
        $failed++
        $failedTests += $inFile.Name
        Remove-Item $backupOut -ErrorAction SilentlyContinue
        continue
    }
    
    # Compare outputs
    $expectedContent = Get-Content $backupOut -Raw
    $generatedContent = Get-Content $generatedOut -Raw
    
    if ($expectedContent -eq $generatedContent) {
        Write-Host " [PASS]" -ForegroundColor Green
        $passed++
    } else {
        Write-Host " [FAIL]" -ForegroundColor Red
        $failed++
        $failedTests += $inFile.Name
        
        # Show first difference (optional - comment out if too verbose)
        Write-Host "  Differences found. Use 'fc $expectedOut $backupOut' to see details" -ForegroundColor Yellow
    }
    
    # Restore expected output from backup
    Copy-Item $backupOut $expectedOut -Force
    Remove-Item $backupOut -ErrorAction SilentlyContinue
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Test Results:" -ForegroundColor Cyan
Write-Host "  Passed: $passed" -ForegroundColor Green
Write-Host "  Failed: $failed" -ForegroundColor $(if ($failed -eq 0) { "Green" } else { "Red" })
Write-Host "========================================" -ForegroundColor Cyan

if ($failed -gt 0) {
    Write-Host ""
    Write-Host "Failed tests:" -ForegroundColor Red
    foreach ($test in $failedTests) {
        Write-Host "  - $test" -ForegroundColor Red
    }
    Write-Host ""
    Write-Host "To see differences, run:" -ForegroundColor Yellow
    Write-Host "  fc <testname>.out <testname>.out.expected" -ForegroundColor Yellow
    exit 1
} else {
    Write-Host ""
    Write-Host "All tests passed! ✓" -ForegroundColor Green
    exit 0
}
