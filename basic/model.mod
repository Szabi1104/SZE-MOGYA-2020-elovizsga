param nRows;
set Rows := 1..nRows;
set ProductGroups;
param space{ProductGroups};
param cashierCount;
param cashierLength;

var IsThereACashier{Rows} binary;
var RowLength{Rows}>=0;
var maxRow;
var ProductsInRow{ProductGroups, Rows} binary;

s.t. SetTheCashiers{r in Rows: r<=cashierCount}:
	IsThereACashier[r] = 1;

s.t. OneProductGroupInOneRowOnly{p in ProductGroups}:
	sum{r in Rows} ProductsInRow[p, r] = 1;

s.t. CalculateTheLengthOfTheRows{r in Rows}:
	RowLength[r] = IsThereACashier[r] * cashierLength + sum{p in ProductGroups} ProductsInRow[p, r] * space[p];

s.t. MaxRowSetter{r in Rows}:
	maxRow >= RowLength[r];

minimize BuildingLength : maxRow;