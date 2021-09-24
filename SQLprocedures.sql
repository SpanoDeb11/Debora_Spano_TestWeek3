--Procedures

--1. Inserimento di una nuova pizza (parametri: nome, prezzo) 

create procedure InserisciPizza
@Nome varchar(30),
@Prezzo decimal(6,2)
as
begin
	begin try

	insert into Pizza values
	(@Nome, @Prezzo)

	end try
	begin catch

	select ERROR_MESSAGE(), ERROR_LINE()

	end catch
end

exec InserisciPizza 'Pizza inserita', 5.50;

select * from Pizza;

--2. Assegnazione di un ingrediente a una pizza (parametri: nome pizza, nome ingrediente) 

create procedure AssegnaIngrediente
@NomePizza varchar(30),
@NomeIngrediente varchar(30)
as
begin
	begin try

	declare @CodPizza int
	declare @CodIngrediente int

	select @CodPizza = P.Codice
	from Pizza P
	where P.Nome = @NomePizza

	select @CodIngrediente = I.Codice
	from Ingrediente I
	where I.Nome = @NomeIngrediente

	insert into PizzaIngrediente values
	(@CodPizza, @CodIngrediente)

	end try
	begin catch

	select ERROR_MESSAGE(), ERROR_LINE()

	end catch
end

exec AssegnaIngrediente 'Pizza inserita', 'Pomodoro';

select * from PizzaIngrediente;

--3. Aggiornamento del prezzo di una pizza (parametri: nome e nuovo prezzo)

create procedure AggiornaPrezzoPizza
@NomePizza varchar (30),
@NuovoPrezzo decimal(6,2)
as
begin
	begin try

	update Pizza
	set Prezzo = @NuovoPrezzo
	where Nome = @NomePizza

	end try
	begin catch

	select ERROR_MESSAGE(), ERROR_LINE()

	end catch
end

exec AggiornaPrezzoPizza 'Pizza inserita', 3.5;

select * from Pizza;

--4. Eliminazione di un ingrediente da una pizza (parametri: nome pizza, nome ingrediente) 

create procedure EliminaIngrediente
@NomePizza varchar(30),
@NomeIngrediente varchar(30)
as
begin
	begin try

	declare @CodPizza int
	declare @CodIngrediente int

	select @CodPizza = P.Codice
	from Pizza P
	where P.Nome = @NomePizza

	select @CodIngrediente = I.Codice
	from Ingrediente I
	where I.Nome = @NomeIngrediente

	delete from PizzaIngrediente
	where CodPizza = @CodPizza and CodIngrediente = @CodIngrediente

	end try
	begin catch

	select ERROR_MESSAGE(), ERROR_LINE()

	end catch
end

exec EliminaIngrediente 'Pizza inserita', 'Pomodoro';

select * from PizzaIngrediente;

--5. Incremento del 10% del prezzo delle pizze contenenti un ingrediente (parametro: nome ingrediente) 

create procedure IncrementoPrezzo
@NomeIngrediente varchar(30)
as
begin
	begin try

	declare @CodIngrediente int

	select @CodIngrediente = I.Codice
	from Ingrediente I
	where I.Nome = @NomeIngrediente
	
	update Pizza
	set Prezzo = (Prezzo + (Prezzo * 10)/100)
	from PizzaIngrediente PIN
	join Pizza P on P.Codice = PIN.CodPizza
	where PIN.CodIngrediente = @CodIngrediente

	end try
	begin catch

	select ERROR_MESSAGE(), ERROR_LINE()

	end catch
end

exec IncrementoPrezzo 'Bresaola';

select * from Pizza;