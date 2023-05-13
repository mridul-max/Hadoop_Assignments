ordersCSV = LOAD '/user/maria_dev/diplomacy/orders.csv' USING PigStorage(',')AS
	(game_id:chararray,
    unit_id:chararray,
    unit_order:chararray,
    location:chararray,
    target:chararray,
    target_dest:chararray,
    success:chararray,
    reason:chararray,
    turn_num:chararray);

filtered_data = FILTER ordersCSV BY (target == '"Holland"');
group_by_location = GROUP filtered_data BY location;

count_specified_location = FOREACH group_by_location GENERATE group as location, '"Holland"' as target, COUNT($1) as total;
result = ORDER count_specified_location BY location;

describe result;
DUMP result;