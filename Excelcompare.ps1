# Set paths to the files
$currentDateFile = "C:\Path\to\current_date.xlsx"
$yesterdayDateFile = "C:\Path\to\yesterday_date.xlsx"

# Load Excel COM objects
$excel = New-Object -ComObject Excel.Application
$excel.Visible = $false
$excel.DisplayAlerts = $false

# Open the current date file
$currentDateWorkbook = $excel.Workbooks.Open($currentDateFile)
$currentDateWorksheet = $currentDateWorkbook.Sheets.Item(1)

# Open the yesterday date file
$yesterdayDateWorkbook = $excel.Workbooks.Open($yesterdayDateFile)
$yesterdayDateWorksheet = $yesterdayDateWorkbook.Sheets.Item(1)

# Get the used range of both worksheets
$currentDateRange = $currentDateWorksheet.UsedRange
$yesterdayDateRange = $yesterdayDateWorksheet.UsedRange

# Compare the rows
$newRows = @()
foreach ($row in $currentDateRange.Rows) {
    $found = $false
    foreach ($yesterdayRow in $yesterdayDateRange.Rows) {
        $currentRowValues = $row.Value2
        $yesterdayRowValues = $yesterdayRow.Value2
        
        if (($currentRowValues -ne $null) -and ($yesterdayRowValues -ne $null) -and ($currentRowValues -eq $yesterdayRowValues)) {
            $found = $true
            break
        }
    }
    
    if (-not $found) {
        $newRows += $row.Value2
    }
}

# Create a new workbook with the same header
if ($newRows.Count -gt 0) {
    $newWorkbook = $excel.Workbooks.Add()
    $newWorksheet = $newWorkbook.Sheets.Item(1)
    
    # Add header
    $headerRow = $currentDateRange.Rows.Item(1).Value2
    $newWorksheet.Cells.Item(1, 1).Value2 = $headerRow
    
    # Add new rows
    for ($i = 0; $i -lt $newRows.Count; $i++) {
        $newWorksheet.Cells.Item($i + 2, 1).Value2 = $newRows[$i]
    }
    
    $newWorkbook.SaveAs("C:\Path\to\new_data.xlsx")
    $newWorkbook.Close()
    
    Write-Host "New data found. Created new_data.xlsx."
} else {
    Write-Host "No new data found."
}

# Close workbooks and quit Excel
$currentDateWorkbook.Close()
$yesterdayDateWorkbook.Close()
$excel.Quit()

# Release COM objects
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($currentDateWorksheet) | Out-Null
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($yesterdayDateWorksheet) | Out-Null
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($currentDateWorkbook) | Out-Null
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($yesterdayDateWorkbook) | Out-Null
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($excel) | Out-Null
