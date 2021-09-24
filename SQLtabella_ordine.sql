--Aggiunta entità Ordine (e PizzaOrdine)

create table Ordine
(
	Codice int identity(1,1) constraint PK_ORDINE primary key,
	Totale decimal(9,2) not null
);

create table PizzaOrdine
(
	CodPizza int not null,
	CodOrdine int not null,
	Quantità int not null,

	constraint FK_PIZZA_ORDINATA foreign key (CodPizza) references Pizza(Codice),
	constraint FK_ORDINE foreign key (CodOrdine) references Ordine(Codice),
	constraint PK_PIZZA_ORDINE primary key (CodPizza, CodOrdine)
);

--Procedure per aggiunta ordine

create procedure CreaOrdine
@NomePizza varchar(30),
@Quantita int
as
begin
	begin try
		
		declare @CodPizza int
		declare @PrezzoPizza decimal(6,2)
		declare @CodOrdine int

		select @CodPizza = P.Codice, @PrezzoPizza = P.Prezzo
		from Pizza P
		where P.Nome = @NomePizza

		insert into Ordine values
		(@PrezzoPizza * @Quantita)

		select @CodOrdine = O.Codice
		from Ordine O
		where O.Codice = (select max(Codice) from Ordine)

		insert into PizzaOrdine values
		(@CodPizza, @CodOrdine, @Quantita)

	end try
	begin catch

	select ERROR_MESSAGE(), ERROR_LINE()

	end catch
end

--Precedura per aggiunta di pizze ad un ordine

create procedure AggiungiPizzaOrdine
@NomePizza varchar(30),
@CodOrdine int,
@Quantità int
as
begin
	begin try

	declare @CodPizza int
	declare @PrezzoPizza decimal(6,2)

	select @CodPizza = P.Codice, @PrezzoPizza = P.Prezzo
	from Pizza P
	where P.Nome = @NomePizza

	update Ordine
	set Totale = Totale + @PrezzoPizza * @Quantità
	where Codice = @CodOrdine

	insert into PizzaOrdine values
	(@CodPizza, @CodOrdine, @Quantità)

	end try
	begin catch

	select ERROR_MESSAGE(), ERROR_LINE()

	end catch
end

exec CreaOrdine 'Quattro stagioni', 2; --Codice 2
exec AggiungiPizzaOrdine 'Diavola', 2, 1;
exec AggiungiPizzaOrdine 'Zeus', 2, 3;

exec CreaOrdine 'Margherita', 1; --Codice 3
exec AggiungiPizzaOrdine 'Caprese', 3, 2;

select * from ListaOrdini;



-- view e funzione per stampare la lista degli ordini 

create function ConcatenaPizzePrezzi(@CodOrdine int)
returns varchar(max)
as
begin

	declare @String varchar(max)
	set @String = null

	select @String = ISNULL(@String + '| ', '') + Convert(varchar(30), + ' ' + PO.Quantità) + ' ' + P.Nome + Convert(varchar(30), P.Prezzo)
	from Ordine O
	join PizzaOrdine PO on O.Codice = PO.CodOrdine
	join Pizza P on P.Codice = PO.CodPizza
	where O.Codice = @CodOrdine

	return @String

end

select dbo.ConcatenaPizzePrezzi(2);

create view ListaOrdini as
(select O.Codice as [Codice Ordine], dbo.ConcatenaPizzePrezzi(O.Codice) as [Pizze], O.Totale as [Totale Ordine]
from Ordine O
join PizzaOrdine PO On O.Codice = PO.CodOrdine
join Pizza P on P.Codice = PO.CodPizza
group by O.Codice, O.Totale);