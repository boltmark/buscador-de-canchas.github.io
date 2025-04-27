#!/bin/bash

COURT_NAMES=(
  "Alki Playfield Tennis Court 01"
  "Alki Playfield Tennis Court 02"
  "AYTC Outdoor Tennis Court 01"
  "AYTC Outdoor Tennis Court 02"
  "AYTC Outdoor Tennis Court 03"
  "AYTC Outdoor Tennis Court 04"
  "AYTC Outdoor Tennis Court 05"
  "AYTC Outdoor Tennis Court 06"
  "Beacon Hill Playfield Tennis Court 01"
  "Beacon Hill Playfield Tennis Court 02"
  "Bitter Lake Playfield Tennis Court 01"
  "Bitter Lake Playfield Tennis Court 02"
  "Bitter Lake Playfield Tennis Court 03"
  "Bitter Lake Playfield Tennis Court 04"
  "Brighton Playfield Tennis Court 01"
  "Brighton Playfield Tennis Court 02"
  "Bryant Playground Tennis Court 01"
  "Bryant Playground Tennis Court 02"
  "David Rodgers Park Tennis Court 01"
  "David Rodgers Park Tennis Court 02"
  "David Rodgers Park Tennis Court 03"
  "Dearborn Park Tennis Court 01"
  "Dearborn Park Tennis Court 02"
  "Delridge Playfield Tennis Court 01"
  "Delridge Playfield Tennis Court 02"
  "Discovery Park Tennis Court 01"
  "Discovery Park Tennis Court 02"
  "Froula Playground Tennis Court 01"
  "Froula Playground Tennis Court 02"
  "Garfield Playfield Tennis Court 01"
  "Garfield Playfield Tennis Court 02"
  "Gilman Playfield Tennis Court 01"
  "Gilman Playfield Tennis Court 02"
  "Green Lake Park West Tennis Court 01"
  "Green Lake Park West Tennis Court 02"
  "Hiawatha Playfield Tennis Court 01"
  "Hiawatha Playfield Tennis Court 02"
  "Hiawatha Playfield Tennis Court 03"
  "Jefferson Park Lid Tennis Court Lower 01"
  "Jefferson Park Lid Tennis Court Lower 02"
  "Jefferson Park Lid Tennis Court Upper 01"
  "Jefferson Park Lid Tennis Court Upper 02"
  "Laurelhurst Playfield Tennis Court 01"
  "Laurelhurst Playfield Tennis Court 02"
  "Laurelhurst Playfield Tennis Court 03"
  "Laurelhurst Playfield Tennis Court 04"
  "Lower Woodland Playfield Tennis Court 03"
  "Lower Woodland Playfield Tennis Court 04"
  "Lower Woodland Playfield Tennis Court 05"
  "Lower Woodland Playfield Tennis Court 06"
  "Lower Woodland Playfield Tennis Court 07"
  "Lower Woodland Playfield Tennis Court 08"
  "Lower Woodland Playfield Upper Court 01"
  "Lower Woodland Playfield Upper Court 02"
  "Madison Park Tennis Court 01"
  "Madison Park Tennis Court 02"
  "Madrona Playground Tennis Court 01"
  "Madrona Playground Tennis Court 02"
  "Magnolia Park Tennis Court 01"
  "Magnolia Park Tennis Court 02"
  "Magnolia Playfield Tennis Court 01"
  "Magnolia Playfield Tennis Court 02"
  "Magnolia Playfield Tennis Court 03"
  "Magnolia Playfield Tennis Court 04"
  "Meadowbrook Playfield Tennis Court 01"
  "Meadowbrook Playfield Tennis Court 02"
  "Meadowbrook Playfield Tennis Court 03"
  "Meadowbrook Playfield Tennis Court 04"
  "Meadowbrook Playfield Tennis Court 05"
  "Meadowbrook Playfield Tennis Court 06"
  "Miller Playfield Tennis Court 01"
  "Miller Playfield Tennis Court 02"
  "Montlake Playfield Tennis Court 01"
  "Montlake Playfield Tennis Court 02"
  "Mount Baker Park Tennis Court 01"
  "Mount Baker Park Tennis Court 02"
  "Observatory Tennis Court 01"
  "Observatory Tennis Court 02"
  "Rainier Beach Playfield Tennis Court 01"
  "Rainier Beach Playfield Tennis Court 02"
  "Rainier Beach Playfield Tennis Court 03"
  "Rainier Beach Playfield Tennis Court 04"
  "Rainier Playfield Tennis Court 01"
  "Rainier Playfield Tennis Court 02"
  "Rainier Playfield Tennis Court 03"
  "Rainier Playfield Tennis Court 04"
  "Riverview Playfield Tennis Court 01"
  "Riverview Playfield Tennis Court 02"
  "Rogers Playfield Tennis Court 01"
  "Rogers Playfield Tennis Court 02"
  "Sam Smith (I90 Lid) Park Tennis Court 01"
  "Sam Smith (I90 Lid) Park Tennis Court 02"
  "Seward Park Tennis Court 01"
  "Seward Park Tennis Court 02"
  "Solstice Park Tennis Court 01"
  "Solstice Park Tennis Court 02"
  "Solstice Park Tennis Court 03"
  "Solstice Park Tennis Court 04"
  "Solstice Park Tennis Court 05"
  "Solstice Park Tennis Court 06"
  "Soundview Playfield Tennis Court 01"
  "Soundview Playfield Tennis Court 02"
  "Volunteer Park Court 01 - Upper"
  "Volunteer Park Court 02 - Upper"
  "Volunteer Park Court 03 - Lower"
  "Volunteer Park Court 04 - Lower"
  "Wallingford Playfield Tennis Court 01"
  "Wallingford Playfield Tennis Court 02"
  "Walt Hundley Playfield Tennis Court 01"
  "Walt Hundley Playfield Tennis Court 02"
)

COURT_IDS=(
  1146 1147
  279 280 281 282 283 284
  1319 1320 1315 1316 1317 1318
  1323 1324 1325 1326
  1330 1331 1332
  1333 1334
  1335 1336
  1337 1338
  1339 1340
  1341 1342
  1344 1345
  181 183
  1346 1347 1348
  2277 2278
  777 778
  1353 1354 1355 1356
  355 356 357 358 359 360
  369 370
  1359 1360
  2279 2280
  1361 1362
  1363 1364 1365 1366
  1367 1368 1369 1370 1371 1372
  1373 1374
  1375 1376
  1377 1378
  1119 1120
  1379 1380 1381 1382
  1383 1384 1385 1386
  1387 1388
  1389 1390
  1391 1392
  373 2437
  1393 1394 1395 1396 1397 1398
  1399 1400
  365 366 363 364
  1408 1409
  1410 1411
)

# Function to query and collect available times for a given RESOURCE_ID and DATE
check_availability() {
  local COURT_NAME=$1
  local RESOURCE_ID=$2
  local DATE=$3
  local AVAILABILITY_JSON=""

  # Query the API
  RESPONSE=$(curl -s -L "https://anc.apm.activecommunities.com/seattle/rest/reservation/resource/availability/daily/${RESOURCE_ID}?start_date=${DATE}&end_date=${DATE}&customer_id=0&company_id=0&event_type_id=-1&attendee=1&no_cache=true&locale=en-US")

  # Parse the available times
  TIMES=$(echo "$RESPONSE" | jq -r --arg DATE "$DATE" '
    .body.details.daily_details[]?
    | select(.date == $DATE)
    | .times[]?
    | "\(.start_time) - \(.end_time)"')

  # If no available times, use an empty array
  if [[ -z "$TIMES" ]]; then
    AVAILABILITY_JSON="[]"
  else
    # Format available times into an array
    AVAILABILITY_JSON=$(echo "$TIMES" | jq -R . | jq -s .)
  fi

  # Output the result in JSON format with the court name as key
  echo "{\"name\": \"$COURT_NAME\", \"available_times\": $AVAILABILITY_JSON}"
}

# === Main script ===

# Define the date you want to check
DATE="2025-04-27"

# Initialize an array to store all court availability results
COURT_AVAILABILITIES=()

# Loop through each court and call the function to collect availability data
for i in "${!COURT_IDS[@]}"; do
  COURT_NAME=${COURT_NAMES[$i]}
  RESOURCE_ID=${COURT_IDS[$i]}
  AVAILABILITY_JSON=$(check_availability "$COURT_NAME" "$RESOURCE_ID" "$DATE")
  COURT_AVAILABILITIES+=("$AVAILABILITY_JSON")
done

# Output the full JSON array with all court availability data
echo "["$(IFS=,; echo "${COURT_AVAILABILITIES[*]}")"]"
