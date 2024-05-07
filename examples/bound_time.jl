using Dates
using BoundTypes

# YES
TimeAfterNow{Date}(Date("2030-01-01"))
TimeAfter{Date,Date(2023)}(Date("2024-01-01"))
# NO
TimeAfterNow{Date}(Date("2020-01-01"))
TimeAfter{Date,Date(2023)}(Date("2020-01-01"))

# YES
TimeBeforeOrEqualNow{Time}(Time(1))
TimeBeforeOrEqual{Time,Time(12)}(Time("2:00:00"))
TimeBeforeOrEqual{Time,Time(12)}(Time("12:00:00"))
# NO
TimeBeforeOrEqualNow{Time}(Time("23:59:00"))
TimeBeforeOrEqual{Time,Time(12)}(Time("13:00:00"))

# YES
TimePeriodAfterNow{DateTime,Day(1)}(now() + Hour(12))
TimePeriodBeforeNow{DateTime,Day(1)}(now() - Hour(12))
# NO
TimePeriodAfterNow{DateTime,Day(1)}(now() + Hour(1) + Day(1))
TimePeriodBeforeNow{DateTime,Day(1)}(now() - Hour(1) + Day(1))

# YES
TimeInterval{DateTime,DateTime(2020),<=,<,DateTime(2025)}(DateTime(2024))
# NO
TimeInterval{DateTime,DateTime(2020),<=,<,DateTime(2025)}(DateTime(2017))
TimeInterval{DateTime,DateTime(2020),<=,<,DateTime(2025)}(DateTime(2030))

# Nested bounds
# YES
TimeAfterOrEqual{TimeBefore{Time,Time(15)},Time(5)}(Time("10:00:00"))
# NO
TimeAfterOrEqual{TimeBefore{Time,Time(15)},Time(5)}(Time("20:00:00"))
TimeAfterOrEqual{TimeBefore{Time,Time(15)},Time(5)}(Time("2:00:00"))
