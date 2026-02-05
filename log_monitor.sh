#!/bin/bash
log_file="$1"

# 1 & 2. Validate file existence and readability
if [ -z "$log_file" ] || [ ! -f "$log_file" ] || [ ! -r "$log_file" ]; then
    echo "Error: File not found or not readable."
    exit 1
fi

# 3. Count entries
total_entries=$(wc -l < "$log_file")
info_count=$(grep -c "INFO" "$log_file")
warn_count=$(grep -c "WARNING" "$log_file")
error_count=$(grep -c "ERROR" "$log_file")

echo "Analysis Report"
echo "---------------"
echo "Total Entries: $total_entries"
echo "INFO: $info_count"
echo "WARNING: $warn_count"
echo "ERROR: $error_count"

# 4. Most recent ERROR
echo "Most Recent ERROR:"
grep "ERROR" "$log_file" | tail -n 1

# 5. Generate Report
report_name="logsummary_$(date +%F).txt"
{
    echo "Date: $(date)"
    echo "Log File: $log_file"
    echo "Total Entries: $total_entries"
    echo "INFO: $info_count | WARNING: $warn_count | ERROR: $error_count"
} > "$report_name"

echo "Report saved to $report_name"g