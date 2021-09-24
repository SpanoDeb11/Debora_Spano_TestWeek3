create database Pizzeria;

--create table

create table Pizza
(
	Codice int identity(1,1) constraint PK_PIZZA primary key,
	Nome varchar(30) not null,
	Prezzo decimal(6,2) not null check (Prezzo > 0.0)
);

create table Ingrediente
(
	Codice int identity(1,1) constraint PK_INGREDIENTE primary key,
	Nome varchar(30) not null,
	Costo decimal(5,2) not null check (Costo > 0.0),
	PezziInMagazzino int not null check (PezziInMagazzino >= 0)
);

create table PizzaIngrediente
(
	CodPizza int not null,
	CodIngrediente int not null,

	constraint FK_PIZZA foreign key (CodPizza) references Pizza(Codice),
	constraint FK_INGREDIENTE foreign key (CodIngrediente) references Ingrediente(Codice),
	constraint PK_PIZZA_INGREDIENTE primary key(CodPizza, CodIngrediente)
);

--insert table

insert into Pizza values
('Margherita', 5),
('Bufala', 7),
('Diavola', 6),
('Quattro stagioni', 6.50),
('Porcini', 7),
('Dioniso', 8),
('Ortolana', 8),
('Patate e salsiccia', 6),
('Pomodorini', 6),
('Quattro formaggi', 7.50),
('Caprese', 7.50),
('Zeus', 7.50);

insert into Ingrediente values
('Pomodoro', 1.50, 1000),
('Mozzarella', 1, 1500),
('Mozzarella di bufala', 2, 500),
('Spianata piccante', 2.5, 550),
('Funghi', 1.5, 800),
('Carciofi', 1.7, 600),
('Cotto', 1.2, 350),
('Olive', 1.5, 440),
('Funghi porcini', 2.3, 600),
('Stracchino', 1.9, 200),
('Speck', 3.5, 430),
('Rucola', 1.5, 1100),
('Grana', 1.7, 990),
('Verdure di stagione', 2.4, 700), --14
('Patate', 2, 650),
('Salsiccia', 3.2, 720),
('Ricotta', 4.5, 100),
('Provola', 1.8, 300),
('Gorgonzola', 2.1, 400),
('Pomodoro fresco', 1.9, 1000),
('Basilico', 2.2, 970),
('Bresaola', 5.4, 100);
insert into Ingrediente values
('Pomodorini', 2, 440); --23

insert into PizzaIngrediente values
(1, 1),
(1, 2),
(2, 1),
(2, 3),
(3, 1),
(3, 2),
(3, 4),
(4, 1),
(4, 2),
(4, 5),
(4, 6), 
(4, 7),
(4, 8),
(5, 1),
(5, 2),
(5, 9),
(6, 1),
(6, 2),
(6, 10),
(6, 11),
(6, 12),
(6, 13),
(7, 1),
(7, 2),
(7, 14),
(8, 2),
(8, 15),
(8, 16),
(9, 2),
(9, 23),
(9, 17),
(10, 2),
(10, 18),
(10, 19),
(10, 13),
(11, 2),
(11, 20),
(11, 21),
(12, 22),
(12, 12);