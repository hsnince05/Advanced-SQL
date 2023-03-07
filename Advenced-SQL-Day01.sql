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
do $$
declare
    film_count integer :=0;
begin
    select count(*) -- kaç tane film varsa sayısını getirir
    into film_count -- Query den gelen neticeyi film_count isimli değişkene atar
    from film; -- tabloyu seçiyorum
    
    raise notice 'The number of films is %', film_count; -- % işareti yer tutucu olarak kullanılıyor
end  $$ ;
--***************************************************************
--********************* VARIABLES - CONSTANT ********************
--***************************************************************
do $$
declare
    counter     integer :=1;
    first_name  varchar(50) := 'John';
    last_name   varchar(50) := 'Doe';
    payment     numeric(4,2) := 20.5;
begin
    raise notice '% % % has been paid % USD',
                counter,
                first_name,
                last_name,
                payment;
end $$;
-- Task 1 : değişkenler oluşturarak ekrana " Ahmet ve Mehmet beyler 120 tl ye bilet aldılar. " 
--              cümlesini ekrana basınız
do $$
declare
    first_person    varchar(50) := 'Ahmet';
    second_person   varchar(50) := 'Mehmet';
    payment         numeric(3)  := 120;
begin
    raise notice '% ve % beyler % tl ye bilet aldılar',
                first_person,
                second_person,
                payment;
end $$;
--********************* BEKLETME KOMUDU **************************
do $$
declare
    created_at  time := now();
begin
    raise notice '%', created_at;
    perform pg_sleep(10); -- 10 saniye bekleniyor
    raise notice '%', created_at; -- çıktıda aynı değer görünecek
end $$;
                
--********************* TABLODAN DATA TİPİNİ KOPLAMA *******************
    /*
        -> variable_name  table_name.column_name%type;  
        ->( Tablodaki datanın aynı data türünde variable oluşturmaya yarıyor)
    */
    
do $$
declare
    film_title film.title%type;  -- varchar;      
begin
    -- 1 id li filmin ismini getirelim
    select title
    from film
    into film_title  -- film_title = 'Kuzuların Sessizliği'
    where id=1;
    
    raise notice 'Film title id 1 : %' , film_title;
end $$ ;
--********************* İÇ İÇE BLOK YAPILARI *******************
do $$
<<outher_block>>
declare
    counter integer :=0;
begin
    counter := counter + 1;
    raise notice 'The current value of counter is %', counter;
    
    declare
        counter integer :=0;
    
    begin
        counter := counter +10 ;
        raise notice 'Counter in the subBlock is %', counter;
        raise notice 'Counter in the OutherBlock is %', outher_block.counter;
    
    end;
    
    raise notice 'Counter in the outherBlock is %', counter;
    
end outher_block $$ ;
-- *********************** Row Type **************************
do $$
declare
    selected_actor  actor%rowtype;
begin
    select *  -- id, isim, soyisim
    from actor
    into selected_actor -- id,isim,soyisim
    where id=2;
    
    raise notice 'The actor name is % %',
                    selected_actor.isim,
                    selected_actor.soyisim;
end $$ ;
-- *********************** Record Type *********************
    /*
        -> Row Type gibi çalışır ama record un tamamı değilde belli başlıkları almak 
        istersek kullanılabilir
    */
    
do $$
declare
    rec record; -- record data türünde rec isminde değişken oluşturuldu
begin
    select id,title,type
    into rec
    from film
    where id = 1;
    
    raise notice '% % %' , rec.id, rec.title, rec.type;
end $$ ;