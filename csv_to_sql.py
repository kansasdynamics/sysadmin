#!/usr/bin/env python3
import csv
import argparse

def escape_quotes(value):
    """Escape single quotes by doubling them, which is required in SQL string literals."""
    return value.replace("'", "''")

def csv_to_sql(csv_filename, output_filename=None):
    sql_statements = []

    # Update the column names to match the CSV
    with open(csv_filename, 'r', newline='', encoding='utf-8') as csvfile:
        # Initialize the DictReader expecting the CSV header to have the correct column names
        reader = csv.DictReader(csvfile)
        for row in reader:
            vendor = escape_quotes(row.get("Vendor", ""))
            branch = escape_quotes(row.get("Branch", ""))
            approver1 = escape_quotes(row.get("Approver1", ""))
            approver1_limit = escape_quotes(row.get("Approver1Limit", ""))
            approver2 = escape_quotes(row.get("Approver2", ""))

            # Compose the SQL INSERT statement
            sql = (
                "INSERT INTO Approvers (Vendor, Branch, Approver1, Approver1Limit, Approver2) "
                f"VALUES ('{vendor}', '{branch}', '{approver1}', '{approver1_limit}', '{approver2}');"
            )
            sql_statements.append(sql)

    # Write to the output file if provided, otherwise print each SQL statement.
    if output_filename:
        with open(output_filename, 'w', encoding='utf-8') as outfile:
            outfile.write("\n".join(sql_statements))
        print(f"SQL statements have been written to {output_filename}.")
    else:
        for statement in sql_statements:
            print(statement)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description="Convert CSV file to SQL Insert statements for table 'Approvers'."
    )
    parser.add_argument("csv_file", help="Path to the CSV file.")
    parser.add_argument("-o", "--output", help="Output file to write SQL statements. Defaults to stdout if not provided.")
    
    args = parser.parse_args()
    
    csv_to_sql(args.csv_file, args.output)
