    create table osoba(
        id serial primary key,
        imie varchar,
        nazwisko varchar,
        data_ur date,
        nr_tel int,
        haslo varchar);

    create table klient(
        id_klienta serial primary key);

    create table pokoj(
            nr_pokoju int primary key,
            id_kategorii serial,
            ilosc_miejsc int,
            ilosc_podwojnych_lozek int default 0,
            ilosc_pojedynczych_lozek int default 0);

    create table kategoria(
            id_kategorii serial primary key,
            telewizor bit,
            wanna bit,
            prysznic bit,
            barek bit,
            balkon bit);

    create table konsjerz(
            id_konsjerza serial primary key,
            data_od date,
            data_do date);

    create table wlasciciel_hotelu(
            id_wlasciciela serial primary key,
            data_od date,
            data_do date);

    create table udogodnienia(
            id_udogodnienia serial primary key,
            limuzyna bit,
            taxi bit,
            sniadanie_do_pokoju bit,
            dodatkowe_sprzatanie bit);

    create table wynajecie(
            id_wynajecia serial primary key,
            id_klienta serial,
            nr_pokoju serial,
            data_od date,
            data_do date,
            id_udogodnienia int,
            id_konsjerza int,
            czy_uregulowano int default 0,
            ilosc_podwojnych_lozek int,
            ilosc_pojedynczych_lozek int);

    ALTER TABLE klient
    ADD CONSTRAINT fk_id_klienta
    FOREIGN KEY (id_klienta) 
    REFERENCES osoba(id);

    ALTER TABLE pokoj
    ADD CONSTRAINT fk_id_kategorii
    FOREIGN KEY (id_kategorii) 
    REFERENCES kategoria(id_kategorii);

    ALTER TABLE konsjerz
    ADD CONSTRAINT fk_id_konsjerza
    FOREIGN KEY (id_konsjerza) 
    REFERENCES osoba(id);

    ALTER TABLE wlasciciel_hotelu 
    ADD CONSTRAINT fk_id_wlasciciela
    FOREIGN KEY (id_wlasciciela) 
    REFERENCES osoba(id);

    ALTER TABLE wynajecie 
    ADD CONSTRAINT fk_id_klienta
    FOREIGN KEY (id_klienta) 
    REFERENCES klient(id_klienta);

    ALTER TABLE wynajecie 
    ADD CONSTRAINT fk_nr_pokoju
    FOREIGN KEY (nr_pokoju) 
    REFERENCES pokoj(nr_pokoju);

    ALTER TABLE wynajecie 
    ADD CONSTRAINT fk_id_udogodnienia
    FOREIGN KEY (id_udogodnienia) 
    REFERENCES udogodnienia(id_udogodnienia);

    ALTER TABLE wynajecie 
    ADD CONSTRAINT fk_id_konsjerza
    FOREIGN KEY (id_konsjerza) 
    REFERENCES konsjerz(id_konsjerza);

    alter sequence kategoria_id_kategorii_seq restart;
    alter sequence udogodnienia_id_udogodnienia_seq restart;

    insert into kategoria(telewizor,wanna, prysznic,barek,balkon) values(b'1',b'1',b'1',b'1',b'1');
    insert into kategoria(telewizor,wanna, prysznic,barek,balkon) values(b'1',b'1',b'1',b'1',b'0');
    insert into kategoria(telewizor,wanna, prysznic,barek,balkon) values(b'1',b'1',b'1',b'0',b'1');
    insert into kategoria(telewizor,wanna, prysznic,barek,balkon) values(b'1',b'1',b'1',b'0',b'0');
    insert into kategoria(telewizor,wanna, prysznic,barek,balkon) values(b'1',b'1',b'0',b'1',b'1');
    insert into kategoria(telewizor,wanna, prysznic,barek,balkon) values(b'1',b'1',b'0',b'1',b'0');
    insert into kategoria(telewizor,wanna, prysznic,barek,balkon) values(b'1',b'1',b'0',b'0',b'1');
    insert into kategoria(telewizor,wanna, prysznic,barek,balkon) values(b'1',b'1',b'0',b'0',b'0');
    insert into kategoria(telewizor,wanna, prysznic,barek,balkon) values(b'1',b'0',b'1',b'1',b'1');
    insert into kategoria(telewizor,wanna, prysznic,barek,balkon) values(b'1',b'0',b'1',b'1',b'0');
    insert into kategoria(telewizor,wanna, prysznic,barek,balkon) values(b'1',b'0',b'1',b'0',b'1');
    insert into kategoria(telewizor,wanna, prysznic,barek,balkon) values(b'1',b'0',b'1',b'0',b'0');
    insert into kategoria(telewizor,wanna, prysznic,barek,balkon) values(b'1',b'0',b'0',b'1',b'1');
    insert into kategoria(telewizor,wanna, prysznic,barek,balkon) values(b'1',b'0',b'0',b'1',b'0');
    insert into kategoria(telewizor,wanna, prysznic,barek,balkon) values(b'1',b'0',b'0',b'0',b'1');
    insert into kategoria(telewizor,wanna, prysznic,barek,balkon) values(b'1',b'0',b'0',b'0',b'0');
    insert into kategoria(telewizor,wanna, prysznic,barek,balkon) values(b'0',b'1',b'1',b'1',b'1');
    insert into kategoria(telewizor,wanna, prysznic,barek,balkon) values(b'0',b'1',b'1',b'1',b'0');
    insert into kategoria(telewizor,wanna, prysznic,barek,balkon) values(b'0',b'1',b'1',b'0',b'1');
    insert into kategoria(telewizor,wanna, prysznic,barek,balkon) values(b'0',b'1',b'1',b'0',b'0');
    insert into kategoria(telewizor,wanna, prysznic,barek,balkon) values(b'0',b'1',b'0',b'1',b'1');
    insert into kategoria(telewizor,wanna, prysznic,barek,balkon) values(b'0',b'1',b'0',b'1',b'0');
    insert into kategoria(telewizor,wanna, prysznic,barek,balkon) values(b'0',b'1',b'0',b'0',b'1');
    insert into kategoria(telewizor,wanna, prysznic,barek,balkon) values(b'0',b'1',b'0',b'0',b'0');
    insert into kategoria(telewizor,wanna, prysznic,barek,balkon) values(b'0',b'0',b'1',b'1',b'1');
    insert into kategoria(telewizor,wanna, prysznic,barek,balkon) values(b'0',b'0',b'1',b'1',b'0');
    insert into kategoria(telewizor,wanna, prysznic,barek,balkon) values(b'0',b'0',b'1',b'0',b'1');
    insert into kategoria(telewizor,wanna, prysznic,barek,balkon) values(b'0',b'0',b'1',b'0',b'0');
    insert into kategoria(telewizor,wanna, prysznic,barek,balkon) values(b'0',b'0',b'0',b'1',b'1');
    insert into kategoria(telewizor,wanna, prysznic,barek,balkon) values(b'0',b'0',b'0',b'1',b'0');
    insert into kategoria(telewizor,wanna, prysznic,barek,balkon) values(b'0',b'0',b'0',b'0',b'1');
    insert into kategoria(telewizor,wanna, prysznic,barek,balkon) values(b'0',b'0',b'0',b'0',b'0');

    insert into udogodnienia(limuzyna,taxi,sniadanie_do_pokoju,dodatkowe_sprzatanie) values(b'1',b'1',b'1',b'1');
    insert into udogodnienia(limuzyna,taxi,sniadanie_do_pokoju,dodatkowe_sprzatanie) values(b'1',b'1',b'1',b'0');
    insert into udogodnienia(limuzyna,taxi,sniadanie_do_pokoju,dodatkowe_sprzatanie) values(b'1',b'1',b'0',b'1');
    insert into udogodnienia(limuzyna,taxi,sniadanie_do_pokoju,dodatkowe_sprzatanie) values(b'1',b'1',b'0',b'0');
    insert into udogodnienia(limuzyna,taxi,sniadanie_do_pokoju,dodatkowe_sprzatanie) values(b'1',b'0',b'1',b'1');
    insert into udogodnienia(limuzyna,taxi,sniadanie_do_pokoju,dodatkowe_sprzatanie) values(b'1',b'0',b'1',b'0');
    insert into udogodnienia(limuzyna,taxi,sniadanie_do_pokoju,dodatkowe_sprzatanie) values(b'1',b'0',b'0',b'1');
    insert into udogodnienia(limuzyna,taxi,sniadanie_do_pokoju,dodatkowe_sprzatanie) values(b'1',b'0',b'0',b'0');
    insert into udogodnienia(limuzyna,taxi,sniadanie_do_pokoju,dodatkowe_sprzatanie) values(b'0',b'1',b'1',b'1');
    insert into udogodnienia(limuzyna,taxi,sniadanie_do_pokoju,dodatkowe_sprzatanie) values(b'0',b'1',b'1',b'0');
    insert into udogodnienia(limuzyna,taxi,sniadanie_do_pokoju,dodatkowe_sprzatanie) values(b'0',b'1',b'0',b'1');
    insert into udogodnienia(limuzyna,taxi,sniadanie_do_pokoju,dodatkowe_sprzatanie) values(b'0',b'1',b'0',b'0');
    insert into udogodnienia(limuzyna,taxi,sniadanie_do_pokoju,dodatkowe_sprzatanie) values(b'0',b'0',b'1',b'1');
    insert into udogodnienia(limuzyna,taxi,sniadanie_do_pokoju,dodatkowe_sprzatanie) values(b'0',b'0',b'1',b'0');
    insert into udogodnienia(limuzyna,taxi,sniadanie_do_pokoju,dodatkowe_sprzatanie) values(b'0',b'0',b'0',b'1');
    insert into udogodnienia(limuzyna,taxi,sniadanie_do_pokoju,dodatkowe_sprzatanie) values(b'0',b'0',b'0',b'0');

    delete from udogodnienia where id_udogodnienia > 16;
    delete from kategoria where id_kategorii > 32;

    create or replace function wypelnij_pokoje() returns void as $$
            declare
                licznik integer;
            begin
            for pietro in 1 .. 4 loop
                licznik = 1; 
                for kategoria in 1 .. 32 loop
                    insert into pokoj values(100*pietro+licznik,kategoria,5-pietro);
                    licznik = licznik + 1; 
                end loop;
            end loop;
            end;
    $$ language 'plpgsql';

    select wypelnij_pokoje();

    create or replace function zarezerwowanePokojeOsoby(id_os integer)
        returns table(
            nr_p integer,
            il_m integer,
            d_od date,
            d_do date,
            tv bit,
            wa bit,
            pc bit,
            bk bit,
            bn bit)
        as $$
        begin
            return query
            select p.nr_pokoju,p.ilosc_miejsc,w.data_od,w.data_do,k.telewizor,k.wanna,k.prysznic,k.barek,k.balkon from wynajecie w join pokoj p on w.nr_pokoju = p.nr_pokoju join kategoria k on p.id_kategorii = k.id_kategorii where w.id_klienta = id_os;
        end;
        $$ language 'plpgsql';

    create or replace function cena_za_dzien_wg_kategorii(id_k integer) returns integer
    as $$
    declare
        myRow kategoria;
        cena integer;
    begin
        cena:=0;
        for myRow in select * from kategoria where id_kategorii = id_k
            loop
            if myRow.telewizor then
                cena:= cena+ 10;
                end if;
            if myRow.wanna then
                cena:= cena + 15;
            end if;
                if myRow.prysznic then
                cena:= cena + 5;
                end if;

                if myRow.barek then 
                cena:= cena + 40;
                end if;

                    if myRow.balkon then
                        cena:=cena + 50;
                end if;

                
            end loop;
            return cena;
    end;
    $$ language 'plpgsql';

    create or replace function cena_za_dzien_wg_udogodnienia(id_u integer) returns integer
    as $$
        declare
        myRow udogodnienia;
        cena integer;
    begin
        cena:=0;
        for myRow in select * from udogodnienia where id_udogodnienia = id_u
            loop
                if myRow.limuzyna then
                    cena:= cena + 400;
                end if;
                if myRow.taxi then 
                    cena:= cena + 100;
                end if;
                if myRow.sniadanie_do_pokoju then
                    cena:= cena + 15;
                end if;
                if myRow.dodatkowe_sprzatanie then
                    cena:= cena + 20;
                end if;
            end loop;
            return cena;
    end;
    $$ language 'plpgsql';


    create or replace function rachunek(id_w integer) returns integer
    as $$
        declare 
        liczba_dni integer;
        d_od date;
        d_do date;
    begin
        liczba_dni := 0;
        select data_od from wynajecie where id_wynajecia = id_w into d_od;
        select data_do from wynajecie where id_wynajecia = id_w into d_do;
        if current_date > d_do
        then 

    liczba_dni := d_do - d_od + 1;

        else
        liczba_dni := current_date - d_od + 1;
        
            
        end if;

        if current_date >= d_od and (select czy_uregulowano from wynajecie where id_wynajecia = id_w) = 0
            then
            raise notice 'ilosc dni %',liczba_dni;
            return (select liczba_dni * (cena_za_dzien_wg_kategorii(p.id_kategorii) + cena_za_dzien_wg_udogodnienia(w.id_udogodnienia) + 150 + 50*p.ilosc_miejsc) from wynajecie w join pokoj p on w.nr_pokoju = p.nr_pokoju where w.id_wynajecia=id_w);
        end if;
        return 0;
    end;
    $$ language 'plpgsql';



    create or replace function przychod(nr_p integer) returns integer 
    as $$
    declare
        myRow wynajecie;
        przychod integer;
        liczba_dni integer;
        id_k integer;
        ile_osob integer;
    begin
        przychod:=0;
        id_k = (select id_kategorii from pokoj where nr_pokoju = nr_p);
        ile_osob = (select ilosc_miejsc from pokoj where nr_pokoju = nr_p);
        for myRow in select * from wynajecie where nr_pokoju = nr_p
        loop
            liczba_dni = myRow.data_do - myRow.data_od + 1;
            RAISE NOTICE 'ilosc dni % od % do %',liczba_dni,myRow.data_od,myRow.data_do;
            przychod:= przychod +  liczba_dni * (cena_za_dzien_wg_kategorii(id_k) + cena_za_dzien_wg_udogodnienia(myRow.id_udogodnienia) + 150 + 50*ile_osob);
            end loop; 
            return przychod;
    end;
    $$ language 'plpgsql';

    create view rachunki_klientow as select id_wynajecia,id_klienta,nr_pokoju,rachunek(id_wynajecia) as rachunek from wynajecie;

    create view dostepne_pokoje as select p.nr_pokoju,p.id_kategorii,p.ilosc_miejsc,k.telewizor,k.wanna,k.prysznic,k.barek,k.balkon from pokoj p join kategoria k on p.id_kategorii = k.id_kategorii where p.nr_pokoju not in (select nr_pokoju from wynajecie)
    union
    select w.nr_pokoju,p.id_kategorii,p.ilosc_miejsc,k.telewizor,k.wanna,k.prysznic,k.barek,k.balkon from wynajecie w join pokoj p on p.nr_pokoju=w.nr_pokoju join kategoria k on p.id_kategorii = k.id_kategorii where (select max(data_do) from wynajecie where nr_pokoju = p.nr_pokoju group by nr_pokoju)  < NOW();

    create view najczesciej_wynajmowane as select count(*) as ile_razy,nr_pokoju from wynajecie group by nr_pokoju order by ile_razy desc limit 3;

    create view najbardziej_oplacalne as select nr_pokoju,przychod(nr_pokoju) from wynajecie group by nr_pokoju order by przychod(nr_pokoju) desc limit 3;



 

    create or replace function dostepny_pokoj_z_data(d_od date, d_do date,id_k integer,il_miejsc integer)
        returns integer
        as $$
        declare
            numer integer; 
            rec record; 
            mask integer;
        begin
            perform w.nr_pokoju from wynajecie w join pokoj p on w.nr_pokoju = p.nr_pokoju join kategoria k on p.id_kategorii = k.id_kategorii where k.id_kategorii = id_k and p.ilosc_miejsc = il_miejsc group by w.nr_pokoju;
            if found then
            foreach numer in array (select array(select w.nr_pokoju from wynajecie w join pokoj p on w.nr_pokoju = p.nr_pokoju join kategoria k on p.id_kategorii = k.id_kategorii where k.id_kategorii = id_k group by w.nr_pokoju))
                loop
                    mask := 0;
                    for rec in select * from wynajecie where nr_pokoju = numer

                        loop
                            if not (d_od > rec.data_do or d_do < rec.data_od) then
                                mask := mask+1;
                                exit;
                            end if;
                        end loop;
                    IF mask = 0 THEN
                        RETURN rec.nr_pokoju;
                    end if;
                end loop;
            return 0;   
        else 
            return (select nr_pokoju from dostepne_pokoje where id_kategorii = id_k and ilosc_miejsc = il_miejsc limit 1);
        end if;
        end;
        $$ language 'plpgsql'
            set search_path = projektdb;


    create or replace function check_inserted_values() returns trigger
        as $$
        begin
            if new.data_od < CURRENT_DATE then
                    RAISE EXCEPTION 'Nie mozesz rezerwowac w przeszlosci. Podaj poprawna date';
            elsif new.data_do > NOW() + interval '1 year' then
                RAISE EXCEPTION 'Oferujemy rezerwacje jedynie z rocznym wyprzedzeniem. Zmien date konca rezerwacji';
            elsif new.data_od > new.data_do then
                RAISE EXCEPTION 'Bledne daty. Zamien je miejscami!';
            else
                return new;
            end if;

        return NULL;
        end;
        $$ language 'plpgsql';

    drop trigger if exists tr_check_inserted_values on wynajecie;
    create trigger tr_check_inserted_values before insert on wynajecie for each row execute procedure check_inserted_values();


    create or replace function wolny_konsjerz(d_od date,d_do date) returns integer
    as $$
        declare
        il_dni integer;
        id_k integer;
    begin
        il_dni := d_do - d_od + 1;

        if (select count(*) from wynajecie) = 0 then
            return (select id_konsjerza from konsjerz limit 1);
        end if;

        foreach id_k in array (select array(select id_konsjerza from konsjerz)) loop
            raise notice 'id konsjerza %',id_k;
            if id_k not in (select id_konsjerza from wynajecie group by id_konsjerza) then 
                raise notice 'halo halo';
                return id_k;
            end if;
        end loop;

        foreach id_k in array (select array(select id_konsjerza from wynajecie group by id_konsjerza)) loop
        if wolny_w_dniach(id_k,d_od,il_dni) = 1 then
            return id_k;
        end if;
    end loop;
        return 0;
    end;
    $$ language 'plpgsql';

    create or replace function wolny_w_dniach(id_k integer,d_od date,ile integer)
    returns integer
    as $$
    begin
        for i in 0 .. ile -1 loop
            if (select count(*) from wynajecie where id_konsjerza = id_k and d_od + i* interval '1 day' between data_od and data_do) > 20 then return 0;
            end if;
        end loop;
        return 1;


    end;
    $$ language 'plpgsql';

    create or replace function dodaj_konsjerza() returns trigger
    as $$
        declare
        id_k integer;
    begin
        select wolny_konsjerz(new.data_od,new.data_do) into id_k;
        raise notice 'id_k : %',id_k;
        if id_k > 0 then
            new.id_konsjerza = id_k;
        else
            raise exception 'Przepraszamy dodatkowe uslugi w tym terminie niedostepne.';
        end if;
        return new;
    end;
    $$ language 'plpgsql';

    drop trigger if exists tr_dodaj_konsjerza on wynajecie;
    create trigger tr_dodaj_konsjerza before insert on wynajecie for each row execute procedure dodaj_konsjerza();

    create or replace function aktualizuj_lozka() returns trigger
    as $$
    begin
        update pokoj set ilosc_podwojnych_lozek = new.ilosc_podwojnych_lozek where nr_pokoju = new.nr_pokoju;
        update pokoj set ilosc_pojedynczych_lozek = new.ilosc_pojedynczych_lozek where nr_pokoju = new.nr_pokoju;
        return new;
    end;
    $$ language 'plpgsql';

    create or replace function sprawdz_ilosc_lozek() returns trigger
    as $$
    declare 
    ilosc_m integer;
    begin
        ilosc_m := (SELECT ilosc_miejsc from pokoj where nr_pokoju = new.nr_pokoju);
        raise notice 'Ilosc lozek';
        if (ilosc_m <> 2*new.ilosc_podwojnych_lozek + new.ilosc_pojedynczych_lozek or new.ilosc_pojedynczych_lozek < 0  ) then
            RAISE EXCEPTION 'Bledna ilosc lozek!';
        end if;
        return new;
    end;
    $$ language 'plpgsql';

    drop trigger if exists tr_sprawdz_ilosc_lozek on wynajecie;
    create trigger tr_sprawdz_ilosc_lozek before insert on wynajecie for each row execute procedure sprawdz_ilosc_lozek();

    drop trigger if exists tr_aktualizuj_lozka on wynajecie;
    create trigger tr_aktualizuj_lozka before insert on wynajecie for each row execute procedure aktualizuj_lozka();

    insert into osoba(imie,nazwisko,data_ur,nr_tel,haslo) values('Anna','Nowak','1981-05-06',211333456,'haslo');

    insert into osoba(imie,nazwisko,data_ur,nr_tel,haslo) values('Jan','Kowalski','1986-06-07',211322457,'haslo');

    insert into wlasciciel_hotelu(id_wlasciciela,data_od) values(1,current_date);
    insert into konsjerz(id_konsjerza,data_od) values(2,current_date);
