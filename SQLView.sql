--View

--create view Menu as
--(select P.Nome, P.Prezzo, string_agg(I.Nome, ', ') Ingredienti
-- from Pizza P
-- join PizzaIngrediente PIN on P.Codice = PIN.CodPizza
-- join Ingrediente I on I.Codice = PIN.CodIngrediente
-- group by P.Nome, P.Prezzo)


create function ConcatenaIngredienti(@NomePizza varchar(30))
returns varchar(max)
as
begin

	declare @StringIngredienti varchar(max)
	set @StringIngredienti = null

	select @StringIngredienti = ISNULL(@StringIngredienti + ', ', '') + I.Nome
	from Ingrediente I
	join PizzaIngrediente PIN on I.Codice = PIN.CodIngrediente
	join Pizza P on P.Codice = PIN.CodPizza
	where P.Nome = @NomePizza

	return @StringIngredienti

end

select dbo.ConcatenaIngredienti('Zeus');

create view Menu as
(select P.Nome, P.Prezzo, dbo.ConcatenaIngredienti(P.Nome) as Ingredienti
 from Pizza P
 join PizzaIngrediente PIN on P.Codice = PIN.CodPizza
 join Ingrediente I on I.Codice = PIN.CodIngrediente
 group by P.Nome, P.Prezzo)

select * from Menu;