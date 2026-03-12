# Test script for scheduler-gpt.exe
# Compares generated output with expected output files

Write-Host 'Testing scheduler-gpt.exe...' -ForegroundColor Cyan
Write-Host ''

$exePath = '.\scheduler-gpt.exe'

if (-not (Test-Path $exePath)) {
    Write-Host 'Error: scheduler-gpt.exe not found.' -ForegroundColor Red
    Write-Host 'Please compile first with: rustc scheduler-gpt.rs -o scheduler-gpt.exe' -ForegroundColor Yellow
    exit 1
}

$inFiles = Get-ChildItem -Filter '*.in' | Sort-Object Name

if ($inFiles.Count -eq 0) {
    Write-Host 'No .in files found.' -ForegroundColor Red
    exit 1
}

$passed = 0
$failed = 0
$failedTests = @()

foreach ($inFile in $inFiles) {
    $baseName = $inFile.BaseName
    $expectedOut = "$baseName.out"
    $backupOut = "$baseName.out.expected"

    Write-Host "Testing: $($inFile.Name)" -NoNewline

    if (-not (Test-Path $expectedOut)) {
        Write-Host ' [SKIP - no expected output]' -ForegroundColor Yellow
        continue
    }

    Copy-Item $expectedOut $backupOut -Force

    & $exePath $inFile.Name *> $null
    $exitCode = $LASTEXITCODE

    if ($exitCode -ne 0) {
        Write-Host ' [FAIL - program exited with error]' -ForegroundColor Red
        $failed++
        $failedTests += $inFile.Name
        if (Test-Path $backupOut) {
            Copy-Item $backupOut $expectedOut -Force
            Remove-Item $backupOut -Force
        }
        continue
    }

    $expectedContent = Get-Content $backupOut -Raw
    $generatedContent = Get-Content $expectedOut -Raw

    if ($expectedContent -eq $generatedContent) {
        Write-Host ' [PASS]' -ForegroundColor Green
        $passed++
    }
    else {
        Write-Host ' [FAIL]' -ForegroundColor Red
        $failed++
        $failedTests += $inFile.Name
        Write-Host ' Differences found. Compare these two files:' -ForegroundColor Yellow
        Write-Host "   $expectedOut" -ForegroundColor Yellow
        Write-Host "   $backupOut" -ForegroundColor Yellow
    }

    Copy-Item $backupOut $expectedOut -Force
    Remove-Item $backupOut -Force
}

Write-Host ''
Write-Host '========================================' -ForegroundColor Cyan
Write-Host 'Test Results:' -ForegroundColor Cyan
Write-Host "Passed: $passed" -ForegroundColor Green

if ($failed -eq 0) {
    Write-Host "Failed: $failed" -ForegroundColor Green
}
else {
    Write-Host "Failed: $failed" -ForegroundColor Red
}

Write-Host '========================================' -ForegroundColor Cyan

if ($failed -gt 0) {
    Write-Host ''
    Write-Host 'Failed tests:' -ForegroundColor Red
    foreach ($test in $failedTests) {
        Write-Host " - $test" -ForegroundColor Red
    }
    exit 1
}
else {
    Write-Host ''
    Write-Host 'All tests passed!' -ForegroundColor Green
    exit 0
}