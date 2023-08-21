--criando tabela para o cliente(pesoa).
create table pessoa(
	pes_cd_id serial,
	pes_tx_nome varchar(50) not null,
	pes_tx_sobrenome varchar(50)not null,
	pes_tx_cpf varchar(11)unique not null,
	pes_tx_contato varchar(11) not null,
	pes_tx_email varchar (30) not null,
	primary key (pes_cd_id) 
);

--criando tabela para o carro que será alugado.
create table carro(
	car_cd_id serial,
	fk_pes_cd_id integer,
	car_tx_modelo varchar(50) not null,
	car_tx_disponibilidade varchar(10) not null,
	car_tx_marca varchar(20) not null,
	car_tx_placa varchar(7) not null,
	car_tx_cor varchar(30) not null,
	car_tx_preço numeric(5, 2) not null,
	primary key (car_cd_id),
	foreign key(fk_pes_cd_id) references pessoa(pes_cd_id)
);

--inserção de dados na tabela pessoa.
insert into pessoa (pes_tx_nome, pes_tx_sobrenome, pes_tx_cpf, pes_tx_contato, pes_tx_email) values
('Pedroca','Parker','12345678901','2422222222','homiaranha@gmail.com'),
('Guerreira','Xena','77755532187','2411111111','warriorxena@gmail.com'),
('Son','Goku','80000000000','2480000000','saiajeans@gmail.com'),
('monica','dentuca','98612384634','2486478965','donadarua@gmail.com'),
('red','ranger','44455566874','2436952841','horademorfar@gmail.com');

--inserção de dados na tabela carro.
insert into carro (car_tx_modelo, car_tx_disponibilidade, car_tx_marca, car_tx_placa, car_tx_cor, car_tx_preço,fk_pes_cd_id) values
('Esportivo', 'alugado', 'Ferrari', 'ABC1234', 'Vermelho', 150.00,1),
('Esportivo', 'Livre', 'Lamborghini', 'XYZ5678', 'Amarelo', 200.00,2),
('Luxo', 'Livre', 'Mercedes-Benz', 'DEF4321', 'Prata', 100.00,3),
('Esportivo', 'alugado', 'Porsche', 'MNO9876', 'Preto', 180.00,4),
('Luxo', 'Livre', 'Rolls-Royce', 'GHI6543', 'Branco', 250.00,5);


--Esse select lista os carros alugados por cada pessoa, utilizando como base o nome da pessoa para ordenação.
SELECT p.pes_tx_nome, p.pes_tx_sobrenome, c.car_tx_modelo, c.car_tx_disponibilidade
FROM pessoa p
JOIN carro c ON p.pes_cd_id = c.fk_pes_cd_id 
WHERE c.car_tx_disponibilidade = 'alugado'
ORDER BY p.pes_tx_nome;


--Esse select é responsável por contar quantos carros estão disponiveis para aluguel de cada marca.
select c.car_tx_marca, count(*) as total_disponiveis
from carro c
where c.car_tx_disponibilidade = 'Livre'
group by c.car_tx_marca 
order by total_disponiveis desc;

--Esse select mostra a média 
select c.car_tx_cor, AVG(c.car_tx_preço) as media_preço
from carro c
where c.car_tx_disponibilidade = 'Livre'
group by c.car_tx_cor 
order by media_preço;
