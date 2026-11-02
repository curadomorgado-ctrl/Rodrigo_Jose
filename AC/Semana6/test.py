from pathlib import Path
import pandas as pd

# Start from the folder containing this script and search upward
start = Path(__file__).resolve().parent
csv_path = None
for folder in [start, *start.parents]:
    candidate = folder / "datasets" / "CORK_STOPPERS.csv"
    if candidate.exists():
        csv_path = candidate
        break

if csv_path is None:
    raise FileNotFoundError(
        f"CORK_STOPPERS.csv not found in any 'datasets' folder above {start}"
    )

print("Reading:", csv_path)

xlsFile = pd.read_csv(
    csv_path,
    usecols=["ART", "N.1", "PRT", "ARM", "PRM", "ARTG", "NG", "PRTG", "RAAR", "RAN"]
)