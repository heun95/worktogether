--VO에 객체 만드는법 
select 'private ' ||
    decode(lower(data_type), 'number', 'int ', 'String ') ||
    lower(column_name) || ';'
from cols
where lower(table_name) = 'moram'; --테이블명 변경

