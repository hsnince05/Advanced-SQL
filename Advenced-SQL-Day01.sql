CREATE TABLE film
(
id int ,
title VARCHAR(50),
type VARCHAR(50),
length int
);
INSERT INTO film VALUES (1, 'Kuzuların Sessizliği', 'Korku',130);
INSERT INTO film VALUES (2, 'Esaretin Bedeli', 'Macera', 125);
INSERT INTO film VALUES (3, 'Kısa Film', 'Macera',40);
INSERT INTO film VALUES (4, 'Shrek', 'Animasyon',85);

CREATE TABLE actor
(
id int ,
isim VARCHAR(50),
soyisim VARCHAR(50)
);
INSERT INTO actor VALUES (1, 'Christian', 'Bale');
INSERT INTO actor VALUES (2, 'Kevin', 'Spacey');
INSERT INTO actor VALUES (3, 'Edward', 'Norton');



DO $$

DECLARE
	film_count integer :=0;
	
BEGIN

	SELECT COUNT(*)  -- Kac tane film varsa sayisini getirir.
	INTO film_count  -- Query'den gelen neticeyi film_count isimli degiskene atar.
	FROM film;  	 -- Tabloyu seciyorum.
	
	RAISE NOTICE 'The number of films is %', film_count; --  % isareti yer tutucu olarak kullaniliyor.
	
END $$ ;


--********************************************************************************
--*******************VARIABLES - CONSTANT ****************************************
--********************************************************************************

DO $$
DECLARE 
	counter integer:=1;
	first_name  varchar(50) :='John';
	last_name   varchar(50) :='Doe';
	payment     numeric(4,2) := 20.5;
BEGIN

	raise notice '% % % has been paid % USD',
				 counter,
				 first_name,
				 last_name,
				 payment;
end $$;

-- Task 1 : değişkenler oluşturarak ekrana " Ahmet ve Mehmet beyler 120 tl ye bilet aldılar. "" cümlesini ekrana basınız

DO $$
DECLARE 
	
	first_person  varchar(50) :='Ahmet';
	last_person   varchar(50) :='Mehmet';
	payment     numeric(3) := 120;
BEGIN

	raise notice '% ve % beyler % TL ye bilet aldilar',
				
				 first_person,
				 last_person,
				 payment;
end $$;

--**********************BEKLETME KOMUDU *********************************

do $$
declare 
	created_at time := now();
begin
	raise notice '%', created_at;
	perform pg_sleep(10); -- 10 saniye bekleniyor
	raise notice '%',created_at; -- çıktıda aynı deger gorunecek 
end $$;

-- ********************* TABLODAN DATA TIPINI KOPYALAMA *********************
	/*
		-> variable_name  table_name.column_name%type;
		->( Tablodaki datanın aynı data türünde variable oluşturmaya yarıyor)
	*/
do $$
declare
	film_title film.title %type; -- varchar;		
begin
	-- 1 id li filmin ismini getirelim
	select title
	from film
	into film_title
	where id=1;
	raise notice 'Film title id 1 : %', film_title;
end $$;


--***************** İC İCE BLOK yapıları ***************************
do $$
<<outher_block>>
declare
	counter integer :=0;
begin
	counter := counter +1;
	raise notice 'The curent valur of counter is %', counter;
	
	declare
		counter integer :=0;
	begin
		counter:= counter+10;
	raise notice 'Counter in the subBlock is %', counter;
	raise notice 'Counter in the OutherBlock is %', outher_block.counter;
	end;
	
	raise notice 'Counter in the outherBlock is %', counter;
end outher_block $$;

	












