
use oficina;
show tables;

insert into cliente(CPF_cliente,nome_cliente,endereco_cliente,contato)
	values	('42522654012', "Mariane Adriana Stefany Moreira", "Rua Paládio 655", "11989809501"),
			("20679701273", "Márcio Vitor de Paula", "Estrada dos Macacos 155", "81995324224"),
            ("07667368651","Raquel Sebastiana da Silva","Rua Margarida Meirelles 1500", "41995411258"),
            ("31831305640", "Camila Fabiana Isadora Assis", "Avenida Vinte e Seis de Julho, 364", "96987441682"),
            ("06271545220", "Martin Carlos Luan Corte Real", "Travessa Paraíso, 64", "93982711938")
    ;

insert into equipeMecanico(nome,especialidade,endereco_mecanico)
	values	("Liz Tânia dos Santos","Montador", "Rua Aníbal Cavalcante Plácido 655"),
			("Aurora Larissa Elaine Silva","Manutenção", "Travessa Castelo Branco 155"),
            ("Heloisa Sandra Andrea Farias","Conserto","Travessa Irmãos Spinelli 1500"),
            ("Fernando Bernardo Felipe da Costa","Manutenção", "Rua Honestino Guimarães, 364"),
            ("Calebe Guilherme Lima","Conserto", "Rua Belo Horizonte, 64");
            
            
insert into veiculo( placa, CPF_clienteVeiculo, id_veiculoResp, desc_servico, marca, modelo, ano)
	values ('MWI9245', '42522654012', 1, "Instalação de som", 'Mahindra', "SCORPIO 2.6 CS/ Chassi TB Dies. CRDe 4x4", 2008),
		('NAO0124', '42522654012', 2, "Vistoria periódica", 'Land Rover', "Range R. EVO DYNAMIQUE BLACK 2.0 Aut. 5p", 2015),
		("HPV0159", "20679701273", 2, "Vistoria periódica", "CHANA", "Cargo CD 1.0 8V 53cv (Pick-Up)", 2014),
		("MSZ8098", "07667368651", 3, "Reparação da lataria", 'ASTON MARTIN', "Vanquish V12 6.0 565cv", 2010),
		('HRN2343', "31831305640", 4, "Troca de óleo", "Pontiac", "Trans-AM 5.7 V8", 1991),
		("CIX8977", "07667368651", 5, "Malfuncionamento do motor", "Mercury", "Sable LS 3.0 V6", 1992)
    ;
    
insert into ordemServico(id_ordemVeiculo, StatusOS, dt_emissao, dt_entrega)
		values (1,'Em análise', 20221103, 20221118),
				(2,'Em operação', 20221027, 20221108),
                (3,'Em análise', 20221030, 20221115),
                (4,'Finalizado', 20221010, 20221101),
                (5,'Em operação', 20221026, 20221107),
                (6,'Em análise', 20221103, 20221118);
                
select * from ordemServico;


insert into pecas(nome_peca, marca_peca, valor)
		values	('Disco de freio','Bosh',30),
				('Oleo do freio','Fremax',20),
				('Pastilha de freio','Varga',100),
				('Vela Aquecedora','Bosh',120),
				('Válvula termostárica','Varga',200)
;
select * from pecas;

insert into servico_maoObra(desc_servico, valor)
		values	('Revisão automóvel',120),
				('Troca de peça',100),
				('Manutenção',100),
				('Reparação',200),
				('Modificação',150)
;

select * from servico_maoObra;

insert into mecanicoOS(id_MOmecanico, id_MOordem)
		values	(1,1),
				(2,2),
				(2,3),
				(3,4),
				(5,5),
                (4,6);
    
insert into maoObraOS(id_OOos, id_OOobra)
		values	(1,5),
				(2,1),
				(5,3),
				(3,1),
				(6,2),
                (4,4),
                (4,1);
                
                
insert into pecaOS(id_POos, id_POpeca, quantidade_peca)
		values	(4,1,default),
				(5,2,2),
				(6,5,default),
				(6,4,3),
                (4,4,default);
                
select * from pecaOS;
-- Queries de teste

-- Quantas ordens foram finalizadas?
select count(id_ordemServico) from ordemServico where StatusOS='Finalizado';

-- Qual o valor de peças foram utilizadas em cada ordem?
                
select id_POos, sum(valor*pecaOS.quantidade_peca) as total_peca from  pecas inner join pecaOS on id_POpeca=id_pecas
														group by id_POos;
    
-- Qual o valor do serviço utilizado em cada ordem?   

select id_OOos, sum(valor) as total_servico from  servico_maoObra inner join maoObraOS on id_OOobra=id_tipoServico
																group by id_OOos;
																								

-- Qual o veiculo mais antigo?
select * from veiculo where ano = (select min(ano) from veiculo);  

-- Quais clientes cadastrados possuem registro de veiculo?
select CPF_cliente, nome_cliente from cliente join veiculo on CPF_cliente = CPF_clienteVeiculo;  

-- Quantos carros cadastrados possuem cada cliente?
select CPF_cliente, nome_cliente, count(placa)  from cliente join veiculo on CPF_cliente = CPF_clienteVeiculo
														group by CPF_cliente;  

-- Qual o tempo medio previsto para completar uma ordem de serviço?
select * from ordemServico;
select avg(datediff(dt_entrega,dt_emissao)) from ordemServico;

-- Quais ordens de serviço demoraram mais para serem realizadas decrescente?
select id_ordemServico, dt_emissao,dt_entrega, datediff(dt_entrega,dt_emissao) as dias_entrega from ordemServico
order by dias_entrega desc;

-- Qual a peça mais cara?
select * from pecas where valor = (select max(valor) from pecas);

-- Qual mecanico possui mais que uma OS ao mesmo tempo?
select * from equipeMecanico;
select * from ordemServico;
select * from veiculo;
select id_mecanico, nome, count(id_veiculoResp) from equipeMecanico inner join veiculo on id_veiculoResp=id_mecanico group by id_mecanico having count(id_veiculoResp)>1;

